<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('people', function (Blueprint $table) {
            $table->id();
            $table->string('display_name', 150);
            $table->string('email', 190)->nullable()->unique();
            $table->string('role_title', 120)->nullable();
            $table->string('team', 120)->nullable();
            $table->boolean('is_active')->default(true);
            $table->dateTime('created_at', 6);
            $table->dateTime('updated_at', 6);
            $table->dateTime('deleted_at', 6)->nullable();

            $table->index('display_name');
            $table->index('is_active');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('people');
    }
};
