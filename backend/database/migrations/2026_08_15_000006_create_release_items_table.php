<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('release_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('project_id')->constrained('projects')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('release_id')->constrained('releases')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('module_id')->constrained('modules')->onUpdate('restrict')->onDelete('restrict');
            $table->string('title', 200);
            $table->text('description')->nullable();
            $table->foreignId('item_type_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('status_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('priority_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('owner_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->string('jira_key', 40)->nullable();
            $table->string('jira_url', 2048)->nullable();
            $table->string('next_action', 500)->nullable();
            $table->date('target_date')->nullable();
            $table->dateTime('closed_at', 6)->nullable();
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);
            $table->dateTime('deleted_at', 6)->nullable();

            $table->index(['release_id', 'status_id']);
            $table->index(['module_id', 'status_id']);
            $table->index(['project_id', 'priority_id', 'target_date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('release_items');
    }
};
