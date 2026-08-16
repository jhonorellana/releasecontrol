<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditEvent;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AuditEventController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = AuditEvent::with('actor');

        if ($request->has('entity_id')) {
            $query->where('entity_id', $request->query('entity_id'));
        }

        if ($request->has('entity_type')) {
            $query->where('entity_type', $request->query('entity_type'));
        }

        $events = $query->orderBy('occurred_at', 'desc')->get();

        return response()->json($events);
    }
}
