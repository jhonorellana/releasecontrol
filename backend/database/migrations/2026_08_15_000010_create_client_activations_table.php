<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('client_activations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('release_item_id')->unique()->constrained('release_items')->onUpdate('restrict')->onDelete('restrict');
            $table->foreignId('status_id')->constrained('catalog_values')->onUpdate('restrict')->onDelete('restrict');
            $table->string('scope_type', 30)->default('unknown');
            $table->string('scope_description', 500)->nullable();
            $table->dateTime('activated_at', 6)->nullable();
            $table->dateTime('verified_at', 6);
            $table->foreignId('confirmed_by_person_id')->nullable()->constrained('people')->onUpdate('restrict')->onDelete('set null');
            $table->string('confirmed_by_text', 150)->nullable();
            $table->string('source_summary', 500);
            $table->text('notes')->nullable();
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);

            $table->index(['status_id', 'verified_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('client_activations');
    }
};
