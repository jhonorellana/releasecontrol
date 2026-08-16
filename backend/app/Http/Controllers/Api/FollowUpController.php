<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditEvent;
use App\Models\CatalogValue;
use App\Models\FollowUp;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FollowUpController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = FollowUp::with(['releaseItem.project', 'releaseItem.module', 'status', 'priority', 'owner', 'contact']);

        if ($request->has('status')) {
            $query->whereHas('status', function ($q) use ($request) {
                $q->where('code', $request->query('status'));
            });
        }

        if ($request->has('is_blocker')) {
            $query->where('is_blocker', filter_var($request->query('is_blocker'), FILTER_VALIDATE_BOOLEAN));
        }

        $followUps = $query->orderBy('due_date', 'asc')->get();

        return response()->json($followUps);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'release_item_id' => 'required|exists:release_items,id',
            'action' => 'required|string|max:500',
            'status_id' => 'required|exists:catalog_values,id',
            'priority_id' => 'required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
            'contact_person_id' => 'nullable|exists:people,id',
            'due_date' => 'nullable|date',
            'is_blocker' => 'boolean',
            'notes' => 'nullable|string',
        ]);

        $followUp = FollowUp::create($validated);

        return response()->json($followUp->load(['status', 'priority', 'owner', 'contact']), 201);
    }

    public function update(Request $request, string $id): JsonResponse
    {
        $followUp = FollowUp::findOrFail($id);

        $validated = $request->validate([
            'action' => 'sometimes|required|string|max:500',
            'status_id' => 'sometimes|required|exists:catalog_values,id',
            'priority_id' => 'sometimes|required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
            'contact_person_id' => 'nullable|exists:people,id',
            'due_date' => 'nullable|date',
            'is_blocker' => 'boolean',
            'notes' => 'nullable|string',
            'outcome' => 'nullable|string',
        ]);

        DB::transaction(function () use ($followUp, $validated) {
            $oldStatusId = $followUp->status_id;
            $completedStatusId = CatalogValue::where('category', 'follow_up_status')->where('code', 'completed')->value('id');

            if (isset($validated['status_id']) && $validated['status_id'] == $completedStatusId && $oldStatusId != $completedStatusId) {
                $validated['completed_at'] = Carbon::now();
            }

            $followUp->update($validated);

            AuditEvent::create([
                'entity_type' => 'follow_up',
                'entity_id' => $followUp->id,
                'event_type' => 'follow_up_updated',
                'changes' => [
                    'old_status_id' => $oldStatusId,
                    'new_status_id' => $followUp->status_id,
                    'action' => $followUp->action,
                ],
                'context' => [
                    'outcome' => $validated['outcome'] ?? null,
                ],
                'actor_person_id' => null,
                'actor_name' => 'Jhon',
                'occurred_at' => Carbon::now(),
                'created_at' => Carbon::now(),
            ]);
        });

        return response()->json($followUp->load(['status', 'priority', 'owner', 'contact']));
    }

    public function destroy(string $id): JsonResponse
    {
        $followUp = FollowUp::findOrFail($id);
        $followUp->delete();

        return response()->json(['message' => 'Follow-up deleted successfully']);
    }
}
