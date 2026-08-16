<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('projects', function (Blueprint $table) {
            $table->id();
            $table->string('name', 120);
            $table->string('code', 40)->unique();
            $table->text('description')->nullable();
            $table->foreignId('status_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('owner_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);
            $table->dateTime('deleted_at', 6)->nullable();

            $table->index(['status_id', 'deleted_at']);
            $table->index(['owner_person_id', 'deleted_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('projects');
    }
};
