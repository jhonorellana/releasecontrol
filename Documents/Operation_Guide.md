# Release Control — Local Operation Guide

## Start the application

Start MariaDB from XAMPP first. Then open two PowerShell terminals in the project root.

```powershell
Set-Location backend
composer install
php artisan migrate
php artisan db:seed --class=Database\Seeders\ReportsPilotSeeder
php artisan serve
```

```powershell
Set-Location frontend
npm install
npm start
```

Open `http://localhost:4200`. The backend health endpoint is `http://127.0.0.1:8000/api/health`.

## Daily operation

1. Open Dashboard and address `BLOCKED`, `OVERDUE`, and `NEEDS_FOLLOW_UP` items first.
2. Update the affected environment with its status, verification date, source, and confirming person.
3. Register client activation separately after a PROD deployment.
4. Add or update a follow-up whenever an item depends on a person or team. Assign an owner and target date.
5. Attach a URL or reference as evidence for significant confirmations.
6. Use the CSV export for external status sharing.

## Backup

Create a local SQL backup from the project root:

```powershell
.\scripts\Backup-ReleaseControl.ps1
```

The output is written to `backups\` with a timestamped name. The directory is ignored by Git and must be copied to an approved secure location outside the development machine according to the agreed backup routine.

Recommended routine: take a backup after every material update session and retain at least the last seven daily copies. Run a restoration test monthly.

## Restore safely

Always validate a backup into a new database first. This command creates the isolated database `release_control_restore_test`:

```powershell
.\scripts\Restore-ReleaseControl.ps1 -Database release_control_restore_test -BackupFile .\backups\release_control-YYYYMMDD-HHMMSS.sql -CreateDatabase
```

The restore script refuses to overwrite an existing database unless `-AllowOverwrite` is passed explicitly. Use that switch only after confirming the exact target and having a newer backup.

## Updating source code

After receiving an application update:

```powershell
Set-Location backend
composer install
php artisan migrate --force
php artisan test

Set-Location ..\frontend
npm install
npm run build
```

## Known pilot controls

- The application is local and single-user; it is unavailable while the processes or machine are off.
- The imported Reports baseline has nine follow-ups without target dates. Add dates before relying on overdue alerts.
- Payrun History and ePay Report base releases are deployed to PROD but have unconfirmed client activation.
