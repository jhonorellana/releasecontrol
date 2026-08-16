# Technical Design — Local MVP

**Status:** Ready for implementation  
**Scope:** Reports pilot; reusable for future projects  
**API base:** `/api/v1`  
**Storage:** MariaDB/MySQL with ULID identifiers and UTC timestamps

## 1. Decisions applied

| Topic | MVP decision | Rationale |
|---|---|---|
| Environments | Global defaults, with optional project-specific environments. | Reports starts with MOJA, TATU, SITA and PROD without preventing future projects from having a different flow. |
| Authentication | No login. The API uses the fixed logical actor `Jhon` until authentication is introduced. | Preserves audit authorship while respecting the single-user scope. |
| Evidence | URL or textual reference only; no uploaded files. | Keeps local storage and backup simple. |
| Stale data | `stale_after_days` is a configurable setting; seed value: 7 days. | The PRD leaves the exact threshold open, so it must not be hard-coded. |
| Identifiers | Every business entity has a stable ULID primary key. | Avoids name-based references and supports later migration. |
| Deletion | No ordinary hard delete for business records. `archived_at` is used instead. | Implements the PRD archival and audit requirements. |

## 2. Logical data model

```text
Project 1 ──< Module 1 ──< Release 1 ──< ReleaseItem
                                              │
                                              ├──< EnvironmentStatus >── Environment
                                              ├── 1 ClientActivation
                                              ├──< FollowUp
                                              ├──< Evidence
                                              └──< AuditEvent
```

Catalog values are shared by the entities above and are grouped by category.

### 2.1 Core entities

| Table | Key fields | Rules and indexes |
|---|---|---|
| `projects` | `id`, `name`, `description`, `status_code`, `owner_name`, `archived_at` | `name` unique among active projects; index on `status_code`, `owner_name`, `archived_at`. |
| `modules` | `id`, `project_id`, `name`, `description`, `owner_name`, `archived_at` | FK to project; unique `(project_id, name)` for active records. |
| `releases` | `id`, `module_id`, `name`, `scope`, `status_code`, `owner_name`, `target_date`, `notes_url`, `notes_reference`, `archived_at` | FK to module; unique `(module_id, name)` for active records. |
| `release_items` | `id`, `release_id`, `title`, `item_type_code`, `priority_code`, `jira_key`, `jira_url`, `next_action`, `archived_at` | FK to release; index on `priority_code`, `archived_at`, `jira_key`; no orphan is possible. |

`ReleaseItem` is the smallest tracked unit. A base scope and its improvements must be separate items whenever their environment state differs.

### 2.2 Configuration and catalog tables

| Table | Key fields | Purpose |
|---|---|---|
| `environments` | `id`, `project_id` nullable, `code`, `name`, `sequence`, `active` | Global rows have `project_id = null`; project rows are additions or overrides. Backend validation prevents duplicate global codes and duplicate codes in a project. |
| `catalog_values` | `id`, `category`, `code`, `label`, `sort_order`, `active` | Controlled values for project status, release status, item type, priority, environment status, activation status, follow-up status and evidence type. Unique `(category, code)`. |
| `settings` | `key`, `value`, `value_type`, `updated_by`, `updated_at` | Local configuration, including `stale_after_days` and the warning rule for release notes. |

Health values are **not** ordinary catalog values. They are calculated by the backend so their precedence remains consistent.

### 2.3 Tracking and traceability tables

| Table | Key fields | Rules and indexes |
|---|---|---|
| `environment_statuses` | `id`, `release_item_id`, `environment_id`, `status_code`, `verified_at`, `source`, `confirmed_by`, `promotion_justification`, `updated_by` | FK to item and environment; unique `(release_item_id, environment_id)`; all verification fields are required for every update. |
| `client_activations` | `id`, `release_item_id`, `status_code`, `scope_description`, `activated_at`, `confirmed_by`, `source`, `updated_by` | One-to-one with item via unique `release_item_id`. `scope_description` is required for `PILOT` or `PARTIAL`. |
| `follow_ups` | `id`, `release_item_id`, `action`, `owner_name`, `contact_name`, `due_date`, `status_code`, `is_blocker`, `outcome`, `closed_at`, `updated_by` | FK to item; index on `(status_code, due_date)`, `owner_name`, `is_blocker`. |
| `evidences` | `id`, `release_item_id`, `subject_type`, `subject_id`, `evidence_type_code`, `reference`, `description`, `captured_at`, `created_by` | FK to item. `subject_type` identifies `environment_status`, `client_activation`, or `follow_up`; URLs and text references are allowed. |
| `audit_events` | `id`, `entity_type`, `entity_id`, `event_type`, `field_name`, `old_value`, `new_value`, `metadata`, `actor_name`, `occurred_at` | Append-only; index `(entity_type, entity_id, occurred_at)`. No update or delete endpoint exists. |

### 2.4 Required catalog codes

| Category | Required codes |
|---|---|
| `priority` | `CRITICAL`, `HIGH`, `MEDIUM`, `LOW` |
| `environment_status` | `NOT_REACHED`, `DEVELOPMENT`, `READY_TO_PROMOTE`, `CODE_MERGING`, `DEPLOYED`, `TESTING`, `APPROVED`, `BLOCKED`, `UNCONFIRMED` |
| `activation_status` | `NOT_APPLICABLE`, `UNCONFIRMED`, `INACTIVE`, `PILOT`, `PARTIAL`, `ACTIVE`, `MONITORING`, `CLOSED`, `BLOCKED` |
| `follow_up_status` | `PENDING`, `IN_PROGRESS`, `WAITING`, `COMPLETED`, `CANCELLED` |
| `evidence_type` | `URL`, `MEETING_NOTE`, `JIRA`, `MESSAGE`, `MANUAL_REFERENCE` |

Initial environments are `MOJA` (10), `TATU` (20), `SITA` (30), and `PROD` (40).

## 3. Business rules

### 3.1 Integrity rules

1. A project owns its modules; a module owns its releases; a release owns its items. The API never accepts an orphaned child record.
2. An item has at most one current status per applicable environment. Updating it overwrites the current snapshot and creates an audit event.
3. Every environment status update requires `status_code`, `verified_at`, `source`, and `confirmed_by`.
4. The `PROD` environment status is the technical deployment fact. Client activation is a separate one-to-one record and is never inferred from PROD.
5. Every open item requires `next_action`. If the action depends on another person, it requires at least one open follow-up with `owner_name` and `due_date`.
6. `PILOT` and `PARTIAL` activation require `scope_description`; `ACTIVE` requires `activated_at`, `confirmed_by`, and `source`.
7. A promotion that skips an environment is allowed, but it requires `promotion_justification` and generates an alert.
8. Archived records remain queryable through an explicit `include_archived=true` filter and preserve all related history.
9. Critical field changes create audit events: statuses, activation, next action, follow-up state, ownership, target dates, release notes, and archival.
10. Audit events can only be inserted by the application service; their API is read-only.

### 3.2 Health calculation

The API returns one `health` value and a list of all active `alerts`. The first matching condition determines health:

| Precedence | Health | Condition |
|---:|---|---|
| 1 | `BLOCKED` | Any current environment status is `BLOCKED`, any activation is `BLOCKED`, or an open follow-up has `is_blocker = true`. |
| 2 | `OVERDUE` | An open follow-up has `due_date` before the current local date. |
| 3 | `NEEDS_FOLLOW_UP` | PROD is technically deployed but activation is missing or `UNCONFIRMED`; or a PROD status is itself `UNCONFIRMED`. |
| 4 | `ACTION_REQUIRED` | An open item lacks a next action; a coordination action lacks an open follow-up owner/date; or release notes are required by configuration and missing. |
| 5 | `IN_PROGRESS` | Any current environment status is development, merging, ready to promote, testing, or deployment/promotion is ongoing. |
| 6 | `ON_TRACK` | None of the above applies. |

`STALE_DATA`, `ENVIRONMENT_SKIP`, `MISSING_RELEASE_NOTES`, and `UNCONFIRMED_STATUS` are returned as alerts. Staleness is based on `verified_at` and `settings.stale_after_days`; it does not replace a higher-priority health condition.

## 4. REST API contract

All resources use JSON, return UTC timestamps in ISO 8601, and use this envelope:

```json
{
  "data": {},
  "meta": {}
}
```

Validation failures return `422` with an `errors` object. Missing resources return `404`. Attempts to mutate audit history return `405`.

### 4.1 Portfolio resources

| Method | Endpoint | Purpose |
|---|---|---|
| GET, POST | `/projects` | List/filter projects or create one. |
| GET, PATCH, DELETE | `/projects/{projectId}` | Read, update, archive a project. |
| GET, POST | `/projects/{projectId}/modules` | List/create project modules. |
| GET, PATCH, DELETE | `/modules/{moduleId}` | Read, update, archive a module. |
| GET, POST | `/modules/{moduleId}/releases` | List/create module releases. |
| GET, PATCH, DELETE | `/releases/{releaseId}` | Read, update, archive a release. |
| GET, POST | `/releases/{releaseId}/items` | List/create release items. |
| GET, PATCH, DELETE | `/release-items/{itemId}` | Read, update, archive an item. |

List endpoints accept `page`, `per_page`, `project_id`, `status`, `health`, `owner`, `include_archived`, and the resource-relevant filters. Default `per_page` is 25 and maximum is 100.

### 4.2 Status, activation, and follow-up resources

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/release-items/{itemId}/environment-statuses` | Return the environment matrix and its verification metadata. |
| PUT | `/release-items/{itemId}/environment-statuses/{environmentId}` | Create or update the current state for one environment. |
| GET, PUT | `/release-items/{itemId}/activation` | Read or upsert client activation independently of PROD. |
| GET, POST | `/release-items/{itemId}/follow-ups` | List/create follow-ups. |
| GET, PATCH | `/follow-ups/{followUpId}` | Read/update, complete, cancel, or mark blocker. |
| GET, POST | `/release-items/{itemId}/evidences` | List/create evidence references. |
| GET | `/release-items/{itemId}/history` | Read immutable audit events for the item and its tracking records. |

### 4.3 Dashboard, configuration, and export resources

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/dashboard` | KPIs, project health, alerts, and upcoming follow-ups. |
| GET | `/alerts` | Filterable list of active alerts. |
| GET | `/search?q={term}` | Search project, module, release, item, and Jira key. |
| GET | `/environments` | Read global and project-specific environments. |
| POST, PATCH | `/environments`, `/environments/{environmentId}` | Create or configure environments. |
| GET | `/catalog-values?category={category}` | Read active values for a catalog. |
| POST, PATCH | `/catalog-values`, `/catalog-values/{catalogValueId}` | Configure allowed values. |
| GET, PATCH | `/settings` | Read/update local thresholds and warnings. |
| GET | `/exports/release-items?format=csv` | Export the filtered release-item matrix. |

## 5. Representative payloads

### Update an environment state

```json
{
  "status_code": "TESTING",
  "verified_at": "2026-08-14T15:30:00Z",
  "source": "QA meeting 2026-08-14",
  "confirmed_by": "Paola",
  "promotion_justification": null
}
```

### Register activation

```json
{
  "status_code": "PARTIAL",
  "scope_description": "Plan Design companies",
  "activated_at": "2026-08-14T16:00:00Z",
  "confirmed_by": "Ameet",
  "source": "Release confirmation"
}
```

### Create a follow-up

```json
{
  "action": "Confirm enabled plans and companies",
  "owner_name": "Jhon",
  "contact_name": "Ameet",
  "due_date": "2026-08-18",
  "status_code": "PENDING",
  "is_blocker": false
}
```

## 6. Implementation sequence for phase 3

1. Create migrations for catalogs, portfolio hierarchy, environments, settings, and tracking tables.
2. Seed catalog values, default environments, settings, and the fixed logical actor configuration.
3. Implement Eloquent models, relationships, factories, policies prepared for future authentication, and form requests.
4. Implement services for health calculation, audit writing, promotion validation, and archive behavior.
5. Implement the versioned API endpoints with feature tests covering all rules in section 3.
6. Add the Reports baseline seeder only after the data-validation phase confirms its unresolved fields.
