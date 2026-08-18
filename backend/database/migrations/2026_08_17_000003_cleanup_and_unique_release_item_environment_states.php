<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
use App\Models\ReleaseItem;
use App\Models\ReleaseItemEnvironmentState;
use App\Models\ProjectEnvironment;
use App\Models\CatalogValue;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. Clean up mismatched environment states
        $items = ReleaseItem::with(['module'])->get();
        $notReachedStatusId = CatalogValue::where('category', 'environment_state')->where('code', 'not_reached')->value('id');

        foreach ($items as $item) {
            $correctProjId = $item->module ? $item->module->project_id : null;
            if (!$correctProjId) continue;

            // Delete states where project_environment belongs to a different project
            $states = ReleaseItemEnvironmentState::with('projectEnvironment')->where('release_item_id', $item->id)->get();
            foreach ($states as $st) {
                if ($st->projectEnvironment && $st->projectEnvironment->project_id !== $correctProjId) {
                    $st->delete();
                }
            }

            // Ensure valid project environments exist
            $validProjEnvs = ProjectEnvironment::where('project_id', $correctProjId)->get();
            foreach ($validProjEnvs as $pe) {
                $exists = ReleaseItemEnvironmentState::where('release_item_id', $item->id)
                    ->where('project_environment_id', $pe->id)
                    ->exists();

                if (!$exists) {
                    ReleaseItemEnvironmentState::create([
                        'project_id' => $correctProjId,
                        'release_item_id' => $item->id,
                        'project_environment_id' => $pe->id,
                        'status_id' => $notReachedStatusId,
                        'status_changed_at' => now(),
                        'verified_at' => now(),
                        'confirmed_by_text' => 'Initial Creation',
                        'source_summary' => 'Item initial creation'
                    ]);
                }
            }
        }

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
    }
};
