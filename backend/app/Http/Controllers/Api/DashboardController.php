<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\FollowUp;
use App\Models\Project;
use App\Models\ReleaseItem;
use App\Services\HealthCalculatorService;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;

class DashboardController extends Controller
{
    public function __construct(protected HealthCalculatorService $healthCalculator)
    {
    }

    public function index(): JsonResponse
    {
        $today = Carbon::today()->toDateString();

        // 1. Projects & items
        $projects = Project::with(['modules', 'releases', 'projectEnvironments.environment'])->get();
        $items = ReleaseItem::with([
            'project', 'module', 'release', 'itemType', 'status', 'priority', 'owner',
            'environmentStates.status', 'environmentStates.projectEnvironment.environment',
            'clientActivation.status', 'followUps.status', 'followUps.owner', 'followUps.contact'
        ])->get();

        // 2. Metrics
        $totalItems = $items->count();

        $inProductionCount = $items->filter(function ($item) {
            $prodState = $item->environmentStates->first(function ($s) {
                return optional(optional($s->projectEnvironment)->environment)->code === 'PROD';
            });
            $code = optional(optional($prodState)->status)->code;
            return in_array($code, ['deployed', 'approved']);
        })->count();

        $needsFollowUpCount = $items->filter(function ($item) {
            $health = $this->healthCalculator->calculateItemHealth($item);
            return $health['code'] === 'needs_follow_up';
        })->count();

        $openActionsCount = FollowUp::whereNotIn('status_id', function ($q) {
            $q->select('id')->from('catalog_values')->whereIn('code', ['completed', 'cancelled']);
        })->count();

        // 3. Health breakdown per item
        $itemsWithHealth = $items->map(function ($item) {
            $health = $this->healthCalculator->calculateItemHealth($item);
            $itemData = $item->toArray();
            $itemData['health'] = $health;
            return $itemData;
        });

        // 4. Overdue follow ups
        $overdueFollowUps = FollowUp::with(['releaseItem', 'status', 'priority', 'owner', 'contact'])
            ->where('due_date', '<', $today)
            ->whereNotIn('status_id', function ($q) {
                $q->select('id')->from('catalog_values')->whereIn('code', ['completed', 'cancelled']);
            })
            ->get();

        return response()->json([
            'metrics' => [
                'total_release_units' => $totalItems,
                'in_production' => $inProductionCount,
                'needs_follow_up' => $needsFollowUpCount,
                'open_actions' => $openActionsCount,
            ],
            'projects' => $projects,
            'items' => $itemsWithHealth,
            'overdue_follow_ups' => $overdueFollowUps,
            'last_updated_at' => Carbon::now()->toIso8601String(),
        ]);
    }
}
