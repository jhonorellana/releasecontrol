<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('audit_events', function (Blueprint $table) {
            $table->id();
            $table->string('entity_type', 80);
            $table->unsignedBigInteger('entity_id');
            $table->string('event_type', 80);
            $table->json('changes')->nullable();
            $table->json('context')->nullable();
            $table->foreignId('actor_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->string('actor_name', 150);
            $table->dateTime('occurred_at', 6);
            $table->dateTime('created_at', 6);

            $table->index(['entity_type', 'entity_id', 'occurred_at']);
            $table->index(['event_type', 'occurred_at']);
            $table->index(['actor_person_id', 'occurred_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('audit_events');
    }
};
