<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ReleaseItem;
use App\Services\EnvironmentPromotionService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class EnvironmentStateController extends Controller
{
    public function __construct(protected EnvironmentPromotionService $promotionService)
    {
    }

    public function updateState(Request $request, string $itemId): JsonResponse
    {
        $item = ReleaseItem::findOrFail($itemId);

        $validated = $request->validate([
            'project_environment_id' => 'required|exists:project_environments,id',
            'status_id' => 'required|exists:catalog_values,id',
            'source_summary' => 'required|string|max:500',
            'confirmed_by_person_id' => 'nullable|exists:people,id',
            'confirmed_by_text' => 'nullable|string|max:150',
            'notes' => 'nullable|string',
            'actor_name' => 'nullable|string|max:150',
        ]);

        $state = $this->promotionService->updateEnvironmentState(
            item: $item,
            projectEnvironmentId: $validated['project_environment_id'],
            statusId: $validated['status_id'],
            sourceSummary: $validated['source_summary'],
            confirmedByPersonId: $validated['confirmed_by_person_id'] ?? null,
            confirmedByText: $validated['confirmed_by_text'] ?? null,
            notes: $validated['notes'] ?? null,
            actorPersonId: null,
            actorName: $validated['actor_name'] ?? 'Jhon'
        );

        return response()->json($state->load(['status', 'confirmedByPerson', 'projectEnvironment.environment']));
    }
}
