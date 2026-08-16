<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ClientActivation extends Model
{
    protected $fillable = [
        'release_item_id', 'status_id', 'scope_type', 'scope_description',
        'activated_at', 'verified_at', 'confirmed_by_person_id',
        'confirmed_by_text', 'source_summary', 'notes'
    ];

    public function releaseItem(): BelongsTo
    {
        return $this->belongsTo(ReleaseItem::class);
    }

    public function status(): BelongsTo
    {
        return $this->belongsTo(CatalogValue::class, 'status_id');
    }

    public function confirmedByPerson(): BelongsTo
    {
        return $this->belongsTo(Person::class, 'confirmed_by_person_id');
    }
}
