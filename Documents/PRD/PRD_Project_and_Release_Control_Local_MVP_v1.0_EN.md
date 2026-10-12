---
title: Project and Release Control System — Local MVP PRD (v1.0 Implemented Baseline)
lang: en
---

# PRODUCT REQUIREMENTS DOCUMENT

# Project and Release Control System

Local MVP · Angular + Laravel + MySQL

**Owner:** Jhon  
**Status:** Approved & Implemented MVP Baseline  
**Version:** 1.0  
**Date:** October 12, 2026 (Updated from August 14, 2026 Draft v0.1)  
**Supported Projects:** Reports (Pilot baseline), AdminAPI, Invoicing, Dashboard, and Fintrac

---

## Executive Summary

The **Project and Release Control System** is an operational single-source-of-truth application built to eliminate fragmentation, status ambiguity, and unverified assumptions across software development environments.

Historically, tracking release progress relied on static spreadsheets and verbal updates. While helpful as high-level snapshots, they could not reliably preserve who verified each status, when it was tested, what pending actions or blockers existed, or whether a feature deployed to PROD was actually enabled for clients.

The **implemented Local MVP (v1.0)** solves this by unifying:
1. **Hierarchical Project Portfolio Management:** Projects, Modules, Releases, and atomic Release Units (Release Items).
2. **Interactive Environment Promotion Matrix:** Visual pipeline tracking through MOJA, TATU, SITA, and PROD with confirmer attribution and timestamps.
3. **Decoupled Technical Deployment vs. Client Activation:** Explicit operational distinction between code residing in PROD and feature availability to clients (global, selective, plans, or groups).
4. **Actionable Follow-ups with Priority Flags & Aging:** Instant visibility into what needs to be done, who owns it, due dates, priority flags (🚩 Blocker/Critical, ⚡ High, 🔹 Medium, 🟢 Low), and age in days (`Today`, `1 day`, `X days`) with stale alerts (> 7 days).
5. **Auditable History & Logical Archiving (Soft Deletes):** Complete traceability via immutable audit events and non-destructive logical deletion across all entities.
6. **Cross-Screen Filter State Persistence:** In-memory and `localStorage` state retention across navigation and page refreshes.

---

# 1. Document Control

| **Field** | **Definition** |
|---|---|
| Product Name | Project and Release Control System |
| Document Type | PRD — Product Requirements Document (As-Built Baseline) |
| Version / Status | 1.0 / Approved & Implemented |
| Product Owner | Jhon |
| Operational User | Jhon (Local single-user operation with audit actor logging) |
| Technology Stack | Angular (SPA Frontend), Laravel (REST API Backend), MySQL (Database) |
| Source of Truth | Operational Web Application (`http://localhost:4200`) backed by MySQL |
| Active Projects | Reports, AdminAPI, Invoicing, Dashboard, Fintrac |

## 1.1 Revision History

| **Version** | **Date** | **Author** | **Summary of Changes** |
|---|---|---|---|
| 0.1 | Aug 14, 2026 | Jhon | Initial draft for review and feasibility discovery. |
| 1.0 | Oct 12, 2026 | Jhon / AI Pair | Formal update reflecting the fully implemented and tested MVP. Consolidated screen architecture into 6 unified modules, finalized Project-Release-Module relationships, integrated Priority Flags, Age tracking, 1:1 grid alignment, filter persistence, and closed all open questions. |

---

# 2. Problem Statement & Operational Philosophy

## 2.1 The Core Problem
- **Scattered Truth:** Critical release states were dispersed across Jira tickets, chat messages, meeting notes, and human memory.
- **The "PROD Fallacy":** "It is in PROD" was frequently conflated with "Clients are using it." Technical deployment and commercial activation were untracked as distinct lifecycles.
- **Environment Black Box:** Promotions between environments (e.g., TATU to SITA/PROD) lacked traceable verification dates and confirming persons.
- **Ambiguous Actionability:** Unfinished items lacked clear next actions, blocker designations, and escalation mechanisms.

## 2.2 Core Operational Principle
> **"A status without a date, source, and confirming person is merely a hypothesis. A hypothesis must produce an immediate verification action, not be reported as a fact."**

---

# 3. Product Vision, Objectives & Success Criteria

## 3.1 Vision
Provide a centralized, verifiable, and actionable workspace enabling the Product Owner and technical leads to answer three questions within seconds:
1. *Where exactly is each feature across our environments?*
2. *Is it technically deployed, and is it enabled for clients?*
3. *What is blocking progress, who is responsible, and what must happen next?*

## 3.2 MVP Objectives & Verification Results

| **Objective** | **Target** | **Implemented Status** |
|---|---|---|
| Portfolio Coverage | 100% of baseline topics represented across projects. | **Achieved.** Reports baseline and AdminAPI/Invoicing modules active. |
| Actionability | All open items have a next action, owner, priority flag, and age. | **Achieved.** Action points feature priority flags, age badges, and blocker tags. |
| Traceability | Every promotion records date, confirming person, and optional notes. | **Achieved.** Captured in `release_item_environment_states` and `audit_events`. |
| Query Speed | Identify blockers and overdue follow-ups in < 30 seconds. | **Achieved.** Filter combos and KPIs highlight blockers and stale items instantly. |
| PROD Distinction | Zero confusion between technical deployment and client availability. | **Achieved.** Dedicated Client Activation module and independent statuses. |
| Data Safety | Non-destructive operations and validated database backups. | **Achieved.** SoftDeletes across all models; SQL baseline dump established. |

---

# 4. Implemented Scope (v1.0)

## 4.1 Included & Functional Capabilities

1. **Portfolio Dashboard (`/dashboard`):** Real-time KPI summaries (Total Releases, Active Blockers, Overdue Actions, Unconfirmed Activations), project health badges, and direct links to filtered detail views.
2. **Environment Tracking Matrix (`/matrix`):** Interactive grid showing all Release Units against MOJA, TATU, SITA, and PROD. Features:
   - Click-to-promote environment state modals with confirmer attribution.
   - Aligned Next Actions with 1:1 responsive layout for multi-line text.
   - Dedicated, sortable `OWNER` and `AGE` columns.
   - Tri-state filter: *All Units*, *With Active Actions*, *Without Active Actions*.
   - Filter persistence via `FilterStateService`.
3. **Client Activation Module (`/activations`):** Dedicated matrix tracking post-PROD enablement with scopes: `global`, `selective`, `off`, `all`, `group`, `plan`, `not_applicable`, `unknown`.
4. **Action Items & Follow-ups Inbox (`/follow-ups`):** Comprehensive table with:
   - Visual **Priority Flags**: 🚩 Critical / Blocker, ⚡ High, 🔹 Medium, 🟢 Low.
   - **Age Tracking (`AGE`)**: Calculated days since creation (`Today`, `1 day`, `X days`) with amber warning highlights for stale items (> 7 days).
   - Full column sorting (`ID`, `RELEASE UNIT`, `ACTION POINT`, `STATUS`, `PRIORITY`, `AGE`, `OWNER`, `TARGET DATE`).
   - Quick-update modals for reassignments, status transitions, and outcome recording.
5. **Audit History (`/audit`):** Immutable, searchable event ledger capturing entity updates, state transitions, actors, and timestamps.
6. **Master Data & Settings (`/settings`):** Tabbed administration managing:
   - Projects (CRUD, owners, status).
   - Release Packages (CRUD, target dates, scope, notes).
   - Release Units (CRUD, project/module/release associations).
   - Catalogs (Statuses, Priorities, Environment States, Activation Scopes).
   - People & Contacts (Team members, roles, emails).
   - Logical Archiving (Soft Deletes) with confirmation dialogs.

## 4.2 Out of Scope (Deferred to Future Phases)
- Multi-user authentication with Microsoft Entra / SSO.
- Automated bidirectional synchronization with Jira REST APIs.
- External push notifications (Slack, Microsoft Teams, automated email).
- Storage of sensitive client credentials, secrets, or production PII.
- Automated CI/CD pipeline triggers.

---

# 5. Implemented Screen Architecture

The initial draft proposal of 8 fragmented screens was consolidated into **6 cohesive, high-efficiency modules**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                     RELEASE CONTROL NAVIGATION BAR                     │
├─────────────┬────────────────────┬─────────────────┬───────────────────┤
│  Dashboard  │ Environment Matrix │ Client Activat. │ Action Items      │
│  (/dashboard)│ (/matrix)          │ (/activations)  │ (/follow-ups)     │
├─────────────┴────────────────────┴─────────────────┴───────────────────┤
│  Audit History (/audit)          │ Settings & Master Data (/settings)  │
└──────────────────────────────────┴─────────────────────────────────────┘
```

### Screen Details & Functionality:

| **Screen** | **Route** | **Core Components & Capabilities** |
|---|---|---|
| **Portfolio Dashboard** | `/dashboard` | System health summary, active release count, blocker alerts, overdue items, unconfirmed activation warnings, and rapid navigation shortcuts. |
| **Environment Tracking Matrix** | `/matrix` | Primary operational grid. Tracks release units across MOJA, TATU, SITA, PROD. Clickable state badges for promotion, aligned action items with owners and age, latest verified dates, search by name, and Project/Module/Action Status filters. |
| **Client Activation** | `/activations` | Operational separation of PROD code from customer usage. Displays deployment date, activation status, scope (All, Group, Plan, Selective), and confirmation records. |
| **Action Items & Follow-ups** | `/follow-ups` | Centralized action inbox. Filter by Project, Status, Priority, Owner, and Blockers Only. Visual priority badges (🚩, ⚡, 🔹, 🟢), age in days (`Today`, `X days`), and sortable columns. |
| **Audit History** | `/audit` | Searchable audit ledger displaying entity types (`project`, `release`, `release_item`, `follow_up`), before/after values, logical actors, and exact timestamps. |
| **Master Data & Settings** | `/settings` | 5-tab administration panel: (1) Projects, (2) Release Packages, (3) Release Units, (4) Catalogs & Values, (5) Team Members. Includes soft delete confirmation and filter persistence. |

---

# 6. Conceptual & Technical Data Model

## 6.1 Entity Relationship Overview

The data model establishes strict referential integrity while keeping releases deployable across multiple modules within a project:

```text
[Project] ──1:N──> [Module]
   │
   ├──1:N──> [Release] (Release Package per Project)
   │            │
   │            └──1:N──> [ReleaseItem] (Release Unit) <──1:N── [Module]
   │                         │
   ├──1:N──> [ProjectEnv]   ├──1:N──> [ReleaseItemEnvironmentState]
   │                         ├──1:1──> [ClientActivation]
   │                         ├──1:N──> [FollowUp] (Action Point)
   │                         └──1:N──> [AuditEvent]
   └──1:N──> [Person] (Assigned Leads & Confirmers)
```

## 6.2 Implemented Entities & Schema

| **Entity** | **Table Name** | **Key Attributes** | **Notes** |
|---|---|---|---|
| **Project** | `projects` | `id`, `name`, `code`, `description`, `status_id`, `owner_person_id`, `deleted_at` | Top-level portfolio container. Uses SoftDeletes. |
| **Module** | `modules` | `id`, `project_id`, `name`, `code`, `description`, `status_id`, `owner_person_id`, `deleted_at` | Functional division of a Project. Soft-deletes cascade to Release Units. |
| **Release** | `releases` | `id`, `project_id`, `name`, `code`, `status_id`, `owner_person_id`, `target_date`, `scope`, `release_notes_url`, `notes`, `deleted_at` | Planned deployment milestone within a Project. |
| **ReleaseItem** | `release_items` | `id`, `project_id`, `module_id`, `release_id`, `title`, `type_id`, `priority_id`, `status_id`, `jira_key`, `jira_url`, `description`, `deleted_at` | Atomic tracking unit ("Release Unit"). Connects Project, Module, and Release. |
| **ProjectEnvironment** | `project_environments` | `id`, `project_id`, `name`, `code`, `sort_order`, `is_active` | Configurable environments (e.g. MOJA, TATU, SITA, PROD). |
| **EnvironmentState** | `release_item_environment_states` | `id`, `release_item_id`, `project_environment_id`, `status_id`, `verified_at`, `source_summary`, `confirmed_by_person_id`, `notes` | Unique per `(release_item_id, project_environment_id)`. Tracks environment progression. |
| **ClientActivation** | `client_activations` | `id`, `release_item_id`, `scope_type`, `scope_detail`, `activated_at`, `confirmed_by_person_id`, `notes` | Scope types: `global`, `selective`, `off`, `all`, `group`, `plan`, `not_applicable`, `unknown`. |
| **FollowUp** | `follow_ups` | `id`, `release_item_id`, `action`, `status_id`, `priority_id`, `owner_person_id`, `contact_person_id`, `due_date`, `is_blocker`, `notes`, `completed_at`, `created_at`, `updated_at`, `deleted_at` | Action Points. Drives NEXT ACTION, Priority Flags, and Age calculations. |
| **CatalogValue** | `catalog_values` | `id`, `category`, `code`, `label`, `description`, `color`, `sort_order`, `is_active` | Extensible catalogs: `project_status`, `release_status`, `environment_state`, `follow_up_status`, `priority`, etc. |
| **Person** | `people` | `id`, `name`, `email`, `role`, `display_name`, `is_active`, `deleted_at` | Team members, technical leads, owners, and confirmers. |
| **AuditEvent** | `audit_events` | `id`, `entity_type`, `entity_id`, `event_type`, `changes` (JSON), `context` (JSON), `actor_name`, `occurred_at` | Append-only audit trail recording state changes and updates. |

---

# 7. Business Rules & Logic Matrix

| **ID** | **Rule Name** | **Operational Logic** |
|---|---|---|
| **BR-001** | PROD / Activation Decoupling | Deployment to PROD creates a technical milestone but sets Client Activation to unconfirmed/off until explicitly verified with activation scope. |
| **BR-002** | Promotion Attribution | Every environment promotion requires selecting a confirming person (`confirmed_by_person_id`) and records the current verification date. |
| **BR-003** | Priority Color-Coding | Action Points strictly adhere to catalog priority styling: Critical/Blocker (`#EF4444`), High (`#F59E0B`), Medium (`#3B82F6`), Low (`#10B981`). |
| **BR-004** | Age Calculation & Stale Alerts | Follow-up age is computed dynamically from `created_at` (`Today`, `1 day`, `X days`). Items open for more than 7 days trigger warning amber styling (`.age-stale`). |
| **BR-005** | Latest Verified Date | The `LAST VERIFIED` column on the Matrix resolves the latest timestamp between related Action Points (`updated_at` / `created_at`) and environment confirmations (`verified_at`). |
| **BR-006** | 1:1 Row Grid Alignment | The Matrix uses `.action-row-grid` (`1fr 105px 85px`) ensuring each action description, owner badge, and age badge remain vertically locked and aligned regardless of text wrapping. |
| **BR-007** | Non-Destructive Archiving | Deletions trigger Laravel Eloquent `SoftDeletes` (`deleted_at = NOW()`), preserving historical references in queries and audit logs. |
| **BR-008** | Cascading Module Integrity | Soft-deleting a Module automatically applies soft-deletion to its child Release Units via model event listeners. |
| **BR-009** | Filter Persistence | Search text, dropdown combos (Project, Module, Action Items), active tabs, and sort preferences persist in `localStorage` across page navigation. |
| **BR-010** | High-Contrast Dark Controls | Datepickers use `color-scheme: dark` and `filter: brightness(0) invert(1)` to ensure calendar icons render in 100% bright white on dark inputs. |

## 7.1 Precedence Health Matrix

When evaluating release or project health on the dashboard:

| **Precedence** | **Status** | **Trigger Condition** | **Color Token** |
|:---:|---|---|---|
| **1 (Highest)** | **Blocked** | Any open Action Point is flagged as `is_blocker = true`. | `--danger` (`#EF4444`) |
| **2** | **Overdue** | Any open Action Point has `due_date < TODAY`. | `--danger` (`#F87171`) |
| **3** | **Needs Follow-up** | Deployed to PROD but Client Activation is unconfirmed / pending. | `--warning` (`#F59E0B`) |
| **4** | **Action Required** | Open release unit has 0 active action points or missing owner. | `--warning` (`#F97316`) |
| **5** | **In Progress** | Active items progressing through MOJA, TATU, or SITA. | `--info` (`#3B82F6`) |
| **6 (Lowest)** | **On Track** | Progressing with no active exceptions, blockers, or overdue dates. | `--success` (`#10B981`) |

---

# 8. Resolution of Open Questions (From Draft v0.1)

All open questions formulated during the draft phase are now **fully decided and implemented**:

| **Question ID** | **Draft Question** | **Resolution & Implementation** |
|---|---|---|
| **OQ-01** | What tech stack versions are required? | **Resolved:** PHP 8.2+, Laravel 11, Angular 18/19, Node.js 20+, MySQL 8.0+. |
| **OQ-02** | Is login required, or a logical actor? | **Resolved:** Local single-user MVP operates with logical actor attribution (`Jhon`, PO) logged automatically in `audit_events`. Multi-user auth deferred to Phase 3. |
| **OQ-03** | How is evidence handled (URL vs file)? | **Resolved:** Implemented via validated URLs, Jira links, and rich outcome notes. Large binary uploads deferred. |
| **OQ-04** | Are environments global or per-project? | **Resolved:** Configured per-project via `project_environments` (MOJA, TATU, SITA, PROD). |
| **OQ-05** | What is the threshold for "stale" items? | **Resolved:** Configured at **7 days**. Items open > 7 days display amber `.age-stale` badges. |
| **OQ-06** | How are database backups handled? | **Resolved:** Local SQL dumps generated at milestones (e.g., `database/release_control_db_06.sql`). Documented restore procedure in README. |
| **OQ-07** | Excel vs Application source of truth? | **Resolved:** The Web Application (`http://localhost:4200`) is the official operational source of truth; Excel is superseded. |
| **OQ-08** | Which projects validate model reusability? | **Resolved:** Model successfully validated with Reports, AdminAPI, Invoicing, Dashboard, and Fintrac. |

---

# 9. Non-Functional Specifications & Quality Standards

- **Local Execution:** Both backend (`php artisan serve --port=8001`) and frontend (`ng serve --port=4200`) run locally without internet dependencies.
- **Query & Rendering Performance:** Single-page application loads and filters datasets in under 200ms using reactive Angular signals and in-memory caches.
- **Design System:** Custom CSS design system adhering to strict premium dark aesthetics:
  - Base background: Slate dark (`#0F172A`), card surface (`#1E293B`), glassmorphism with backdrop filters.
  - Typography: Google Fonts `Outfit` (headings) and `Inter` (body).
  - High-contrast table demarcation: 1px visible borders, zebra striping (`rgba(255, 255, 255, 0.025)`), and hover highlights (`rgba(99, 102, 241, 0.09)`).
- **Data Integrity & Security:** Foreign key cascading constraints, unique compound indexes (`['release_item_id', 'project_environment_id']`), and Laravel database transactions on multi-table updates.

---

# 10. Post-MVP Roadmap (Future Phases)

| **Phase** | **Milestone Name** | **Key Objectives** |
|---|---|---|
| **Phase 1** | **Local MVP (Current)** | **Delivered.** Complete operational single-user platform for Jhon covering all core projects. |
| **Phase 2** | **Portfolio Expansion** | Bulk Excel/CSV export and import tools, custom reporting summaries for stakeholders. |
| **Phase 3** | **Cloud & Multi-User** | Containerized deployment (Docker), cloud hosting, Microsoft Entra / SSO authentication, and role-based permissions (Viewer, Lead, Admin). |
| **Phase 4** | **Integrations** | Automated Jira webhook sync, GitHub/GitLab PR deployment tracking, and Microsoft Teams notifications. |
| **Phase 5** | **Analytics & Metrics** | Cycle time analytics, environment bottleneck heatmaps, and release predictability metrics. |

---

# 11. Approvals & Sign-off

| **Role** | **Name** | **Status** | **Date** |
|---|---|---|---|
| **Product Owner / BA** | Jhon | **Approved (Baseline v1.0)** | October 12, 2026 |
| **AI Technical Lead / Architect** | Antigravity AI | **Validated & Verified** | October 12, 2026 |
