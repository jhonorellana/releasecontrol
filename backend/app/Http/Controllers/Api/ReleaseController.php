<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CatalogValue;
use App\Models\Release;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ReleaseController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = Release::with(['project', 'status', 'owner']);

        if ($request->has('project_id')) {
            $query->where('project_id', $request->query('project_id'));
        }

        $releases = $query->orderBy('created_at', 'desc')->get();

        return response()->json($releases);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'project_id' => 'required|exists:projects,id',
            'name' => 'required|string|max:150',
            'code' => 'required|string|max:60',
            'scope' => 'nullable|string|max:500',
            'status_id' => 'nullable|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
            'target_date' => 'nullable|date',
            'release_notes_url' => 'nullable|string|max:2048',
            'notes' => 'nullable|string|max:500',
        ]);

        if (!isset($validated['status_id'])) {
            $validated['status_id'] = CatalogValue::where('category', 'release_status')->where('code', 'in_progress')->value('id');
        }

        $release = Release::create($validated);

        return response()->json($release->load(['project', 'status', 'owner']), 201);
    }

    public function update(Request $request, string $id): JsonResponse
    {
        $release = Release::findOrFail($id);

        $validated = $request->validate([
            'project_id' => 'sometimes|required|exists:projects,id',
            'name' => 'sometimes|required|string|max:150',
            'code' => 'sometimes|required|string|max:60',
            'scope' => 'nullable|string|max:500',
            'status_id' => 'sometimes|required|exists:catalog_values,id',
            'owner_person_id' => 'nullable|exists:people,id',
            'target_date' => 'nullable|date',
            'release_notes_url' => 'nullable|string|max:2048',
            'notes' => 'nullable|string|max:500',
        ]);

        $release->update($validated);

        return response()->json($release->load(['project', 'status', 'owner']));
    }

    public function destroy(string $id): JsonResponse
    {
        $release = Release::findOrFail($id);
        $release->delete();

        return response()->json(['message' => 'Release deleted successfully']);
    }
}
