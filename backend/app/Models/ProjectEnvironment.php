<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProjectEnvironment extends Model
{
    protected $fillable = ['project_id', 'environment_id', 'sequence', 'is_required', 'is_active'];
    protected $casts = [
        'is_required' => 'boolean',
        'is_active' => 'boolean',
        'sequence' => 'integer',
    ];

    public function project(): BelongsTo
    {
        return $this->belongsTo(Project::class);
    }

    public function environment(): BelongsTo
    {
        return $this->belongsTo(Environment::class);
    }
}
