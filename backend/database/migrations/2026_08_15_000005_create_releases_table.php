<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('releases', function (Blueprint $table) {
            $table->id();
            $table->foreignId('project_id')->constrained('projects')->onUpdate('restrict')->onDelete('restrict');
            $table->string('name', 150);
            $table->string('code', 60);
            $table->text('scope')->nullable();
            $table->foreignId('status_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('owner_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->date('target_date')->nullable();
            $table->dateTime('started_at', 6)->nullable();
            $table->dateTime('completed_at', 6)->nullable();
            $table->string('release_notes_url', 2048)->nullable();
            $table->text('notes')->nullable();
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);
            $table->dateTime('deleted_at', 6)->nullable();

            $table->unique(['project_id', 'code']);
            $table->index(['project_id', 'status_id', 'target_date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('releases');
    }
};
