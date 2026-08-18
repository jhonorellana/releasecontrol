<?php

namespace App\Services;

use App\Models\ReleaseItem;
use Carbon\Carbon;

class HealthCalculatorService
{
    /**
     * Calculate health status for a single ReleaseItem instance.
     *
     * Precedence:
     * 1. Blocked
     * 2. Overdue
     * 3. Needs Follow-up
     * 4. Action Required
     * 5. In Progress
     * 6. On Track
     */
    public function calculateItemHealth(ReleaseItem $item): array
    {
        $today = Carbon::today()->toDateString();
        $reasons = [];

        // Load relationships if not already loaded
        $item->loadMissing([
            'followUps.status',
            'environmentStates.status',
            'environmentStates.projectEnvironment.environment',
            'clientActivation.status',
            'release'
        ]);

        // -------------------------------------------------------------
        // Rank 1: Blocked
        // -------------------------------------------------------------
        $activeBlockers = $item->followUps->filter(function ($f) {
            $statusCode = optional($f->status)->code;
            return $f->is_blocker && !in_array($statusCode, ['completed', 'cancelled']);
        });

        $blockedEnvStates = $item->environmentStates->filter(function ($s) {
            return optional($s->status)->code === 'blocked';
        });

        if ($activeBlockers->isNotEmpty() || $blockedEnvStates->isNotEmpty()) {
            return [
                'code' => 'blocked',
                'label' => 'Blocked',
                'color' => '#EF4444',
                'rank' => 1,
                'reasons' => ['Active blocker or blocked environment state detected.']
            ];
        }

        // -------------------------------------------------------------
        // Rank 2: Overdue
        // -------------------------------------------------------------
        $overdueFollowUps = $item->followUps->filter(function ($f) use ($today) {
            $statusCode = optional($f->status)->code;
            return !in_array($statusCode, ['completed', 'cancelled'])
                && !empty($f->due_date)
                && $f->due_date < $today;
        });

        if ($overdueFollowUps->isNotEmpty()) {
            return [
                'code' => 'overdue',
                'label' => 'Overdue',
                'color' => '#DC2626',
                'rank' => 2,
                'reasons' => ['Open follow-up task past due date.']
            ];
        }

        // -------------------------------------------------------------
        // Rank 3: Needs Follow-up
        // -------------------------------------------------------------
        $prodState = $item->environmentStates->first(function ($s) {
            return optional(optional($s->projectEnvironment)->environment)->code === 'PROD';
        });

        $prodStatusCode = optional(optional($prodState)->status)->code;
        $activationStatusCode = optional(optional($item->clientActivation)->status)->code;

        $hasUnconfirmedProd = ($prodStatusCode === 'unconfirmed');
        $hasUnconfirmedActivation = (in_array($prodStatusCode, ['deployed', 'approved']) && in_array($activationStatusCode, ['unconfirmed', 'inactive']));

        if ($hasUnconfirmedProd || $hasUnconfirmedActivation) {
            return [
                'code' => 'needs_follow_up',
                'label' => 'Needs Follow-up',
                'color' => '#F59E0B',
                'rank' => 3,
                'reasons' => ['PROD deployment exists but client activation or PROD status is unconfirmed.']
            ];
        }

        // -------------------------------------------------------------
        // Rank 4: Action Required
        // -------------------------------------------------------------
        $activeFollowUps = $item->followUps->filter(function ($f) {
            $statusCode = optional($f->status)->code;
            return !in_array($statusCode, ['completed', 'cancelled']);
        });
        $missingNextAction = $activeFollowUps->isEmpty();
        $missingOwner = empty($item->owner_person_id);
        $missingTargetDate = empty($item->target_date);

        if ($missingNextAction || $missingOwner || $missingTargetDate) {
            $reasons = [];
            if ($missingNextAction) $reasons[] = 'Missing active action point';
            if ($missingOwner) $reasons[] = 'Missing owner assignment';
            if ($missingTargetDate) $reasons[] = 'Missing target date';

            return [
                'code' => 'action_required',
                'label' => 'Action Required',
                'color' => '#F97316',
                'rank' => 4,
                'reasons' => $reasons
            ];
        }

        // -------------------------------------------------------------
        // Rank 5: In Progress
        // -------------------------------------------------------------
        $inProgressEnvStates = $item->environmentStates->filter(function ($s) {
            $code = optional($s->status)->code;
            return in_array($code, ['development', 'in_testing', 'code_merging', 'ready_to_promote']);
        });

        if ($inProgressEnvStates->isNotEmpty()) {
            return [
                'code' => 'in_progress',
                'label' => 'In Progress',
                'color' => '#3B82F6',
                'rank' => 5,
                'reasons' => ['Item is undergoing active development, testing, or promotion.']
            ];
        }

        // -------------------------------------------------------------
        // Rank 6: On Track
        // -------------------------------------------------------------
        return [
            'code' => 'on_track',
            'label' => 'On Track',
            'color' => '#10B981',
            'rank' => 6,
            'reasons' => ['All validations clear, work proceeding normally.']
        ];
    }
}
