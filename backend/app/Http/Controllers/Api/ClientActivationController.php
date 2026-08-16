<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditEvent;
use App\Models\ClientActivation;
use App\Models\ReleaseItem;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ClientActivationController extends Controller
{
    public function updateActivation(Request $request, string $itemId): JsonResponse
    {
        $item = ReleaseItem::findOrFail($itemId);

        $validated = $request->validate([
            'status_id' => 'required|exists:catalog_values,id',
            'scope_type' => 'required|string|in:all,group,plan,not_applicable,unknown',
            'scope_description' => 'nullable|string|max:500',
            'activated_at' => 'nullable|date',
            'source_summary' => 'required|string|max:500',
            'confirmed_by_person_id' => 'nullable|exists:people,id',
            'confirmed_by_text' => 'nullable|string|max:150',
            'notes' => 'nullable|string',
            'actor_name' => 'nullable|string|max:150',
        ]);

        $activation = DB::transaction(function () use ($item, $validated) {
            $now = Carbon::now();

            $existing = ClientActivation::where('release_item_id', $item->id)->first();
            $oldStatusId = optional($existing)->status_id;

            if ($existing) {
                $existing->update([
                    'status_id' => $validated['status_id'],
                    'scope_type' => $validated['scope_type'],
                    'scope_description' => $validated['scope_description'] ?? null,
                    'activated_at' => $validated['activated_at'] ?? null,
                    'verified_at' => $now,
                    'confirmed_by_person_id' => $validated['confirmed_by_person_id'] ?? null,
                    'confirmed_by_text' => $validated['confirmed_by_text'] ?? null,
                    'source_summary' => $validated['source_summary'],
                    'notes' => $validated['notes'] ?? null,
                ]);
                $record = $existing;
            } else {
                $record = ClientActivation::create([
                    'release_item_id' => $item->id,
                    'status_id' => $validated['status_id'],
                    'scope_type' => $validated['scope_type'],
                    'scope_description' => $validated['scope_description'] ?? null,
                    'activated_at' => $validated['activated_at'] ?? null,
                    'verified_at' => $now,
                    'confirmed_by_person_id' => $validated['confirmed_by_person_id'] ?? null,
                    'confirmed_by_text' => $validated['confirmed_by_text'] ?? null,
                    'source_summary' => $validated['source_summary'],
                    'notes' => $validated['notes'] ?? null,
                ]);
            }

            AuditEvent::create([
                'entity_type' => 'client_activation',
                'entity_id' => $item->id,
                'event_type' => 'client_activation_changed',
                'changes' => [
                    'old_status_id' => $oldStatusId,
                    'new_status_id' => $validated['status_id'],
                    'scope_type' => $validated['scope_type'],
                    'source_summary' => $validated['source_summary'],
                ],
                'context' => [
                    'notes' => $validated['notes'] ?? null,
                ],
                'actor_person_id' => null,
                'actor_name' => $validated['actor_name'] ?? 'Jhon',
                'occurred_at' => $now,
                'created_at' => $now,
            ]);

            return $record;
        });

        return response()->json($activation->load(['status', 'confirmedByPerson']));
    }
}
