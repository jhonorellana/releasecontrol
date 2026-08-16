<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('release_item_environment_states', function (Blueprint $table) {
            $table->id();
            $table->foreignId('project_id')->constrained('projects')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('release_item_id')->constrained('release_items')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('project_environment_id')->constrained('project_environments')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('status_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->dateTime('status_changed_at', 6);
            $table->dateTime('verified_at', 6);
            $table->foreignId('confirmed_by_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->string('confirmed_by_text', 150)->nullable();
            $table->string('source_summary', 500);
            $table->text('notes')->nullable();
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);

            $table->unique(['release_item_id', 'project_environment_id'], 'item_env_unique');
            $table->index(['project_environment_id', 'status_id'], 'env_status_idx');
            $table->index(['status_id', 'verified_at'], 'status_ver_idx');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('release_item_environment_states');
    }
};
