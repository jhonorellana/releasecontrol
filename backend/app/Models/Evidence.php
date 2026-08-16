<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Evidence extends Model
{
    protected $table = 'evidences';
    protected $fillable = [
        'release_item_id', 'audit_event_id', 'evidence_type_id', 'title',
        'reference_url', 'local_path', 'description', 'captured_at', 'created_by_person_id'
    ];

    public function releaseItem(): BelongsTo
    {
        return $this->belongsTo(ReleaseItem::class);
    }

    public function auditEvent(): BelongsTo
    {
        return $this->belongsTo(AuditEvent::class);
    }

    public function evidenceType(): BelongsTo
    {
        return $this->belongsTo(CatalogValue::class, 'evidence_type_id');
    }

    public function createdByPerson(): BelongsTo
    {
        return $this->belongsTo(Person::class, 'created_by_person_id');
    }
}
