<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ReleaseItemEnvironmentState extends Model
{
    protected $table = 'release_item_environment_states';
    protected $fillable = [
        'project_id', 'release_item_id', 'project_environment_id', 'status_id',
        'status_changed_at', 'verified_at', 'confirmed_by_person_id',
        'confirmed_by_text', 'source_summary', 'notes'
    ];

    public function releaseItem(): BelongsTo
    {
        return $this->belongsTo(ReleaseItem::class);
    }

    public function projectEnvironment(): BelongsTo
    {
        return $this->belongsTo(ProjectEnvironment::class);
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
