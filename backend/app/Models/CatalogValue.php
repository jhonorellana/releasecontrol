<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CatalogValue extends Model
{
    protected $table = 'catalog_values';
    protected $fillable = ['category', 'code', 'label', 'description', 'sort_order', 'color', 'is_system', 'is_active'];
    protected $casts = [
        'is_system' => 'boolean',
        'is_active' => 'boolean',
        'sort_order' => 'integer',
    ];
}
