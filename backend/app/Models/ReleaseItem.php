<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasOneThrough;
use Illuminate\Database\Eloquent\SoftDeletes;

class ReleaseItem extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'release_id', 'module_id', 'title', 'description',
        'item_type_id', 'status_id', 'priority_id', 'owner_person_id',
        'jira_key', 'jira_url', 'target_date', 'closed_at'
    ];

    protected static function boot()
    {
        parent::boot();

        static::deleting(function ($item) {
            foreach ($item->followUps as $followUp) {
                $followUp->delete();
            }
        });
    }

    public function project(): HasOneThrough
    {
        return $this->hasOneThrough(Project::class, Module::class, 'id', 'id', 'module_id', 'project_id');
    }

    public function release(): BelongsTo
    {
        return $this->belongsTo(Release::class);
    }

    public function module(): BelongsTo
    {
        return $this->belongsTo(Module::class);
    }

    public function itemType(): BelongsTo
    {
        return $this->belongsTo(CatalogValue::class, 'item_type_id');
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

    public function environmentStates(): HasMany
    {
        return $this->hasMany(ReleaseItemEnvironmentState::class);
    }

    public function clientActivation(): HasOne
    {
        return $this->hasOne(ClientActivation::class);
    }

    public function followUps(): HasMany
    {
        return $this->hasMany(FollowUp::class);
    }

    public function evidences(): HasMany
    {
        return $this->hasMany(Evidence::class);
    }
}
