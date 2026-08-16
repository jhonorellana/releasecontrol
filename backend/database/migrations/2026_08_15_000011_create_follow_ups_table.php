<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('follow_ups', function (Blueprint $table) {
            $table->id();
            $table->foreignId('release_item_id')->constrained('release_items')->onUpdate('restrict')->onDelete('restrict');
            $table->string('action', 500);
            $table->foreignId('status_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('priority_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('owner_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->foreignId('contact_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->date('due_date')->nullable();
            $table->boolean('is_blocker')->default(false);
            $table->text('notes')->nullable();
            $table->text('outcome')->nullable();
            $table->dateTime('completed_at', 6)->nullable();
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);
            $table->dateTime('deleted_at', 6)->nullable();

            $table->index(['status_id', 'due_date']);
            $table->index(['owner_person_id', 'status_id', 'due_date']);
            $table->index(['release_item_id', 'status_id']);
            $table->index(['is_blocker', 'status_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('follow_ups');
    }
};
