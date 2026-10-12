---
title: Project and Release Control System — Local MVP PRD
lang: en
---

# PRODUCT REQUIREMENTS DOCUMENT

# Project and Release Control System

Local MVP · Angular + Laravel + MySQL

**Owner:** Jhon  
**Status:** Draft for review  
**Version:** 0.1  
**Date:** August 14, 2026  
**Initial pilot:** Reports

> **PROPOSED DECISION**  
> Build a local, single-user MVP that replaces informal control with a structured source of truth. Reports will be the pilot; the design must later support AdminAPI, Dashboard, Invoicing, and Fintrac without rebuilding the data model.

This PRD defines what the first version must solve, how it will be validated, and what is deferred. It is not a detailed technical design or an authorization to begin development without reviewing the open questions.

## Quick read

- Problem: there is no reliable central record of the status of modules, releases, environments, client activation, and follow-ups.
- MVP solution: local web application with a dashboard, projects, modules, releases, tracking by environment, pending actions, and history.
- Main limitation: the MVP will not be collaborative and will not be available when the machine is turned off.

# 1. Document control

| **Field** | **Definition** |
|---|---|
| Product name | Project and Release Control System |
| Document type | PRD — Product Requirements Document |
| Version / status | 0.1 / Draft for review |
| Product owner | Jhon |
| Initial user | Jhon, local and single-user operation |
| Target technology | Angular, Laravel, and MySQL, installed locally |
| Initial source of truth | Reports seed data, validated against the matrix and meetings of August 7, 2026 |
| Future projects | AdminAPI, Dashboard, Invoicing, and Fintrac |

## 1.1 Sources used

- Initial status matrix by environment: MOJA, TATU, SITA, and PROD.
- “ReportsReleaseStatus” and “ReportsReleaseStatus 02” transcripts, dated August 7, 2026.
- “Reports_Release_Control.xlsx” control file, prepared as the operational baseline.
- Decisions and constraints agreed upon in the discovery conversation.

> **QUALITY NOTE**  
> The transcript contains phonetically recognized names and terms. Every reference to owners, tickets, and dates must be validated before being considered definitive data.

# 2. Executive summary

The current tracking of Reports depends on a matrix that indicates whether a topic is or is not in each environment. The matrix is useful as a snapshot, but it does not retain who confirmed the data, when it was verified, what the next step is, whether a blocker exists, or whether a feature deployed to PROD was actually activated for clients.

The proposed MVP will centralize that information in a local application. It will make it possible to register projects, modules, releases, and release items; track their progress through configurable environments; separate deployment to PROD from client activation; assign actions and dates; and maintain an auditable history of changes.

The first implementation will be validated with Reports. If the workflow proves useful and establishes operational discipline, AdminAPI, Dashboard, Invoicing, and Fintrac will be incorporated, and a migration to a shared environment will be evaluated.

# 3. Problem and opportunity

## 3.1 Current problem

- Information is scattered across meetings, messages, tickets, and people's memory.
- The transition from TATU to SITA and PROD is perceived as a “black box” when there is no visible confirmation.
- “It is in PROD” can be confused with “it is available to clients.” They are different statuses.
- A base module and its improvements can be in different environments, but a single row does not represent this well.
- There is no consolidated view of overdue follow-ups, blockers, or data that has not been verified recently.

## 3.2 Opportunity

A small tool, controlled by the user and aligned with the user's technical experience, can reduce dependence on external documentation and establish a repeatable method before investing in a corporate solution. The main value will not come from the technology, but from turning each status into a record with evidence, an owner, and a next action.

# 4. Vision, objectives, and metrics

## 4.1 Product vision

> **VISION**  
> Have a central, verifiable, and actionable source that makes it possible to know within minutes what is being built, where it is, what is preventing progress, and what must happen next.

## 4.2 MVP objectives

1. Centralize the inventory of projects, modules, releases, and initiatives under the user's responsibility.
2. Maintain traceability of progress by environment with date, source, and confirming person.
3. Clearly separate technical deployment to PROD from activation or availability for clients.
4. Turn uncertainties into actions with an owner, contact, target date, and status.
5. Detect overdue items, stale data, and the absence of a next action without depending on a permanent scheduled task.
6. Validate the method with Reports before extending it to other projects.

## 4.3 Pilot success metrics

| **Metric** | **Acceptance target** |
|---|---|
| Reports coverage | 100% of the active baseline topics represented. |
| Actionability | 100% of open items have a next action; those requiring follow-up include an owner and date. |
| Traceability | 100% of status changes include a date, source, and confirming person. |
| Query speed | Identify blockers and overdue follow-ups in less than 2 minutes. |
| PROD distinction | No item uses “PROD” as an automatic synonym for “active for clients.” |
| Recovery | Perform and restore at least one test backup before closing the pilot. |

# 5. MVP scope

## 5.1 Included

| **Capability** | **Expected result** |
|---|---|
| Portfolio dashboard | Summary of projects, releases, blockers, overdue items, and alerts. |
| Projects and modules | Hierarchical inventory with owners, status, and description. |
| Releases and items | Grouping of deployable changes, with optional relationship to Jira and release notes. |
| Configurable environments | Tracking through MOJA, TATU, SITA, PROD, or other future environments. |
| PROD and activation | Separate statuses and dates for deployment and availability to clients. |
| Follow-ups | Next action, owner, contact, target date, status, and notes. |
| History | Immutable record of relevant changes with date and logical author. |
| Basic configuration | Catalogs of statuses, priorities, evidence types, and environments. |
| Initial Reports data | Seed load of the known baseline as of August 7, 2026. |

## 5.2 Out of scope

- Multi-user access, simultaneous collaboration, corporate roles, and authentication with Microsoft Entra.
- Hosting, domain, remote access, high availability, and 24/7 operation.
- Automatic integration with Jira, Teams, email, Power BI, pipelines, or deployment systems.
- External notifications. Alerts will be displayed inside the application.
- Storage of sensitive client data, credentials, or protected PROD information.
- Source-code management, execution of deployments, or technical approval of releases.

## 5.3 Assumptions and constraints

- The application will run on the user's machine and will only be available while the local processes are active.
- Information will be updated manually from meetings, messages, Jira, and confirmations from owners.
- The initial user will have full permissions. Authentication may be deferred, but the model will retain authorship fields for a future multi-user version.
- Alerts will be calculated when the application is opened or refreshed; they will not depend on a persistent scheduler.

# 6. Users and roles

| **Role** | **Need** | **MVP scope** |
|---|---|---|
| Product Owner / BA — Jhon | Register, verify, follow up on, and communicate portfolio status. | Sole operational user; full access. |
| Tech Lead / QA / Release contact | Confirm statuses, blockers, testing, and promotions. | Does not access the application directly; appears as an owner or confirmation source. |
| Executive stakeholder | Understand risks, progress, and required decisions. | Does not access the application directly; receives exported reports or screenshots. |
| Future administrator | Configure users, permissions, and integrations. | Outside the MVP; considered in the design. |

# 7. Proposed operational workflow

1. Register or select the affected project and module.
2. Create a release and add one or more release items with a clear scope.
3. Register the status of each item by environment, including date, source, confirming person, and optional evidence.
4. When the item reaches PROD, separately register whether it is active for clients, for which group, and since when.
5. Define the next action. If it requires coordination, assign an owner, contact, and target date.
6. Review the dashboard to address overdue items, blockers, stale information, and unconfirmed statuses.
7. Close the item only when there are no pending actions and the expected result has been verified.

> **OPERATIONAL RULE**  
> A status without a date, source, and confirmation is a hypothesis; a hypothesis must produce a verification action, not be presented as fact.

# 8. Functional requirements

Priorities: Must = essential to accept the MVP; Should = important if it does not compromise the pilot; Could = optional improvement.

## 8.1 Portfolio, projects, and modules

| **ID** | **Requirement** | **Priority** | **Summary criterion** |
|---|---|---|---|
| FR-001 | Create, edit, archive, and view projects. | Must | Each project has a unique name, status, description, and owner. |
| FR-002 | Create and organize modules within a project. | Must | A module belongs to a project and can have multiple releases. |
| FR-003 | Display Reports as the pilot project and allow AdminAPI, Dashboard, Invoicing, and Fintrac to be added. | Must | The model does not depend on a single project. |
| FR-004 | Filter the portfolio by project, status, health, and owner. | Should | Filters can be combined and cleared. |

## 8.2 Releases and release items

| **ID** | **Requirement** | **Priority** | **Summary criterion** |
|---|---|---|---|
| FR-010 | Create releases with name, scope, status, owner, estimated dates, and notes. | Must | The release can be viewed with all its items and risks. |
| FR-011 | Add multiple items to a release. | Must | Each item retains its own progress and next action. |
| FR-012 | Relate an item to a project, module, and release. | Must | There are no orphaned items. |
| FR-013 | Register a Jira key and URL without automatic synchronization. | Must | The link is optional and validated as a URL. |
| FR-014 | Register release notes or a link to them. | Must | The dashboard warns if they are missing before promotion. |
| FR-015 | Differentiate base scope from improvements. | Must | They can coexist in different environments. |
| FR-016 | Archive releases and items without physical deletion. | Must | Archived records do not appear by default and retain their history. |

## 8.3 Tracking by environment

| **ID** | **Requirement** | **Priority** | **Summary criterion** |
|---|---|---|---|
| FR-020 | Configure environments and their order by project. | Must | MOJA, TATU, SITA, and PROD are created as initial values. |
| FR-021 | Register the status of an item in each environment. | Must | Each environment displays its current status and latest verification. |
| FR-022 | Register date, source, confirmed by, and optional evidence. | Must | The fields accompany every relevant update. |
| FR-023 | Represent “not reached,” “present,” “in testing,” “approved,” “blocked,” and “unconfirmed.” | Must | It is not limited to OK/X. |
| FR-024 | Warn about environment skips or inconsistencies without blocking the record. | Should | The user can save with justification. |
| FR-025 | Display an environment matrix by release or module. | Must | The view retains the visual speed of the original matrix. |

## 8.4 PROD and client activation

| **ID** | **Requirement** | **Priority** | **Summary criterion** |
|---|---|---|---|
| FR-030 | Register deployment to PROD as an independent technical fact. | Must | Includes date and confirmation. |
| FR-031 | Register client activation status. | Must | Minimum values: not applicable, unconfirmed, inactive, partial, active. |
| FR-032 | Register the enabled group or plan when activation is partial. | Should | The detail remains visible in the release. |
| FR-033 | Generate an alert when a deployment exists without confirmed activation. | Must | It appears on the dashboard and in the item detail. |

## 8.5 Follow-ups, alerts, and history

| **ID** | **Requirement** | **Priority** | **Summary criterion** |
|---|---|---|---|
| FR-040 | Register a next action for every open item. | Must | The system highlights items without a next action. |
| FR-041 | Create follow-ups with owner, contact, target date, status, and notes. | Must | They can be closed with a result and date. |
| FR-042 | Display alerts for overdue items and stale data. | Must | They are calculated when the application is opened or refreshed. |
| FR-043 | Display alerts for missing release notes and unplanned promotions. | Should | The rule is configurable or can be disabled. |
| FR-044 | Register an automatic history of changes to statuses and critical fields. | Must | Includes before/after, date, and logical author. |
| FR-045 | Prevent ordinary editing of the history. | Must | Events are only added; they are not overwritten. |
| FR-046 | Filter follow-ups by due status, owner, project, and status. | Must | The list makes it possible to prioritize daily work. |

## 8.6 Dashboard, search, and export

| **ID** | **Requirement** | **Priority** | **Summary criterion** |
|---|---|---|---|
| FR-050 | Display KPIs for active releases, blockers, overdue items, and unconfirmed activation. | Must | Counts link to the filtered detail. |
| FR-051 | Calculate and display project and item health. | Must | The rules defined in Section 11 are applied. |
| FR-052 | Provide global search by project, module, release, item, or Jira. | Should | Results open the corresponding record. |
| FR-053 | Export views to Excel or CSV. | Should | The export retains filters and column names. |
| FR-054 | Display the dashboard's last-updated date. | Must | The user can distinguish current data from an old snapshot. |

# 9. MVP screens

| **Screen** | **Main content** | **Key actions** |
|---|---|---|
| Dashboard | KPIs, health by project, alerts, and upcoming follow-ups. | Filter, navigate to details, mark a follow-up as addressed. |
| Projects | Project list and project record with modules and owners. | Create, edit, archive, open modules. |
| Module | Releases, active items, risks, and status by environment. | Create release, view history. |
| Release | Scope, items, dates, release notes, and Jira. | Edit, add items, promote status. |
| Release item | Environment matrix, PROD, activation, and actions. | Update status, attach evidence, create follow-up. |
| Follow-ups | Pending-items inbox ordered by date and priority. | Filter, reassign, close with a result. |
| History | Timeline of relevant changes. | View and filter; no ordinary editing. |
| Configuration | Environments, statuses, priorities, and thresholds. | Create, order, activate, or deactivate values. |

# 10. Conceptual data model

| **Entity** | **Purpose** | **Main fields** |
|---|---|---|
| Project | Groups business responsibility. | id, name, description, status, owner, archived_at |
| Module | Divides a project into products or functional areas. | id, project_id, name, description, owner |
| Release | Groups changes that are planned to be promoted together. | id, module_id, name, scope, status, target_date, notes_url |
| ReleaseItem | Smallest deployable tracking unit. | id, release_id, title, type, priority, jira_key, next_action |
| Environment | Defines an environment and its order. | id, project_id/null, name, sequence, active |
| EnvironmentStatus | Status of an item in an environment. | release_item_id, environment_id, status, verified_at, source, confirmed_by |
| ClientActivation | Actual availability to clients. | release_item_id, status, scope, activated_at, confirmed_by |
| FollowUp | Pending coordination action. | release_item_id, action, owner, contact, due_date, status, outcome |
| Evidence | Reference that supports a confirmation. | type, url/path, description, captured_at |
| AuditEvent | History of critical changes. | entity_type, entity_id, field, old_value, new_value, actor, occurred_at |

## 10.1 Essential relationships

- One Project contains many Modules.
- One Module contains many Releases; one Release contains many ReleaseItems.
- One ReleaseItem has one status for each applicable Environment.
- One ReleaseItem can have one client activation and multiple FollowUps, Evidence records, and AuditEvents.
- Identifiers will be stable and will not depend on the record's visible name.

# 11. Business rules and health

## 11.1 Business rules

| **ID** | **Rule** |
|---|---|
| BR-001 | Deployment to PROD does not imply client activation. |
| BR-002 | Every environment update requires a date, source, and confirmed by. |
| BR-003 | Every open item must have a next action; if it depends on someone, a follow-up with an owner and date must exist. |
| BR-004 | The same release can contain items in different environments. |
| BR-005 | The base scope and its improvements must be registered as separate items when their statuses differ. |
| BR-006 | Environments are configurable and retain a promotion order. |
| BR-007 | Status changes generate an audit event. |
| BR-008 | There is no ordinary physical deletion; logical archiving is used. |
| BR-010 | Dates are stored in UTC and displayed in the configured time zone. |

## 11.2 Health statuses

| **Health** | **Condition** | **Precedence** |
|---|---|---|
| Blocked | An active blocker exists. | 1 — highest |
| Overdue | An open follow-up with an overdue date exists. | 2 |
| Needs Follow-up | PROD or client activation is not confirmed. | 3 |
| Action Required | A next action, owner, date, or required release notes are missing. | 4 |
| In Progress | Active development, merge, testing, or promotion exists. | 5 |
| On Track | There are no active exceptions and work is progressing as expected. | 6 |

> **CRITERION**  
> When several conditions are met, the one with the highest precedence will be displayed. The details will retain all active alerts.

# 12. Non-functional requirements

| **ID** | **Requirement** | **Verifiable objective** |
|---|---|---|
| NFR-001 | Local execution | Frontend, API, and database start on the user's machine with reproducible instructions. |
| NFR-002 | Architecture | Angular consumes a Laravel REST API; MySQL is the primary persistence layer. |
| NFR-003 | Secure configuration | Credentials and parameters are kept in `.env` and are not versioned. |
| NFR-004 | Local performance | Main views respond in less than 2 seconds with the pilot's expected volume. |
| NFR-005 | Integrity | Migrations, foreign keys, data validation, and transactions protect critical relationships. |
| NFR-006 | Backup | A documented procedure exists to export and restore the database. |

## 12.1 Non-functional requirements — continued

| **ID** | **Requirement** | **Verifiable objective** |
|---|---|---|
| NFR-007 | Auditability | Critical events are not deleted or overwritten through normal workflows. |
| NFR-008 | Usability | Desktop-first design, consistent navigation, clear labels, and actionable validations. |
| NFR-009 | Quality | Automated tests cover health rules, transitions, future permissions, and critical endpoints. |
| NFR-010 | Observability | Laravel logs errors and failed operations without exposing secrets. |
| NFR-011 | Privacy | No sensitive client data or external-system credentials are stored. |
| NFR-012 | Future portability | Stable IDs, a decoupled API, and abstracted storage facilitate migration to shared hosting. |

# 13. Proposed MVP architecture

The architecture uses technologies already known to the user and maintains sufficient separation so that the interface, business rules, and persistence can evolve independently.

```text
Angular SPA  ──REST──>  Laravel API  ──SQL──>  MySQL
```

## 13.1 Components

- Angular: interface, forms, filters, dashboard, and navigation.
- Laravel: REST API, validations, business rules, auditing, exports, and data access.
- MySQL: storage of projects, releases, statuses, follow-ups, and events.
- Local file system: backups and, if approved, attached evidence. For the MVP, links or references are preferred over large files.

## 13.2 Implementation decisions

- Authentication can be omitted in the first local run, but all auditable tables will retain `actor_created_by` and `actor_updated_by`.
- If SPA authentication is enabled, Laravel Sanctum will be used.
- Alerts will be calculated on demand when the dashboard loads; the scheduler will remain a future improvement.
- The installation will include migrations, seeders, example environment variables, and documented startup commands.

# 14. Initial Reports baseline

Reference date: August 7, 2026. This load is considered a seed for validation, not a guarantee of current status at the time of implementation.

| **Item** | **Confirmed** | **Not reached** | **Pending / next action** |
|---|---|---|---|
| UI Improvements | MOJA | TATU, SITA, PROD | Promotion pending; confirm sprint and release notes. |
| Payrun History — base | MOJA, TATU, SITA, PROD | — | Confirm availability and client groups with Ameet. |
| ePay Report — base | MOJA, TATU, SITA; previous version in PROD | — | Confirm active version and availability to clients. |
| ePay Report — improvements | MOJA, TATU | SITA, PROD | Confirm QA approval, release notes, and promotion. |
| Summary Report — base | MOJA; testing in TATU | SITA, PROD | Complete testing and define promotion. |
| Cheques & Payslips — Transfer | MOJA; merge in progress | TATU, SITA, PROD | Confirm merge and availability in TATU. |
| Cheques & Payslips — Report | MOJA | TATU, SITA, PROD | Define next milestone and owner. |
| PayExplorer — current scope | Development in MOJA | TATU, SITA, PROD | Confirm scope and target date. |
| Reports Homepage — current scope | Development in MOJA | TATU, SITA, PROD | Confirm scope and target date. |

# 15. Priority user stories

| **ID** | **Story** | **Expected result** |
|---|---|---|
| US-001 | As a BA, I want to see all my projects and their health so that I can prioritize my day. | Dashboard with filters and actionable alerts. |
| US-002 | As a BA, I want to separate a base module from its improvements so that I do not mix statuses. | Independent items within the same release or related releases. |
| US-003 | As a BA, I want to record who confirmed an environment and when so that I know whether the data is reliable. | Traceability visible in each status. |
| US-004 | As a BA, I want to distinguish PROD from client activation so that I avoid misleading reports. | Separate fields, statuses, and alerts. |
| US-005 | As a BA, I want to see overdue follow-ups so that I can contact the correct person. | Inbox ordered by priority and date. |
| US-006 | As a BA, I want to view the history so that I can explain how a release changed. | Immutable timeline. |
| US-007 | As a BA, I want to export a view so that I can share the status without granting access to my local application. | Filtered Excel or CSV. |

# 16. MVP acceptance criteria

- Related projects, modules, releases, and items can be created and viewed without orphaned records.
- The application contains the MOJA, TATU, SITA, and PROD environments and allows others to be configured.
- Each item displays its status by environment and the latest date, source, and person who confirmed it.
- PROD and client activation are registered and displayed separately.
- Every open item without a next action is automatically identified as an exception.
- Overdue follow-ups appear on the dashboard when the application is opened or refreshed.
- Status changes generate viewable audit events that cannot be edited through the normal workflow.
- The Reports baseline can be loaded and reproduces the known information.
- The database can be backed up and restored by following the included documentation.
- Critical tests pass and there are no blocking defects during pilot validation.

# 17. Validation and UAT plan

| **Stage** | **Activity** | **Output** |
|---|---|---|
| 1. Preparation | Configure the application and load Reports seed data. | Reproducible local instance. |
| 2. Verification | Compare each record against the matrix, transcripts, and current confirmations. | Baseline corrected and approved by Jhon. |
| 3. Parallel use | Operate the application and Excel during a short transition period. | Documented differences and friction points. |
| 4. UAT | Execute creation, promotion, blocking, activation, and follow-up scenarios. | Must criteria approved. |
| 5. Decision | Define whether the application replaces Excel for Reports. | Declared source of truth. |
| 6. Expansion | Add a second project with different characteristics. | Validation that the model is reusable. |

## 17.1 Minimum test scenarios

- Register an improvement that is in MOJA and TATU, but not in SITA or PROD.
- Register a module deployed to PROD whose client activation is not confirmed.
- Move an item to testing, block it, resolve the blocker, and verify its history.
- Create an overdue follow-up and confirm that the dashboard prioritizes it.
- Archive a release and verify that its relationships and history are retained.
- Export a filtered Reports view for external review.

# 18. Risks and mitigations

| **Risk** | **Impact** | **Mitigation** |
|---|---|---|
| Local single point of failure | Data loss or unavailability. | Documented automatic or manual backup; periodic restore test. |
| Outdated information | Decisions based on old statuses. | Staleness threshold, visible date, and weekly review routine. |
| Overengineering | Delay in operational value. | Protect the Must scope; defer integrations and multi-user access. |
| Incorrect baseline | Reduced trust in the tool. | Validate data with Ximena, QA, release contacts, and Ameet before closing. |
| User dependency | The tool is not maintained during absences. | Document the process and prepare a future transition to a shared environment. |
| Costly future migration | Rework as it grows. | REST API, stable IDs, UTC, migrations, auditing, and decoupled configuration. |
| Sensitive data | Accidental exposure. | Do not store credentials or client data; prefer secure references. |

# 19. Phases after the MVP

| **Phase** | **Candidate capabilities** | **Trigger** |
|---|---|---|
| Phase 1 — Local MVP | Reports, manual control, dashboard, auditing, and export. | Approval of this PRD. |
| Phase 2 — Portfolio | AdminAPI, Dashboard, Invoicing, and Fintrac; comparative reports. | Stable Reports pilot. |
| Phase 3 — Collaboration | Hosting, multiple users, roles, Entra, HTTPS, and managed backups. | Actual need for shared access. |
| Phase 4 — Integrations | Jira, Teams/email, pipelines, Power BI, and notifications. | Mature process and available APIs. |
| Phase 5 — Analytics | Lead time, aging, bottlenecks, and release reliability. | Sufficient and consistent historical data. |

# 20. Open questions

These questions do not prevent review of the PRD, but they must be resolved before estimating or building the affected stories.

| **ID** | **Question** | **Decision required before** |
|---|---|---|
| OQ-01 | Which versions of PHP, Laravel, Node, Angular, and MySQL are installed? | Prepare the environment and dependencies. |
| OQ-02 | Is local login required from the MVP, or is a fixed logical actor sufficient? | Implement authentication and auditing. |
| OQ-03 | Will evidence be only a URL/reference, or also an attached file? | Design storage and backups. |
| OQ-04 | Are environments global, or can they vary by project? | Finalize the configuration model. |
| OQ-05 | How many days without verification make a status “stale”? | Implement freshness alerts. |
| OQ-06 | What will the backup frequency and location be? | Finalize local operation. |
| OQ-07 | Will Excel or the application be the source of truth during the pilot? | Begin parallel use. |
| OQ-08 | Which second project will best test the model's reusability? | Plan expansion. |

# 21. Product Definition of Done

- All Must requirements are implemented, tested, and accepted by Jhon.
- There are no open blocking or data-loss defects.
- The Reports baseline is validated.
- Installation from scratch and local startup are documented and tested.
- A valid backup exists and its restoration has been demonstrated.
- The operational source of truth has been agreed upon at the end of the pilot.
- Deferred decisions and the subsequent backlog are recorded.

# 22. Glossary

| **Term** | **Operational definition** |
|---|---|
| MOJA | Initial development/validation environment used in the Reports workflow. |
| TATU | Testing environment; also mentioned as TATU 2 in the meetings. |
| SITA | Environment before PROD; it is not automatically equivalent to PROD. |
| PROD | Environment where a version is deployed. |
| Client Activation | Actual enablement of a feature for one or more clients, groups, or plans. |
| Release | Planned set of changes that are promoted as one coordination unit. |
| Release Item | Smallest unit whose progress, evidence, and next actions are tracked. |
| Evidence | Reference that makes it possible to support a status statement. |
| Stale | Status whose verification exceeds the defined threshold. |
| Soft delete | Logical archiving that retains relationships and history. |

# 23. Approvals

Approval of this document confirms the problem, scope, and acceptance criteria. It does not yet imply a definitive estimate or a delivery-date commitment.

| **Role** | **Name** | **Decision** | **Date** |
|---|---|---|---|
| Product Owner / BA | Jhon | Pending | — |
| Technical reviewer | To be defined | Pending | — |
| Reports pilot validator | Ximena / QA / release contact | Pending | — |

> **NEXT STEP**  
> Review the open questions, confirm the Reports baseline, and convert the Must requirements into an estimable backlog organized by product verticals.
