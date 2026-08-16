<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Person;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PersonController extends Controller
{
    public function index(): JsonResponse
    {
        $people = Person::where('is_active', true)->orderBy('display_name', 'asc')->get();
        return response()->json($people);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'display_name' => 'required|string|max:150',
            'email' => 'nullable|email|max:190',
            'role_title' => 'nullable|string|max:120',
            'team' => 'nullable|string|max:120',
            'is_active' => 'boolean',
        ]);

        $person = Person::create($validated);

        return response()->json($person, 201);
    }

    public function update(Request $request, string $id): JsonResponse
    {
        $person = Person::findOrFail($id);

        $validated = $request->validate([
            'display_name' => 'sometimes|required|string|max:150',
            'email' => 'nullable|email|max:190',
            'role_title' => 'nullable|string|max:120',
            'team' => 'nullable|string|max:120',
            'is_active' => 'boolean',
        ]);

        $person->update($validated);

        return response()->json($person);
    }

    public function destroy(string $id): JsonResponse
    {
        $person = Person::findOrFail($id);
        $person->delete();

        return response()->json(['message' => 'Person deleted successfully']);
    }
}
