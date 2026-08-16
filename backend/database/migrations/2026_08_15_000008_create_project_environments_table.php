<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('project_environments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('project_id')->constrained('projects')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('environment_id')->constrained('environments')->onUpdate('restrict')->onDelete('restrict');
            $table->unsignedSmallInteger('sequence');
            $table->boolean('is_required')->default(true);
            $table->boolean('is_active')->default(true);
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);

            $table->unique(['project_id', 'environment_id']);
            $table->unique(['project_id', 'sequence']);
            $table->index(['project_id', 'is_active', 'sequence']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('project_environments');
    }
};
