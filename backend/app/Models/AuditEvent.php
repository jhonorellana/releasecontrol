<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AuditEvent extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'entity_type', 'entity_id', 'event_type', 'changes',
        'context', 'actor_person_id', 'actor_name', 'occurred_at', 'created_at'
    ];

    protected $casts = [
        'changes' => 'array',
        'context' => 'array',
    ];

    public function actor(): BelongsTo
    {
        return $this->belongsTo(Person::class, 'actor_person_id');
    }
}
