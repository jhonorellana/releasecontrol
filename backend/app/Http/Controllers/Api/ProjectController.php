<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Project;
use Illuminate\Http\JsonResponse;

class ProjectController extends Controller
{
    public function index(): JsonResponse
    {
        $projects = Project::with([
            'status', 'owner', 'modules.status', 'modules.owner',
            'releases.status', 'releases.owner',
            'projectEnvironments.environment'
        ])->get();

        return response()->json($projects);
    }

    public function show(string $id): JsonResponse
    {
        $project = Project::with([
            'status', 'owner', 'modules.status', 'modules.owner',
            'releases.status', 'releases.owner',
            'projectEnvironments.environment'
        ])->findOrFail($id);

        return response()->json($project);
    }
}
