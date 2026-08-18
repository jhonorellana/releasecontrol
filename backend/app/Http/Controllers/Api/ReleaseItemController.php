<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditEvent;
use App\Models\CatalogValue;
use App\Models\ClientActivation;
use App\Models\ProjectEnvironment;
use App\Models\ReleaseItem;
use App\Models\ReleaseItemEnvironmentState;
use App\Services\HealthCalculatorService;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReleaseItemController extends Controller
{
    protected HealthCalculatorService $healthCalculator;

    public function __construct(HealthCalculatorService $healthCalculator)
    {
        $this->healthCalculator = $healthCalculator;
    }

    public function index(Request $request): JsonResponse
    {
        $query = ReleaseItem::with([
            'project',
            'module',
            'release',
            'itemType',
            'status',
            'priority',
            'owner',
            'environmentStates.status',
            'environmentStates.confirmedByPerson',
            'environmentStates.projectEnvironment.environment',
            'clientActivation.status',
            'clientActivation.confirmedByPerson',
            'followUps.status',
            'followUps.priority',
            'followUps.owner',
            'followUps.contact'
        ]);

        if ($request->has('project_id')) {
            $query->whereHas('module', function ($q) use ($request) {
                $q->where('project_id', $request->query('project_id'));
            });
        }

        if ($request->has('release_id')) {
            $query->where('release_id', $request->query('release_id'));
        }

        $items = $query->get()->map(function ($item) {
            $item->health = $this->healthCalculator->calculateItemHealth($item);
            return $item;
        });

        return response()->json($items);
    }

    public function show(string $id): JsonResponse
    {
        $item = ReleaseItem::with([
            'project',
            'module',
            'release',
            'itemType',
            'status',
            'priority',
            'owner',
            'environmentStates.status',
            'environmentStates.confirmedByPerson',
            'environmentStates.projectEnvironment.environment',
            'clientActivation.status',
            'clientActivation.confirmedByPerson',
            'followUps.status',
            'followUps.priority',
            'followUps.owner',
            'followUps.contact'
        ])->findOrFail($id);

        $item->health = $this->healthCalculator->calculateItemHealth($item);

        return response()->json($item);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'release_id' => 'required|exists:releases,id',
            'module_id' => 'required|exists:modules,id',
            'title' => 'required|string|max:200',
            'description' => 'nullable|string',
            'item_type_id' => 'required|exists:catalog_values,id',
            'status_id' => 'nullable|exists:catalog_values,id',
            'priority_id' => 'required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
            'jira_key' => 'nullable|string|max:40',
            'jira_url' => 'nullable|url|max:2048',
            'target_date' => 'nullable|date',
        ]);

        if (!isset($validated['status_id'])) {
            $validated['status_id'] = CatalogValue::where('category', 'release_item_status')->where('code', 'in_progress')->value('id');
        }

        $item = DB::transaction(function () use ($validated) {
            $newItem = ReleaseItem::create($validated);

            $notReachedStatusId = CatalogValue::where('category', 'environment_state')->where('code', 'not_reached')->value('id');
            $naActivationStatusId = CatalogValue::where('category', 'activation_status')->where('code', 'not_applicable')->value('id');
            $now = Carbon::now();
            $projectId = $newItem->module->project_id;

            // Initialize environment states for project environments
            $projectEnvironments = ProjectEnvironment::where('project_id', $projectId)->get();
            foreach ($projectEnvironments as $penv) {
                ReleaseItemEnvironmentState::create([
                    'project_id' => $projectId,
                    'release_item_id' => $newItem->id,
                    'project_environment_id' => $penv->id,
                    'status_id' => $notReachedStatusId,
                    'status_changed_at' => $now,
                    'verified_at' => $now,
                    'confirmed_by_text' => 'Initial Creation',
                    'source_summary' => 'Item initial creation',
                ]);
            }

            // Initialize client activation record
            ClientActivation::create([
                'release_item_id' => $newItem->id,
                'status_id' => $naActivationStatusId,
                'scope_type' => 'not_applicable',
                'verified_at' => $now,
                'confirmed_by_text' => 'Initial Creation',
                'source_summary' => 'Item initial creation',
            ]);

            // Create initial Audit Event
            AuditEvent::create([
                'entity_type' => 'release_item',
                'entity_id' => $newItem->id,
                'event_type' => 'item_created',
                'changes' => ['title' => $newItem->title],
                'actor_name' => 'Jhon',
                'occurred_at' => $now,
                'created_at' => $now,
            ]);

            return $newItem;
        });

        return response()->json($item->load([
            'project', 'module', 'release', 'itemType', 'status', 'priority', 'owner',
            'environmentStates.status', 'environmentStates.projectEnvironment.environment', 'clientActivation.status'
        ]), 201);
    }

    public function update(Request $request, string $id): JsonResponse
    {
        $item = ReleaseItem::findOrFail($id);

        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:200',
            'description' => 'nullable|string',
            'module_id' => 'sometimes|required|exists:modules,id',
            'release_id' => 'sometimes|required|exists:releases,id',
            'item_type_id' => 'sometimes|required|exists:catalog_values,id',
            'status_id' => 'sometimes|required|exists:catalog_values,id',
            'priority_id' => 'sometimes|required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
            'jira_key' => 'nullable|string|max:40',
            'jira_url' => 'nullable|url|max:2048',
            'target_date' => 'nullable|date',
        ]);

        $item->update($validated);

        return response()->json($item->load([
            'project', 'module', 'release', 'itemType', 'status', 'priority', 'owner'
        ]));
    }

    public function destroy(string $id): JsonResponse
    {
        $item = ReleaseItem::findOrFail($id);
        $item->delete();

        return response()->json(['message' => 'Release unit deleted successfully']);
    }
}
