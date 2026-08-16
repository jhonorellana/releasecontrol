# Release Control — UAT Report

**Scope:** Local MVP, Reports pilot  
**Technical execution date:** 2026-08-14  
**Human acceptance owner:** Jhon — pending execution

## Technical acceptance results

| ID | Scenario | Evidence | Result |
|---|---|---|---|
| UAT-01 | Create project, module, release, and item without an orphan. | `ReleaseControlApiTest` hierarchy test. | Pass |
| UAT-02 | Reject an environment update without date, source, and confirming person. | API validation test. | Pass |
| UAT-03 | Register PROD deployment separately from client activation. | API health test. | Pass |
| UAT-04 | Show a blocker before an overdue follow-up. | Health precedence test. | Pass |
| UAT-05 | Archive without deleting the record or audit history. | Archive test. | Pass |
| UAT-06 | Export release items as CSV. | Export and read-only history test. | Pass |
| UAT-07 | Load the Reports baseline with separate activation records. | `ReportsPilotSeederTest`. | Pass |
| UAT-08 | Backup and restore the database into an isolated database. | `release_control-20260814-221956.sql` restored to `release_control_restore_test`; 9 items, 36 environment statuses, 9 follow-ups, and 54 audit events verified. | Pass |
| UAT-09 | Review dashboard and workflows in local browser. | Jhon operational review. | Pending human acceptance |

## Required human walkthrough

Jhon should execute the following in the browser before accepting the pilot:

1. Create a temporary release item, register MOJA and TATU status, then archive it.
2. Open Payrun History and ePay Report base releases; confirm that PROD does not mean client activation.
3. Give a target date to at least one imported follow-up and verify its placement in the inbox.
4. Register a blocker, confirm Dashboard priority, then resolve it and review the immutable history.
5. Export the filtered Reports view and confirm that it is suitable for sharing.

## Acceptance decision

The automated technical criteria are satisfied. The pilot cannot be declared the operational source of truth until Jhon completes the human walkthrough, assigns target dates to the pending follow-ups, and records the decision below.

| Decision | Owner | Date |
|---|---|---|
| Pending | Jhon | — |
