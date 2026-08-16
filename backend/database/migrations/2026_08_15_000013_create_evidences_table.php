<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('evidences', function (Blueprint $table) {
            $table->id();
            $table->foreignId('release_item_id')->constrained('release_items')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('audit_event_id')->nullable()->constrained('audit_events')->onUpdate('restrict')->onDelete('set null');
            $table->foreignId('evidence_type_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->string('title', 200);
            $table->string('reference_url', 2048)->nullable();
            $table->string('local_path', 1000)->nullable();
            $table->text('description')->nullable();
            $table->dateTime('captured_at', 6);
            $table->foreignId('created_by_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);

            $table->index(['release_item_id', 'captured_at']);
            $table->index('audit_event_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('evidences');
    }
};
