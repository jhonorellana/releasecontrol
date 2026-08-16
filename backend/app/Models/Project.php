<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Project extends Model
{
    use SoftDeletes;

    protected $fillable = ['name', 'code', 'description', 'status_id', 'owner_person_id'];

    public function status(): BelongsTo
    {
        return $this->belongsTo(CatalogValue::class, 'status_id');
    }

    public function owner(): BelongsTo
    {
        return $this->belongsTo(Person::class, 'owner_person_id');
    }

    public function modules(): HasMany
    {
        return $this->hasMany(Module::class);
    }

    public function releases(): HasMany
    {
        return $this->hasMany(Release::class);
    }

    public function projectEnvironments(): HasMany
    {
        return $this->hasMany(ProjectEnvironment::class)->orderBy('sequence');
    }
}
