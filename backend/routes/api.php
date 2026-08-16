<?php

use App\Http\Controllers\Api\AuditEventController;
use App\Http\Controllers\Api\CatalogController;
use App\Http\Controllers\Api\ClientActivationController;
use App\Http\Controllers\Api\DashboardController;
use App\Http\Controllers\Api\EnvironmentStateController;
use App\Http\Controllers\Api\FollowUpController;
use App\Http\Controllers\Api\ProjectController;
use App\Http\Controllers\Api\ReleaseItemController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes — Project and Release Control System
|--------------------------------------------------------------------------
*/

Route::get('/dashboard', [DashboardController::class, 'index']);
Route::get('/catalogs', [CatalogController::class, 'index']);

Route::get('/projects', [ProjectController::class, 'index']);
Route::get('/projects/{id}', [ProjectController::class, 'show']);

Route::get('/release-items', [ReleaseItemController::class, 'index']);
Route::get('/release-items/{id}', [ReleaseItemController::class, 'show']);
Route::post('/release-items', [ReleaseItemController::class, 'store']);
Route::put('/release-items/{id}', [ReleaseItemController::class, 'update']);
Route::delete('/release-items/{id}', [ReleaseItemController::class, 'destroy']);

Route::post('/release-items/{id}/environment-states', [EnvironmentStateController::class, 'updateState']);
Route::post('/release-items/{id}/client-activation', [ClientActivationController::class, 'updateActivation']);

Route::get('/follow-ups', [FollowUpController::class, 'index']);
Route::post('/follow-ups', [FollowUpController::class, 'store']);
Route::put('/follow-ups/{id}', [FollowUpController::class, 'update']);
Route::delete('/follow-ups/{id}', [FollowUpController::class, 'destroy']);

Route::get('/audit-events', [AuditEventController::class, 'index']);
