<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $now = '2026-08-15 12:00:00.000000';
        $baselineDate = '2026-08-07 10:00:00.000000';

        // -------------------------------------------------------------
        // 1. APP SETTINGS
        // -------------------------------------------------------------
        $settings = [
            ['key' => 'display_timezone', 'value' => json_encode('America/Guayaquil'), 'description' => 'Default UI display timezone', 'updated_at' => $now],
            ['key' => 'stale_after_days', 'value' => json_encode(14), 'description' => 'Days before status verification is considered stale', 'updated_at' => $now],
            ['key' => 'default_project_code', 'value' => json_encode('REPORTS'), 'description' => 'Default selected project code', 'updated_at' => $now],
            ['key' => 'evidence_storage_mode', 'value' => json_encode('reference_only'), 'description' => 'Evidence storage mode', 'updated_at' => $now],
        ];
        DB::table('app_settings')->insert($settings);

        // -------------------------------------------------------------
        // 2. CATALOG VALUES WITH DESCRIPTIONS FROM EXCEL
        // -------------------------------------------------------------
        $catalogs = [
            // project_status
            ['category' => 'project_status', 'code' => 'active', 'label' => 'Active', 'description' => 'Active project currently under release management.', 'sort_order' => 10, 'color' => '#10B981', 'is_system' => true],
            ['category' => 'project_status', 'code' => 'on_hold', 'label' => 'On Hold', 'description' => 'Project activities temporarily suspended.', 'sort_order' => 20, 'color' => '#F59E0B', 'is_system' => true],
            ['category' => 'project_status', 'code' => 'completed', 'label' => 'Completed', 'description' => 'All project deliverables completed and archived.', 'sort_order' => 30, 'color' => '#3B82F6', 'is_system' => true],

            // module_status
            ['category' => 'module_status', 'code' => 'active', 'label' => 'Active', 'description' => 'Active functional module receiving release updates.', 'sort_order' => 10, 'color' => '#10B981', 'is_system' => true],
            ['category' => 'module_status', 'code' => 'on_hold', 'label' => 'On Hold', 'description' => 'Module updates temporarily paused.', 'sort_order' => 20, 'color' => '#F59E0B', 'is_system' => true],
            ['category' => 'module_status', 'code' => 'retired', 'label' => 'Retired', 'description' => 'Module deprecated or no longer supported.', 'sort_order' => 30, 'color' => '#6B7280', 'is_system' => true],

            // release_status
            ['category' => 'release_status', 'code' => 'planned', 'label' => 'Planned', 'description' => 'Release package planned and scoped for future deployment.', 'sort_order' => 10, 'color' => '#9CA3AF', 'is_system' => true],
            ['category' => 'release_status', 'code' => 'in_progress', 'label' => 'In Progress', 'description' => 'Release execution and multi-environment promotions active.', 'sort_order' => 20, 'color' => '#3B82F6', 'is_system' => true],
            ['category' => 'release_status', 'code' => 'ready', 'label' => 'Ready for PROD', 'description' => 'Release package fully approved and ready for production.', 'sort_order' => 30, 'color' => '#8B5CF6', 'is_system' => true],
            ['category' => 'release_status', 'code' => 'completed', 'label' => 'Completed', 'description' => 'Release deployed to production and client activation completed.', 'sort_order' => 40, 'color' => '#10B981', 'is_system' => true],
            ['category' => 'release_status', 'code' => 'cancelled', 'label' => 'Cancelled', 'description' => 'Release scope cancelled or deferred.', 'sort_order' => 50, 'color' => '#EF4444', 'is_system' => true],

            // release_item_status
            ['category' => 'release_item_status', 'code' => 'open', 'label' => 'Open', 'description' => 'Release unit identified and pending execution.', 'sort_order' => 10, 'color' => '#9CA3AF', 'is_system' => true],
            ['category' => 'release_item_status', 'code' => 'in_progress', 'label' => 'In Progress', 'description' => 'Release unit under active development or environment promotion.', 'sort_order' => 20, 'color' => '#3B82F6', 'is_system' => true],
            ['category' => 'release_item_status', 'code' => 'blocked', 'label' => 'Blocked', 'description' => 'Release unit progress blocked by external dependency or issue.', 'sort_order' => 30, 'color' => '#EF4444', 'is_system' => true],
            ['category' => 'release_item_status', 'code' => 'done', 'label' => 'Done', 'description' => 'Release unit fully deployed, verified, and closed.', 'sort_order' => 40, 'color' => '#10B981', 'is_system' => true],

            // release_item_type
            ['category' => 'release_item_type', 'code' => 'base', 'label' => 'Base Release', 'description' => 'Core base release feature or initial module deployment.', 'sort_order' => 10, 'color' => '#3B82F6', 'is_system' => true],
            ['category' => 'release_item_type', 'code' => 'improvement', 'label' => 'Improvement / Scope', 'description' => 'Enhancement, scope addition, or performance improvement.', 'sort_order' => 20, 'color' => '#8B5CF6', 'is_system' => true],
            ['category' => 'release_item_type', 'code' => 'bug', 'label' => 'Bug Fix', 'description' => 'Defect fix or patch for production/QA issues.', 'sort_order' => 30, 'color' => '#EF4444', 'is_system' => true],
            ['category' => 'release_item_type', 'code' => 'technical', 'label' => 'Technical Task', 'description' => 'Technical debt, infrastructure, or architectural work.', 'sort_order' => 40, 'color' => '#6B7280', 'is_system' => true],

            // priority (EXCEL DEFINITIONS)
            ['category' => 'priority', 'code' => 'critical', 'label' => 'Critical', 'description' => 'Immediate business or release risk.', 'sort_order' => 10, 'color' => '#DC2626', 'is_system' => true],
            ['category' => 'priority', 'code' => 'high', 'label' => 'High', 'description' => 'Requires active follow-up in the current sprint.', 'sort_order' => 20, 'color' => '#F59E0B', 'is_system' => true],
            ['category' => 'priority', 'code' => 'medium', 'label' => 'Medium', 'description' => 'Important but not currently blocking a release.', 'sort_order' => 30, 'color' => '#3B82F6', 'is_system' => true],
            ['category' => 'priority', 'code' => 'low', 'label' => 'Low', 'description' => 'Can be addressed after higher-priority work.', 'sort_order' => 40, 'color' => '#10B981', 'is_system' => true],

            // environment_state (EXCEL DEFINITIONS)
            ['category' => 'environment_state', 'code' => 'not_reached', 'label' => 'X - Not reached', 'description' => 'The release unit has not reached the environment.', 'sort_order' => 10, 'color' => '#9CA3AF', 'is_system' => true],
            ['category' => 'environment_state', 'code' => 'development', 'label' => 'Development', 'description' => 'Active development in the environment.', 'sort_order' => 20, 'color' => '#60A5FA', 'is_system' => true],
            ['category' => 'environment_state', 'code' => 'ready_to_promote', 'label' => 'Ready to promote', 'description' => 'Validated in the source environment and ready for promotion.', 'sort_order' => 25, 'color' => '#A78BFA', 'is_system' => true],
            ['category' => 'environment_state', 'code' => 'code_merging', 'label' => 'Code merging', 'description' => 'Merge or deployment preparation is in progress.', 'sort_order' => 30, 'color' => '#F59E0B', 'is_system' => true],
            ['category' => 'environment_state', 'code' => 'deployed', 'label' => 'Deployed', 'description' => 'Presence confirmed; test result is not yet recorded.', 'sort_order' => 40, 'color' => '#3B82F6', 'is_system' => true],
            ['category' => 'environment_state', 'code' => 'in_testing', 'label' => 'Testing', 'description' => 'Presence confirmed and QA validation is in progress.', 'sort_order' => 50, 'color' => '#F59E0B', 'is_system' => true],
            ['category' => 'environment_state', 'code' => 'approved', 'label' => 'Approved', 'description' => 'Presence and successful validation are confirmed.', 'sort_order' => 60, 'color' => '#10B981', 'is_system' => true],
            ['category' => 'environment_state', 'code' => 'blocked', 'label' => 'Blocked', 'description' => 'The release unit cannot progress until a blocker is resolved.', 'sort_order' => 70, 'color' => '#EF4444', 'is_system' => true],
            ['category' => 'environment_state', 'code' => 'unconfirmed', 'label' => 'Unconfirmed', 'description' => 'Environment presence or status needs confirmation.', 'sort_order' => 80, 'color' => '#F97316', 'is_system' => true],

            // activation_status (EXCEL DEFINITIONS)
            ['category' => 'activation_status', 'code' => 'not_applicable', 'label' => 'N/A', 'description' => 'Activation is not applicable before production.', 'sort_order' => 10, 'color' => '#9CA3AF', 'is_system' => true],
            ['category' => 'activation_status', 'code' => 'unconfirmed', 'label' => 'Unconfirmed', 'description' => 'Production presence or client access needs confirmation.', 'sort_order' => 20, 'color' => '#F97316', 'is_system' => true],
            ['category' => 'activation_status', 'code' => 'inactive', 'label' => 'Deployed - inactive', 'description' => 'Confirmed in production but not enabled for clients.', 'sort_order' => 30, 'color' => '#F59E0B', 'is_system' => true],
            ['category' => 'activation_status', 'code' => 'partial', 'label' => 'Pilot Group / Plan', 'description' => 'Enabled for a limited group of companies or plans.', 'sort_order' => 40, 'color' => '#8B5CF6', 'is_system' => true],
            ['category' => 'activation_status', 'code' => 'active', 'label' => 'Active for Clients', 'description' => 'Enabled for the intended client scope.', 'sort_order' => 50, 'color' => '#10B981', 'is_system' => true],

            // follow_up_status (EXCEL DEFINITIONS)
            ['category' => 'follow_up_status', 'code' => 'pending', 'label' => 'Pending', 'description' => 'Action has not started.', 'sort_order' => 10, 'color' => '#F59E0B', 'is_system' => true],
            ['category' => 'follow_up_status', 'code' => 'in_progress', 'label' => 'In Progress', 'description' => 'Action is actively being worked.', 'sort_order' => 20, 'color' => '#3B82F6', 'is_system' => true],
            ['category' => 'follow_up_status', 'code' => 'waiting', 'label' => 'Waiting Dependency', 'description' => 'Action depends on another person or event.', 'sort_order' => 30, 'color' => '#8B5CF6', 'is_system' => true],
            ['category' => 'follow_up_status', 'code' => 'completed', 'label' => 'Completed', 'description' => 'Result and evidence are recorded.', 'sort_order' => 40, 'color' => '#10B981', 'is_system' => true],
            ['category' => 'follow_up_status', 'code' => 'cancelled', 'label' => 'Cancelled', 'description' => 'Action is no longer required; reason must be recorded.', 'sort_order' => 50, 'color' => '#6B7280', 'is_system' => true],

            // evidence_type
            ['category' => 'evidence_type', 'code' => 'meeting', 'label' => 'Meeting Confirmation', 'description' => 'Meeting agreement or verbal alignment confirmation.', 'sort_order' => 10, 'color' => '#3B82F6', 'is_system' => true],
            ['category' => 'evidence_type', 'code' => 'jira', 'label' => 'Jira Ticket', 'description' => 'Jira ticket link or issue tracker reference.', 'sort_order' => 20, 'color' => '#0052CC', 'is_system' => true],
            ['category' => 'evidence_type', 'code' => 'teams', 'label' => 'Teams Chat', 'description' => 'Microsoft Teams chat or channel discussion reference.', 'sort_order' => 30, 'color' => '#6264A7', 'is_system' => true],
            ['category' => 'evidence_type', 'code' => 'email', 'label' => 'Email', 'description' => 'Email thread or approval message.', 'sort_order' => 40, 'color' => '#EA4335', 'is_system' => true],
            ['category' => 'evidence_type', 'code' => 'url', 'label' => 'Web Link', 'description' => 'Web link or external documentation reference.', 'sort_order' => 50, 'color' => '#10B981', 'is_system' => true],
            ['category' => 'evidence_type', 'code' => 'local_file', 'label' => 'Local Reference File', 'description' => 'Local document, log file, or attachment reference.', 'sort_order' => 60, 'color' => '#6B7280', 'is_system' => true],
        ];

        foreach ($catalogs as $item) {
            DB::table('catalog_values')->insert(array_merge($item, [
                'created_at' => $now,
                'updated_at' => $now,
            ]));
        }

        $catMap = function ($category, $code) {
            return DB::table('catalog_values')->where('category', $category)->where('code', $code)->value('id');
        };

        // -------------------------------------------------------------
        // 3. ENVIRONMENTS
        // -------------------------------------------------------------
        $environmentsData = [
            ['code' => 'MOJA', 'name' => 'MOJA', 'description' => 'Development & initial validation environment', 'default_sequence' => 10],
            ['code' => 'TATU', 'name' => 'TATU', 'description' => 'QA Testing environment', 'default_sequence' => 20],
            ['code' => 'SITA', 'name' => 'SITA', 'description' => 'Staging & pre-production environment', 'default_sequence' => 30],
            ['code' => 'PROD', 'name' => 'Production', 'description' => 'Live production environment', 'default_sequence' => 40],
        ];

        $envIdMap = [];
        foreach ($environmentsData as $env) {
            $id = DB::table('environments')->insertGetId(array_merge($env, [
                'is_active' => true,
                'created_at' => $now,
                'updated_at' => $now,
            ]));
            $envIdMap[$env['code']] = $id;
        }

        // -------------------------------------------------------------
        // 4. PEOPLE
        // -------------------------------------------------------------
        $peopleList = [
            'Jhon' => ['display_name' => 'Jhon', 'email' => 'jhon@company.local', 'role_title' => 'Product Owner / BA', 'team' => 'Business Analysis'],
            'Ximena' => ['display_name' => 'Ximena', 'email' => 'ximena@company.local', 'role_title' => 'Release Manager', 'team' => 'Operations'],
            'Ameet' => ['display_name' => 'Ameet', 'email' => 'ameet@company.local', 'role_title' => 'Product Lead', 'team' => 'Product Management'],
            'Alexis' => ['display_name' => 'Alexis', 'email' => 'alexis@company.local', 'role_title' => 'Frontend Developer', 'team' => 'Engineering'],
            'Ricardo' => ['display_name' => 'Ricardo', 'email' => 'ricardo@company.local', 'role_title' => 'QA Lead', 'team' => 'Quality Assurance'],
            'Kavitha' => ['display_name' => 'Kavitha', 'email' => 'kavitha@company.local', 'role_title' => 'Backend Developer', 'team' => 'Engineering'],
            'Paola' => ['display_name' => 'Paola', 'email' => 'paola@company.local', 'role_title' => 'QA Engineer', 'team' => 'Quality Assurance'],
        ];

        $peopleMap = [];
        foreach ($peopleList as $key => $person) {
            $id = DB::table('people')->insertGetId(array_merge($person, [
                'is_active' => true,
                'created_at' => $now,
                'updated_at' => $now,
            ]));
            $peopleMap[$key] = $id;
        }

        // -------------------------------------------------------------
        // 5. PROJECT & MODULES
        // -------------------------------------------------------------
        $projectId = DB::table('projects')->insertGetId([
            'name' => 'Reports',
            'code' => 'REPORTS',
            'description' => 'Reports module suite for payroll, payslips, ePay, and analytics.',
            'status_id' => $catMap('project_status', 'active'),
            'owner_person_id' => $peopleMap['Jhon'],
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        // Configure Project Environments
        $projEnvIdMap = [];
        foreach (['MOJA' => 10, 'TATU' => 20, 'SITA' => 30, 'PROD' => 40] as $code => $seq) {
            $penvId = DB::table('project_environments')->insertGetId([
                'project_id' => $projectId,
                'environment_id' => $envIdMap[$code],
                'sequence' => $seq,
                'is_required' => true,
                'is_active' => true,
                'created_at' => $now,
                'updated_at' => $now,
            ]);
            $projEnvIdMap[$code] = $penvId;
        }

        // Modules
        $modulesData = [
            'UI' => 'Cross-cutting UI',
            'PH' => 'Payrun History',
            'EP' => 'ePay Report',
            'SR' => 'Summary Report',
            'CP' => 'Cheques & Payslips',
            'PE' => 'PayExplorer',
            'HOME' => 'Reports Homepage',
        ];

        $moduleMap = [];
        foreach ($modulesData as $code => $name) {
            $id = DB::table('modules')->insertGetId([
                'project_id' => $projectId,
                'name' => $name,
                'code' => $code,
                'description' => $name . ' functional area.',
                'status_id' => $catMap('module_status', 'active'),
                'owner_person_id' => $peopleMap['Jhon'],
                'created_at' => $now,
                'updated_at' => $now,
            ]);
            $moduleMap[$code] = $id;
        }

        // Release
        $releaseId = DB::table('releases')->insertGetId([
            'project_id' => $projectId,
            'name' => 'Reports 2026.08 Release',
            'code' => 'REL-RPT-20260807',
            'scope' => 'Coordinated release package for Reports baseline as of August 7, 2026.',
            'status_id' => $catMap('release_status', 'in_progress'),
            'owner_person_id' => $peopleMap['Jhon'],
            'target_date' => '2026-08-31',
            'release_notes_url' => 'https://jira.company.local/browse/RPT-RELEASE-202608',
            'notes' => 'Baseline snapshot from meetings of August 7, 2026.',
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        // -------------------------------------------------------------
        // 6. RELEASE ITEMS (THE 9 SEED ITEMS FROM EXCEL)
        // -------------------------------------------------------------
        $seedItems = [
            [
                'code' => 'RPT-IMP-BASE',
                'module_id' => $moduleMap['UI'],
                'title' => 'Cross-cutting UI Improvements',
                'type' => 'improvement',
                'priority' => 'high',
                'dev_owner' => $peopleMap['Alexis'],
                'action' => 'Confirm sprint assignment and promotion to TATU',
                'states' => ['MOJA' => 'approved', 'TATU' => 'not_reached', 'SITA' => 'not_reached', 'PROD' => 'not_reached'],
                'activation' => 'not_applicable',
                'contact' => $peopleMap['Ximena'],
            ],
            [
                'code' => 'RPT-PH-BASE',
                'module_id' => $moduleMap['PH'],
                'title' => 'Payrun History – Base Release',
                'type' => 'base',
                'priority' => 'high',
                'dev_owner' => null,
                'action' => 'Confirm availability date, enabled plans and companies with Ameet',
                'states' => ['MOJA' => 'deployed', 'TATU' => 'deployed', 'SITA' => 'deployed', 'PROD' => 'deployed'],
                'activation' => 'unconfirmed',
                'contact' => $peopleMap['Ameet'],
            ],
            [
                'code' => 'RPT-EP-BASE',
                'module_id' => $moduleMap['EP'],
                'title' => 'ePay Report – Base Release',
                'type' => 'base',
                'priority' => 'high',
                'dev_owner' => $peopleMap['Kavitha'],
                'action' => 'Confirm production version and client availability with Ameet',
                'states' => ['MOJA' => 'deployed', 'TATU' => 'deployed', 'SITA' => 'deployed', 'PROD' => 'deployed'],
                'activation' => 'unconfirmed',
                'contact' => $peopleMap['Ameet'],
            ],
            [
                'code' => 'RPT-EP-IMP',
                'module_id' => $moduleMap['EP'],
                'title' => 'ePay Report – AdminAPI / Rejections / Dynamics Improvements',
                'type' => 'improvement',
                'priority' => 'high',
                'dev_owner' => $peopleMap['Kavitha'],
                'action' => 'Confirm QA result, release notes and promotion to SITA',
                'states' => ['MOJA' => 'deployed', 'TATU' => 'deployed', 'SITA' => 'not_reached', 'PROD' => 'not_reached'],
                'activation' => 'not_applicable',
                'contact' => $peopleMap['Paola'],
            ],
            [
                'code' => 'RPT-SR-BASE',
                'module_id' => $moduleMap['SR'],
                'title' => 'Summary Report – Base Release',
                'type' => 'base',
                'priority' => 'high',
                'dev_owner' => $peopleMap['Kavitha'],
                'action' => 'Complete TATU validation and record QA approval',
                'states' => ['MOJA' => 'deployed', 'TATU' => 'in_testing', 'SITA' => 'not_reached', 'PROD' => 'not_reached'],
                'activation' => 'not_applicable',
                'contact' => $peopleMap['Ricardo'],
            ],
            [
                'code' => 'RPT-CP-TRANSFER',
                'module_id' => $moduleMap['CP'],
                'title' => 'Cheques & Payslips – Transfer',
                'type' => 'improvement',
                'priority' => 'high',
                'dev_owner' => $peopleMap['Kavitha'],
                'action' => 'Finish merge and confirm deployment to TATU',
                'states' => ['MOJA' => 'deployed', 'TATU' => 'code_merging', 'SITA' => 'not_reached', 'PROD' => 'not_reached'],
                'activation' => 'not_applicable',
                'contact' => $peopleMap['Ximena'],
            ],
            [
                'code' => 'RPT-CP-REPORT',
                'module_id' => $moduleMap['CP'],
                'title' => 'Cheques & Payslips – Report',
                'type' => 'base',
                'priority' => 'medium',
                'dev_owner' => null,
                'action' => 'Confirm readiness and define the TATU promotion plan',
                'states' => ['MOJA' => 'deployed', 'TATU' => 'not_reached', 'SITA' => 'not_reached', 'PROD' => 'not_reached'],
                'activation' => 'not_applicable',
                'contact' => $peopleMap['Ximena'],
            ],
            [
                'code' => 'RPT-PE-BASE',
                'module_id' => $moduleMap['PE'],
                'title' => 'PayExplorer – Current Development Scope',
                'type' => 'base',
                'priority' => 'medium',
                'dev_owner' => null,
                'action' => 'Confirm scope, target sprint and readiness criteria',
                'states' => ['MOJA' => 'development', 'TATU' => 'not_reached', 'SITA' => 'not_reached', 'PROD' => 'not_reached'],
                'activation' => 'not_applicable',
                'contact' => $peopleMap['Ximena'],
            ],
            [
                'code' => 'RPT-HOME-BASE',
                'module_id' => $moduleMap['HOME'],
                'title' => 'Reports Homepage – Current Development Scope',
                'type' => 'base',
                'priority' => 'medium',
                'dev_owner' => null,
                'action' => 'Confirm scope, target sprint and readiness criteria',
                'states' => ['MOJA' => 'development', 'TATU' => 'not_reached', 'SITA' => 'not_reached', 'PROD' => 'not_reached'],
                'activation' => 'not_applicable',
                'contact' => $peopleMap['Ximena'],
            ],
        ];

        foreach ($seedItems as $item) {
            // Insert Release Item
            $itemId = DB::table('release_items')->insertGetId([
                'project_id' => $projectId,
                'release_id' => $releaseId,
                'module_id' => $item['module_id'],
                'title' => $item['title'],
                'description' => 'Baseline item ' . $item['code'],
                'item_type_id' => $catMap('release_item_type', $item['type']),
                'status_id' => $catMap('release_item_status', 'in_progress'),
                'priority_id' => $catMap('priority', $item['priority']),
                'owner_person_id' => $item['dev_owner'],
                'target_date' => '2026-08-31',
                'created_at' => $now,
                'updated_at' => $now,
            ]);

            // Insert Environment States
            foreach ($item['states'] as $envCode => $stateCode) {
                DB::table('release_item_environment_states')->insert([
                    'project_id' => $projectId,
                    'release_item_id' => $itemId,
                    'project_environment_id' => $projEnvIdMap[$envCode],
                    'status_id' => $catMap('environment_state', $stateCode),
                    'status_changed_at' => $baselineDate,
                    'verified_at' => $baselineDate,
                    'confirmed_by_person_id' => $peopleMap['Ximena'],
                    'source_summary' => 'Reconstructed baseline from 2026-08-07 meeting with Ximena',
                    'created_at' => $now,
                    'updated_at' => $now,
                ]);
            }

            // Insert Client Activation
            DB::table('client_activations')->insert([
                'release_item_id' => $itemId,
                'status_id' => $catMap('activation_status', $item['activation']),
                'scope_type' => $item['activation'] === 'not_applicable' ? 'not_applicable' : 'unknown',
                'scope_description' => $item['activation'] === 'unconfirmed' ? 'Usage in production needs confirmation with Ameet' : null,
                'verified_at' => $baselineDate,
                'confirmed_by_person_id' => $peopleMap['Ximena'],
                'source_summary' => '2026-08-07 release status review',
                'created_at' => $now,
                'updated_at' => $now,
            ]);

            // Insert Follow Up Action
            DB::table('follow_ups')->insert([
                'release_item_id' => $itemId,
                'action' => $item['action'],
                'status_id' => $catMap('follow_up_status', 'pending'),
                'priority_id' => $catMap('priority', $item['priority']),
                'owner_person_id' => $peopleMap['Jhon'],
                'contact_person_id' => $item['contact'],
                'due_date' => '2026-08-21',
                'is_blocker' => false,
                'notes' => 'Action required for baseline advancement',
                'created_at' => $now,
                'updated_at' => $now,
            ]);

            // Insert Initial Audit Event
            DB::table('audit_events')->insert([
                'entity_type' => 'release_item',
                'entity_id' => $itemId,
                'event_type' => 'baseline_registered',
                'changes' => json_encode(['initial_status' => 'in_progress', 'code' => $item['code']]),
                'context' => json_encode(['source' => 'Reports_Release_Control_001.xlsx']),
                'actor_person_id' => $peopleMap['Jhon'],
                'actor_name' => 'Jhon',
                'occurred_at' => $baselineDate,
                'created_at' => $now,
            ]);
        }
    }
}
