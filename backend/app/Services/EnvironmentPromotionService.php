<?php

namespace App\Services;

use App\Models\AuditEvent;
use App\Models\ReleaseItem;
use App\Models\ReleaseItemEnvironmentState;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class EnvironmentPromotionService
{
    /**
     * Update an item's environment state atomically inside a DB transaction
     * and log an AuditEvent.
     */
    public function updateEnvironmentState(
        ReleaseItem $item,
        string $projectEnvironmentId,
        int $statusId,
        string $sourceSummary,
        ?string $confirmedByPersonId = null,
        ?string $confirmedByText = null,
        ?string $notes = null,
        ?string $actorPersonId = null,
        string $actorName = 'Jhon'
    ): ReleaseItemEnvironmentState {
        return DB::transaction(function () use (
            $item, $projectEnvironmentId, $statusId, $sourceSummary,
            $confirmedByPersonId, $confirmedByText, $notes, $actorPersonId, $actorName
        ) {
            $now = Carbon::now();

            $existingState = ReleaseItemEnvironmentState::where('release_item_id', $item->id)
                ->where('project_environment_id', $projectEnvironmentId)
                ->lockForUpdate()
                ->first();

            $oldStatusId = optional($existingState)->status_id;

            if ($existingState) {
                $existingState->update([
                    'status_id' => $statusId,
                    'status_changed_at' => $now,
                    'verified_at' => $now,
                    'confirmed_by_person_id' => $confirmedByPersonId,
                    'confirmed_by_text' => $confirmedByText,
                    'source_summary' => $sourceSummary,
                    'notes' => $notes,
                ]);
                $stateModel = $existingState;
            } else {
                $stateModel = ReleaseItemEnvironmentState::create([
                    'project_id' => $item->project_id,
                    'release_item_id' => $item->id,
                    'project_environment_id' => $projectEnvironmentId,
                    'status_id' => $statusId,
                    'status_changed_at' => $now,
                    'verified_at' => $now,
                    'confirmed_by_person_id' => $confirmedByPersonId,
                    'confirmed_by_text' => $confirmedByText,
                    'source_summary' => $sourceSummary,
                    'notes' => $notes,
                ]);
            }

            // Create Audit Event
            AuditEvent::create([
                'entity_type' => 'release_item',
                'entity_id' => $item->id,
                'event_type' => 'environment_state_changed',
                'changes' => [
                    'project_environment_id' => $projectEnvironmentId,
                    'old_status_id' => $oldStatusId,
                    'new_status_id' => $statusId,
                    'source_summary' => $sourceSummary,
                ],
                'context' => [
                    'notes' => $notes,
                ],
                'actor_person_id' => $actorPersonId,
                'actor_name' => $actorName,
                'occurred_at' => $now,
                'created_at' => $now,
            ]);

            return $stateModel;
        });
    }
}
