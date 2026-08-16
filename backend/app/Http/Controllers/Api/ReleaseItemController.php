<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ReleaseItem;
use App\Services\HealthCalculatorService;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ReleaseItemController extends Controller
{
    public function __construct(protected HealthCalculatorService $healthCalculator)
    {
    }

    public function index(Request $request): JsonResponse
    {
        $query = ReleaseItem::with([
            'project', 'module', 'release', 'itemType', 'status', 'priority', 'owner',
            'environmentStates.status', 'environmentStates.projectEnvironment.environment',
            'clientActivation.status', 'clientActivation.confirmedByPerson',
            'followUps.status', 'followUps.priority', 'followUps.owner', 'followUps.contact',
            'evidences.evidenceType'
        ]);

        if ($request->has('project_id')) {
            $query->where('project_id', $request->query('project_id'));
        }

        $items = $query->get()->map(function ($item) {
            $data = $item->toArray();
            $data['health'] = $this->healthCalculator->calculateItemHealth($item);
            return $data;
        });

        return response()->json($items);
    }

    public function show(string $id): JsonResponse
    {
        $item = ReleaseItem::with([
            'project.projectEnvironments.environment', 'module', 'release', 'itemType', 'status', 'priority', 'owner',
            'environmentStates.status', 'environmentStates.confirmedByPerson', 'environmentStates.projectEnvironment.environment',
            'clientActivation.status', 'clientActivation.confirmedByPerson',
            'followUps.status', 'followUps.priority', 'followUps.owner', 'followUps.contact',
            'evidences.evidenceType', 'evidences.createdByPerson'
        ])->findOrFail($id);

        $data = $item->toArray();
        $data['health'] = $this->healthCalculator->calculateItemHealth($item);

        return response()->json($data);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'project_id' => 'required|exists:projects,id',
            'release_id' => 'required|exists:releases,id',
            'module_id' => 'required|exists:modules,id',
            'title' => 'required|string|max:200',
            'description' => 'nullable|string',
            'item_type_id' => 'required|exists:catalog_values,id',
            'status_id' => 'required|exists:catalog_values,id',
            'priority_id' => 'required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
            'jira_key' => 'nullable|string|max:40',
            'jira_url' => 'nullable|url|max:2048',
            'next_action' => 'required|string|max:500',
            'target_date' => 'nullable|date',
        ]);

        $item = ReleaseItem::create($validated);

        return response()->json($item, 217);
    }

    public function update(Request $request, string $id): JsonResponse
    {
        $item = ReleaseItem::findOrFail($id);

        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:200',
            'description' => 'nullable|string',
            'item_type_id' => 'sometimes|required|exists:catalog_values,id',
            'status_id' => 'sometimes|required|exists:catalog_values,id',
            'priority_id' => 'sometimes|required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
            'jira_key' => 'nullable|string|max:40',
            'jira_url' => 'nullable|url|max:2048',
            'next_action' => 'sometimes|required|string|max:500',
            'target_date' => 'nullable|date',
        ]);

        $item->update($validated);

        return response()->json($item);
    }

    public function destroy(string $id): JsonResponse
    {
        $item = ReleaseItem::findOrFail($id);
        $item->delete();

        return response()->json(['message' => 'Item archived successfully']);
    }
}
