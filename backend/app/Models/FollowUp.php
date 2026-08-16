<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class FollowUp extends Model
{
    use SoftDeletes;

    protected $table = 'follow_ups';
    protected $fillable = [
        'release_item_id', 'action', 'status_id', 'priority_id',
        'owner_person_id', 'contact_person_id', 'due_date',
        'is_blocker', 'notes', 'outcome', 'completed_at'
    ];

    protected $casts = [
        'is_blocker' => 'boolean',
    ];

    public function releaseItem(): BelongsTo
    {
        return $this->belongsTo(ReleaseItem::class);
    }

    public function status(): BelongsTo
    {
        return $this->belongsTo(CatalogValue::class, 'status_id');
    }

    public function priority(): BelongsTo
    {
        return $this->belongsTo(CatalogValue::class, 'priority_id');
    }

    public function owner(): BelongsTo
    {
        return $this->belongsTo(Person::class, 'owner_person_id');
    }

    public function contact(): BelongsTo
    {
        return $this->belongsTo(Person::class, 'contact_person_id');
    }
}
