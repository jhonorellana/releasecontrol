<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CatalogValue;
use App\Models\Environment;
use App\Models\Project;
use App\Models\ProjectEnvironment;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProjectController extends Controller
{
    public function index(): JsonResponse
    {
        $projects = Project::with([
            'status',
            'owner',
            'modules',
            'projectEnvironments.environment'
        ])->get();

        return response()->json($projects);
    }

    public function show(string $id): JsonResponse
    {
        $project = Project::with([
            'status',
            'owner',
            'modules',
            'releases',
            'projectEnvironments.environment'
        ])->findOrFail($id);

        return response()->json($project);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => 'required|string|max:120',
            'code' => 'required|string|max:40|unique:projects,code',
            'description' => 'nullable|string',
            'status_id' => 'nullable|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
        ]);

        if (!isset($validated['status_id'])) {
            $validated['status_id'] = CatalogValue::where('category', 'project_status')->where('code', 'active')->value('id');
        }

        $project = DB::transaction(function () use ($validated) {
            $proj = Project::create($validated);

            // Initialize default project environments (MOJA, TATU, SITA, PROD)
            $environments = Environment::orderBy('default_sequence')->get();
            foreach ($environments as $env) {
                ProjectEnvironment::create([
                    'project_id' => $proj->id,
                    'environment_id' => $env->id,
                    'sequence' => $env->default_sequence,
                    'is_required' => true,
                    'is_active' => true,
                ]);
            }

            return $proj;
        });

        return response()->json($project->load(['status', 'owner', 'projectEnvironments.environment']), 201);
    }

    public function update(Request $request, string $id): JsonResponse
    {
        $project = Project::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:120',
            'code' => 'sometimes|required|string|max:40|unique:projects,code,' . $id,
            'description' => 'nullable|string',
            'status_id' => 'sometimes|required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
        ]);

        $project->update($validated);

        return response()->json($project->load(['status', 'owner', 'projectEnvironments.environment']));
    }

    public function destroy(string $id): JsonResponse
    {
        $project = Project::findOrFail($id);
        $project->delete();

        return response()->json(['message' => 'Project deleted successfully']);
    }
}
