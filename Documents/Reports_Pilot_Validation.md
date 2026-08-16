# Reports Pilot — Baseline Validation

**Source:** `Reports_Release_Control_001.xlsx`  
**Baseline date:** 2026-08-07  
**Loaded by:** `ReportsPilotSeeder`

## Loaded records

- 1 project: Reports.
- 7 modules: Reports, Payrun History, ePay Report, Summary Report, Cheques & Payslips, PayExplorer, and Reports Homepage.
- 9 release records and 9 independent release items.
- 36 environment-status records: four environments for every release item.
- 9 client-activation records, including 2 `UNCONFIRMED` records for Payrun History and ePay Report.
- 9 open follow-ups and 9 evidence references.

## Mapping decisions

| Excel value | MVP record |
|---|---|
| Release ID | `Release.name` |
| Product / Module | `Module.name` under the Reports project |
| Release Unit / Scope | `ReleaseItem.title` |
| Production Deployment | The `PROD` environment status |
| Deployed - inactive | `PROD = DEPLOYED` plus `ClientActivation = UNCONFIRMED` |
| X - Not reached | `EnvironmentStatus = NOT_REACHED` |
| Last Verified / Confirmed By | Verification metadata for each imported environment status |

## Data validated from the Excel

- Base and improvement scopes that differ by environment were loaded as independent items.
- No technical deployment was converted automatically into active client access.
- Every imported environment status has the baseline verification date, source, and confirming person.
- Every open item has a next action and an assigned follow-up owner/contact.

## Items requiring operational confirmation

The Excel intentionally has no target date for its nine open actions. They remain without `due_date` after import and therefore are visible as `ACTION_REQUIRED` or, where applicable, `NEEDS_FOLLOW_UP`. Target dates must be agreed with the listed contacts before declaring the application the operational source of truth.

The two items already deployed to PROD require confirmation from Ameet of the enabled plans/companies and client availability:

1. Payrun History — Base Release.
2. ePay Report — Base Release.

The baseline is a validated import of the documented snapshot, not a statement of current production status after 2026-08-07.
