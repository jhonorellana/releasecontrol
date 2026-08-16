<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CatalogValue;
use App\Models\Module;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ModuleController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = Module::with(['project', 'status', 'owner']);

        if ($request->has('project_id')) {
            $query->where('project_id', $request->query('project_id'));
        }

        $modules = $query->orderBy('name', 'asc')->get();

        return response()->json($modules);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'project_id' => 'required|exists:projects,id',
            'name' => 'required|string|max:150',
            'code' => 'required|string|max:50',
            'description' => 'nullable|string',
            'status_id' => 'nullable|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
        ]);

        if (!isset($validated['status_id'])) {
            $validated['status_id'] = CatalogValue::where('category', 'module_status')->where('code', 'active')->value('id');
        }

        $module = Module::create($validated);

        return response()->json($module->load(['project', 'status', 'owner']), 201);
    }

    public function update(Request $request, string $id): JsonResponse
    {
        $module = Module::findOrFail($id);

        $validated = $request->validate([
            'project_id' => 'sometimes|required|exists:projects,id',
            'name' => 'sometimes|required|string|max:150',
            'code' => 'sometimes|required|string|max:50',
            'description' => 'nullable|string|max:500',
            'status_id' => 'sometimes|required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
        ]);

        $module->update($validated);

        return response()->json($module->load(['project', 'status', 'owner']));
    }

    public function destroy(string $id): JsonResponse
    {
        $module = Module::findOrFail($id);
        $module->delete();

        return response()->json(['message' => 'Module deleted successfully']);
    }
}
