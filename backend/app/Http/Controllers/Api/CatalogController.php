<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CatalogValue;
use App\Models\Environment;
use App\Models\Person;
use Illuminate\Http\JsonResponse;

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
}
