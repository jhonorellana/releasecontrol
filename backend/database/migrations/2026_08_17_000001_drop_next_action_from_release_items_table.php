<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('release_items', function (Blueprint $table) {
            if (Schema::hasColumn('release_items', 'next_action')) {
                $table->dropColumn('next_action');
            }
        });
    }

    public function down(): void
    {
        Schema::table('release_items', function (Blueprint $table) {
            $table->text('next_action')->nullable();
        });
    }
};
