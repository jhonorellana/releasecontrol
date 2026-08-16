<?php

use App\Http\Controllers\Api\AuditEventController;
use App\Http\Controllers\Api\CatalogController;
use App\Http\Controllers\Api\ClientActivationController;
use App\Http\Controllers\Api\DashboardController;
use App\Http\Controllers\Api\EnvironmentStateController;
use App\Http\Controllers\Api\FollowUpController;
use App\Http\Controllers\Api\ModuleController;
use App\Http\Controllers\Api\PersonController;
use App\Http\Controllers\Api\ProjectController;
use App\Http\Controllers\Api\ReleaseController;
use App\Http\Controllers\Api\ReleaseItemController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes — Project & Release Control System
|--------------------------------------------------------------------------
*/

Route::get('/dashboard', [DashboardController::class, 'index']);
Route::get('/catalogs', [CatalogController::class, 'index']);
Route::post('/catalogs/values', [CatalogController::class, 'storeValue']);
Route::put('/catalogs/values/{id}', [CatalogController::class, 'updateValue']);
Route::delete('/catalogs/values/{id}', [CatalogController::class, 'destroyValue']);

Route::apiResource('projects', ProjectController::class);
Route::apiResource('modules', ModuleController::class);
Route::apiResource('releases', ReleaseController::class);
Route::apiResource('release-items', ReleaseItemController::class);
Route::apiResource('people', PersonController::class);
Route::apiResource('follow-ups', FollowUpController::class);

Route::post('/release-items/{id}/environment-states', [EnvironmentStateController::class, 'updateState']);
Route::post('/release-items/{id}/client-activation', [ClientActivationController::class, 'updateActivation']);

Route::get('/audit-events', [AuditEventController::class, 'index']);
