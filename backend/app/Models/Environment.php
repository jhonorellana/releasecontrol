<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Environment extends Model
{
    protected $fillable = ['code', 'name', 'description', 'default_sequence', 'is_active'];
    protected $casts = [
        'is_active' => 'boolean',
        'default_sequence' => 'integer',
    ];
}
