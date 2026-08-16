<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Person extends Model
{
    use SoftDeletes;

    protected $table = 'people';
    protected $fillable = ['display_name', 'email', 'role_title', 'team', 'is_active'];
    protected $casts = [
        'is_active' => 'boolean',
    ];
}
