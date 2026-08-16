<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Module extends Model
{
    use SoftDeletes;

    protected $fillable = ['project_id', 'name', 'code', 'description', 'status_id', 'owner_person_id'];

    protected static function boot()
    {
        parent::boot();

        static::deleting(function ($module) {
            ReleaseItem::where('module_id', $module->id)->delete();
        });
    }

    public function project(): BelongsTo
    {
        return $this->belongsTo(Project::class);
    }

    public function status(): BelongsTo
    {
        return $this->belongsTo(CatalogValue::class, 'status_id');
    }

    public function owner(): BelongsTo
    {
        return $this->belongsTo(Person::class, 'owner_person_id');
    }

    public function items(): HasMany
    {
        return $this->hasMany(ReleaseItem::class);
    }
}
