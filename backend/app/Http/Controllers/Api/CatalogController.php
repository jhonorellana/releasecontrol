<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CatalogValue;
use App\Models\Environment;
use App\Models\Person;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CatalogController extends Controller
{
    public function index(): JsonResponse
    {
        $catalogs = CatalogValue::where('is_active', true)
            ->orderBy('category')
            ->orderBy('sort_order')
            ->get()
            ->groupBy('category');

        $environments = Environment::where('is_active', true)
            ->orderBy('default_sequence')
            ->get();

        $people = Person::where('is_active', true)
            ->orderBy('display_name')
            ->get();

        return response()->json([
            'catalogs' => $catalogs,
            'environments' => $environments,
            'people' => $people,
        ]);
    }

    public function storeValue(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'category' => 'required|string|max:60',
            'code' => 'required|string|max:60',
            'label' => 'required|string|max:100',
            'description' => 'nullable|string',
            'sort_order' => 'integer',
            'color' => 'nullable|string|max:30',
        ]);

        $value = CatalogValue::create(array_merge($validated, [
            'is_system' => false,
            'is_active' => true,
        ]));

        return response()->json($value, 201);
    }

    public function updateValue(Request $request, string $id): JsonResponse
    {
        $value = CatalogValue::findOrFail($id);

        $validated = $request->validate([
            'label' => 'sometimes|required|string|max:100',
            'description' => 'nullable|string',
            'sort_order' => 'sometimes|integer',
            'color' => 'nullable|string|max:30',
            'is_active' => 'sometimes|boolean',
        ]);

        $value->update($validated);

        return response()->json($value);
    }

    public function destroyValue(string $id): JsonResponse
    {
        $value = CatalogValue::findOrFail($id);
        if ($value->is_system) {
            return response()->json(['error' => 'Cannot delete system catalog values'], 422);
        }

        $value->delete();

        return response()->json(['message' => 'Catalog value deleted successfully']);
    }
}
