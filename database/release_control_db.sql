-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-08-2026 a las 20:03:20
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

 drop database release_control_db;
--
-- Base de datos: `release_control_db`
--
CREATE DATABASE IF NOT EXISTS `release_control_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `release_control_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_settings`
--

DROP TABLE IF EXISTS `app_settings`;
CREATE TABLE `app_settings` (
  `key` varchar(100) NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`value`)),
  `description` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `app_settings`
--

INSERT INTO `app_settings` (`key`, `value`, `description`, `updated_at`) VALUES
('default_project_code', '\"REPORTS\"', 'Default selected project code', '2026-08-15 12:00:00.000000'),
('display_timezone', '\"America\\/Guayaquil\"', 'Default UI display timezone', '2026-08-15 12:00:00.000000'),
('evidence_storage_mode', '\"reference_only\"', 'Evidence storage mode', '2026-08-15 12:00:00.000000'),
('stale_after_days', '14', 'Days before status verification is considered stale', '2026-08-15 12:00:00.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audit_events`
--

DROP TABLE IF EXISTS `audit_events`;
CREATE TABLE `audit_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entity_type` varchar(80) NOT NULL,
  `entity_id` bigint(20) UNSIGNED NOT NULL,
  `event_type` varchar(80) NOT NULL,
  `changes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`changes`)),
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`context`)),
  `actor_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `actor_name` varchar(150) NOT NULL,
  `occurred_at` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `audit_events`
--

INSERT INTO `audit_events` (`id`, `entity_type`, `entity_id`, `event_type`, `changes`, `context`, `actor_person_id`, `actor_name`, `occurred_at`, `created_at`) VALUES
(1, 'release_item', 1, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-IMP-BASE\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(2, 'release_item', 2, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-PH-BASE\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(3, 'release_item', 3, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-EP-BASE\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(4, 'release_item', 4, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-EP-IMP\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(5, 'release_item', 5, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-SR-BASE\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(6, 'release_item', 6, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-CP-TRANSFER\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(7, 'release_item', 7, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-CP-REPORT\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(8, 'release_item', 8, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-PE-BASE\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(9, 'release_item', 9, 'baseline_registered', '{\"initial_status\":\"in_progress\",\"code\":\"RPT-HOME-BASE\"}', '{\"source\":\"Reports_Release_Control_001.xlsx\"}', 1, 'Jhon', '2026-08-07 10:00:00.000000', '2026-08-15 12:00:00.000000'),
(10, 'follow_up', 7, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Confirm readiness and define the TATU promotion plan...\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-16 18:00:25.000000', '2026-08-16 18:00:25.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalog_values`
--

DROP TABLE IF EXISTS `catalog_values`;
CREATE TABLE `catalog_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sort_order` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `color` char(7) DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `catalog_values`
--

INSERT INTO `catalog_values` (`id`, `category`, `code`, `label`, `description`, `sort_order`, `color`, `is_system`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'project_status', 'active', 'Active', 'Active project currently under release management.', 10, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(2, 'project_status', 'on_hold', 'On Hold', 'Project activities temporarily suspended.', 20, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(3, 'project_status', 'completed', 'Completed', 'All project deliverables completed and archived.', 30, '#3B82F6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(4, 'module_status', 'active', 'Active', 'Active functional module receiving release updates.', 10, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(5, 'module_status', 'on_hold', 'On Hold', 'Module updates temporarily paused.', 20, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(6, 'module_status', 'retired', 'Retired', 'Module deprecated or no longer supported.', 30, '#6B7280', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(7, 'release_status', 'planned', 'Planned', 'Release package planned and scoped for future deployment.', 10, '#9CA3AF', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(8, 'release_status', 'in_progress', 'In Progress', 'Release execution and multi-environment promotions active.', 20, '#3B82F6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(9, 'release_status', 'ready', 'Ready for PROD', 'Release package fully approved and ready for production.', 30, '#8B5CF6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(10, 'release_status', 'completed', 'Completed', 'Release deployed to production and client activation completed.', 40, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(11, 'release_status', 'cancelled', 'Cancelled', 'Release scope cancelled or deferred.', 50, '#EF4444', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(12, 'release_item_status', 'open', 'Open', 'Release unit identified and pending execution.', 10, '#9CA3AF', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(13, 'release_item_status', 'in_progress', 'In Progress', 'Release unit under active development or environment promotion.', 20, '#3B82F6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(14, 'release_item_status', 'blocked', 'Blocked', 'Release unit progress blocked by external dependency or issue.', 30, '#EF4444', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(15, 'release_item_status', 'done', 'Done', 'Release unit fully deployed, verified, and closed.', 40, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(16, 'release_item_type', 'base', 'Base Release', 'Core base release feature or initial module deployment.', 10, '#3B82F6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(17, 'release_item_type', 'improvement', 'Improvement / Scope', 'Enhancement, scope addition, or performance improvement.', 20, '#8B5CF6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(18, 'release_item_type', 'bug', 'Bug Fix', 'Defect fix or patch for production/QA issues.', 30, '#EF4444', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(19, 'release_item_type', 'technical', 'Technical Task', 'Technical debt, infrastructure, or architectural work.', 40, '#6B7280', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(20, 'priority', 'critical', 'Critical', 'Immediate business or release risk.', 10, '#DC2626', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(21, 'priority', 'high', 'High', 'Requires active follow-up in the current sprint.', 20, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(22, 'priority', 'medium', 'Medium', 'Important but not currently blocking a release.', 30, '#3B82F6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(23, 'priority', 'low', 'Low', 'Can be addressed after higher-priority work.', 40, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(24, 'environment_state', 'not_reached', 'Not reached', 'The release unit has not reached the environment.', 10, '#9CA3AF', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(25, 'environment_state', 'development', 'Development', 'Active development in the environment.', 20, '#60A5FA', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(26, 'environment_state', 'ready_to_promote', 'Ready to promote', 'Validated in the source environment and ready for promotion.', 25, '#A78BFA', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(27, 'environment_state', 'code_merging', 'Code merging', 'Merge or deployment preparation is in progress.', 30, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(28, 'environment_state', 'deployed', 'Deployed', 'Presence confirmed; test result is not yet recorded.', 40, '#3B82F6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(29, 'environment_state', 'in_testing', 'Testing', 'Presence confirmed and QA validation is in progress.', 50, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(30, 'environment_state', 'approved', 'Approved', 'Presence and successful validation are confirmed.', 60, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(31, 'environment_state', 'blocked', 'Blocked', 'The release unit cannot progress until a blocker is resolved.', 70, '#EF4444', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(32, 'environment_state', 'unconfirmed', 'Unconfirmed', 'Environment presence or status needs confirmation.', 80, '#F97316', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(33, 'activation_status', 'not_applicable', 'N/A', 'Activation is not applicable before production.', 60, '#9CA3AF', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(34, 'activation_status', 'unconfirmed', 'Unconfirmed', 'Production presence or client access needs confirmation.', 20, '#F97316', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(35, 'activation_status', 'inactive', 'Deployed - inactive', 'Confirmed in production but not enabled for clients.', 50, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(36, 'activation_status', 'limit', 'Limit', 'Enabled for a limited group of companies or plans.', 70, '#8B5CF6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(37, 'activation_status', 'active', 'Active for Clients', 'Enabled for the intended client scope.', 40, '#97f7d7', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-16 15:18:55.000000'),
(38, 'follow_up_status', 'pending', 'Pending', 'Action has not started.', 10, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(39, 'follow_up_status', 'in_progress', 'In Progress', 'Action is actively being worked.', 20, '#3B82F6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(40, 'follow_up_status', 'waiting', 'Waiting Dependency', 'Action depends on another person or event.', 30, '#8B5CF6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(41, 'follow_up_status', 'completed', 'Completed', 'Result and evidence are recorded.', 40, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(42, 'follow_up_status', 'cancelled', 'Cancelled', 'Action is no longer required; reason must be recorded.', 50, '#6B7280', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(43, 'evidence_type', 'meeting', 'Meeting Confirmation', 'Meeting agreement or verbal alignment confirmation.', 10, '#3B82F6', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(44, 'evidence_type', 'jira', 'Jira Ticket', 'Jira ticket link or issue tracker reference.', 20, '#0052CC', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(45, 'evidence_type', 'teams', 'Teams Chat', 'Microsoft Teams chat or channel discussion reference.', 30, '#6264A7', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(46, 'evidence_type', 'email', 'Email', 'Email thread or approval message.', 40, '#EA4335', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(47, 'evidence_type', 'url', 'Web Link', 'Web link or external documentation reference.', 50, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(48, 'evidence_type', 'local_file', 'Local Reference File', 'Local document, log file, or attachment reference.', 60, '#6B7280', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(49, 'activation_status', 'growth', 'Growth', 'Enabled for Growth Plan', 10, '#108981', 1, 1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000'),
(50, 'activation_status', 'bBasic', 'Business Basic', 'Enabled for Bussiness Basic Plan', 20, '#0de7bf', 1, 1, '0000-00-00 00:00:00.000000', '2026-08-16 15:19:21.000000'),
(51, 'activation_status', 'bPlus', 'Business Plus V2', 'Enabled for Bussiness Plus Plan', 30, '#36ecbc', 1, 1, '0000-00-00 00:00:00.000000', '2026-08-16 15:19:46.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `client_activations`
--

DROP TABLE IF EXISTS `client_activations`;
CREATE TABLE `client_activations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `release_item_id` bigint(20) UNSIGNED NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `scope_type` varchar(30) NOT NULL DEFAULT 'unknown',
  `scope_description` varchar(500) DEFAULT NULL,
  `activated_at` datetime(6) DEFAULT NULL,
  `verified_at` datetime(6) NOT NULL,
  `confirmed_by_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `confirmed_by_text` varchar(150) DEFAULT NULL,
  `source_summary` varchar(500) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `client_activations`
--

INSERT INTO `client_activations` (`id`, `release_item_id`, `status_id`, `scope_type`, `scope_description`, `activated_at`, `verified_at`, `confirmed_by_person_id`, `confirmed_by_text`, `source_summary`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(2, 2, 34, 'unknown', 'Usage in production needs confirmation with Ameet', NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(3, 3, 34, 'unknown', 'Usage in production needs confirmation with Ameet', NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(4, 4, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(5, 5, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(6, 6, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(7, 7, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(8, 8, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(9, 9, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `environments`
--

DROP TABLE IF EXISTS `environments`;
CREATE TABLE `environments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `default_sequence` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `environments`
--

INSERT INTO `environments` (`id`, `code`, `name`, `description`, `default_sequence`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'MOJA', 'MOJA', 'Development & initial validation environment', 10, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(2, 'TATU', 'TATU', 'QA Testing environment', 20, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(3, 'SITA', 'SITA', 'Staging & pre-production environment', 30, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(4, 'PROD', 'Production', 'Live production environment', 40, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evidences`
--

DROP TABLE IF EXISTS `evidences`;
CREATE TABLE `evidences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `release_item_id` bigint(20) UNSIGNED NOT NULL,
  `audit_event_id` bigint(20) UNSIGNED DEFAULT NULL,
  `evidence_type_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `reference_url` varchar(2048) DEFAULT NULL,
  `local_path` varchar(1000) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `captured_at` datetime(6) NOT NULL,
  `created_by_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `follow_ups`
--

DROP TABLE IF EXISTS `follow_ups`;
CREATE TABLE `follow_ups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `release_item_id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(500) NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `priority_id` bigint(20) UNSIGNED NOT NULL,
  `owner_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `contact_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `is_blocker` tinyint(1) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `outcome` text DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `follow_ups`
--

INSERT INTO `follow_ups` (`id`, `release_item_id`, `action`, `status_id`, `priority_id`, `owner_person_id`, `contact_person_id`, `due_date`, `is_blocker`, `notes`, `outcome`, `completed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Confirm sprint assignment and promotion to TATU', 38, 21, 1, 2, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(2, 2, 'Confirm availability date, enabled plans and companies with Ameet', 38, 21, 1, 3, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(3, 3, 'Confirm production version and client availability with Ameet', 38, 21, 1, 3, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(4, 4, 'Confirm QA result, release notes and promotion to SITA', 38, 21, 1, 7, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(5, 5, 'Complete TATU validation and record QA approval', 38, 21, 1, 5, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(6, 6, 'Finish merge and confirm deployment to TATU', 38, 21, 1, 2, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(7, 7, 'Confirm readiness and define the TATU promotion plan...', 38, 22, 1, 2, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-16 18:00:25.000000', NULL),
(8, 8, 'Confirm scope, target sprint and readiness criteria', 38, 22, 1, 2, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(9, 9, 'Confirm scope, target sprint and readiness criteria', 38, 22, 1, 2, '2026-08-21', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2026_08_15_000001_create_people_table', 1),
(3, '2026_08_15_000002_create_catalog_values_table', 1),
(4, '2026_08_15_000003_create_projects_table', 1),
(5, '2026_08_15_000004_create_modules_table', 1),
(6, '2026_08_15_000005_create_releases_table', 1),
(7, '2026_08_15_000006_create_release_items_table', 1),
(8, '2026_08_15_000007_create_environments_table', 1),
(9, '2026_08_15_000008_create_project_environments_table', 1),
(10, '2026_08_15_000009_create_release_item_environment_states_table', 1),
(11, '2026_08_15_000010_create_client_activations_table', 1),
(12, '2026_08_15_000011_create_follow_ups_table', 1),
(13, '2026_08_15_000012_create_audit_events_table', 1),
(14, '2026_08_15_000013_create_evidences_table', 1),
(15, '2026_08_15_000014_create_app_settings_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `owner_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `modules`
--

INSERT INTO `modules` (`id`, `project_id`, `name`, `code`, `description`, `status_id`, `owner_person_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Cross-cutting UI', 'UI', 'Cross-cutting UI functional area.', 4, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(2, 1, 'Payrun History', 'PH', 'Payrun History functional area.', 4, 1, '2026-08-15 12:00:00.000000', '2026-08-16 16:55:48.000000', NULL),
(3, 1, 'ePay Report', 'EP', 'ePay Report functional area.', 4, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(4, 1, 'Summary Report', 'SR', 'Summary Report functional area.', 4, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(5, 1, 'Cheques & Payslips', 'CP', 'Cheques & Payslips functional area.', 4, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(6, 1, 'PayExplorer', 'PE', 'PayExplorer functional area.', 4, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(7, 1, 'Reports Homepage', 'HOME', 'Reports Homepage functional area.', 4, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(8, 2, 'EFT REJECTS', 'EFT REJECTS', 'EFT REJECTS', 4, NULL, '2026-08-16 16:44:58.000000', '2026-08-16 16:44:58.000000', NULL),
(9, 2, 'EDI Processing', 'EDI_Processing', 'EDI_Processing', 4, NULL, '2026-08-16 16:45:26.000000', '2026-08-16 16:56:02.000000', NULL),
(10, 2, 'EFT Processing', 'EFT_Processing', 'EFT Processing', 4, NULL, '2026-08-16 16:56:27.000000', '2026-08-16 16:56:34.000000', NULL),
(11, 2, 'EFT Sync & Generation', 'EFT_Sync_Generation', 'EFT Sync & Generation', 4, NULL, '2026-08-16 16:57:21.000000', '2026-08-16 16:57:21.000000', NULL),
(12, 2, 'eMailReminders', 'eMailReminders', 'eMailReminders', 4, NULL, '2026-08-16 16:58:02.000000', '2026-08-16 16:58:02.000000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `people`
--

DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `display_name` varchar(150) NOT NULL,
  `email` varchar(190) DEFAULT NULL,
  `role_title` varchar(120) DEFAULT NULL,
  `team` varchar(120) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `people`
--

INSERT INTO `people` (`id`, `display_name`, `email`, `role_title`, `team`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Jhon', 'jhon.orellana@paymentevolution.com', 'Product Owner / BA', 'Business Analysis', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(2, 'Ximena', 'ximena@paymentevolution.com', 'Release Manager', 'Operations', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(3, 'Ameet', 'ameet@paymentevolution.com', 'Product Lead', 'Product Management', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(4, 'Alexis', 'alexis@paymentevolution.com', 'Frontend Developer', 'Engineering', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(5, 'Ricardo', 'ricardo@paymentevolution.com', 'QA Lead', 'Quality Assurance', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(6, 'Kavitha', 'kavitha@paymentevolution.com', 'Backend Developer', 'Engineering', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(7, 'Paola', 'paola@paymentevolution.com', 'QA Engineer', 'Quality Assurance', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(8, 'Mario', 'mario@paymentevolution.com', 'Fullstack Developer', 'Engineering', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(9, 'Brad', 'brad@paymentevolution.com', 'Frontend Developer', 'Engineering', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(10, 'Kruger', 'kruger@paymentevolution.com', 'Frontend Developer', 'Engineering', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(11, 'Valli', 'valli@paymentevolution.com', 'Backend Developer', 'Engineering', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `code` varchar(40) NOT NULL,
  `description` text DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `owner_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `projects`
--

INSERT INTO `projects` (`id`, `name`, `code`, `description`, `status_id`, `owner_person_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Reports', 'REPORTS', 'Reports module suite for payroll, payslips, ePay, and analytics.', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(2, 'ADMINAPI', 'ADMNAPI', 'All features related to EFT and EDI files', 1, 1, '2026-08-16 16:43:35.000000', '2026-08-16 16:43:35.000000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_environments`
--

DROP TABLE IF EXISTS `project_environments`;
CREATE TABLE `project_environments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `environment_id` bigint(20) UNSIGNED NOT NULL,
  `sequence` smallint(5) UNSIGNED NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `project_environments`
--

INSERT INTO `project_environments` (`id`, `project_id`, `environment_id`, `sequence`, `is_required`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10, 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(2, 1, 2, 20, 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(3, 1, 3, 30, 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(4, 1, 4, 40, 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(5, 2, 1, 10, 1, 1, '2026-08-16 16:43:35.000000', '2026-08-16 16:43:35.000000'),
(6, 2, 2, 20, 1, 1, '2026-08-16 16:43:35.000000', '2026-08-16 16:43:35.000000'),
(7, 2, 3, 30, 1, 1, '2026-08-16 16:43:35.000000', '2026-08-16 16:43:35.000000'),
(8, 2, 4, 40, 1, 1, '2026-08-16 16:43:35.000000', '2026-08-16 16:43:35.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `releases`
--

DROP TABLE IF EXISTS `releases`;
CREATE TABLE `releases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `code` varchar(60) NOT NULL,
  `scope` text DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `owner_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `target_date` date DEFAULT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `release_notes_url` varchar(2048) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `releases`
--

INSERT INTO `releases` (`id`, `project_id`, `name`, `code`, `scope`, `status_id`, `owner_person_id`, `target_date`, `started_at`, `completed_at`, `release_notes_url`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Reports 2026.08 Release', 'REL-RPT-20260807', 'Coordinated release package for Reports baseline as of August 7, 2026.', 8, 1, '2026-08-31', NULL, NULL, 'https://jira.company.local/browse/RPT-RELEASE-202608', 'Baseline snapshot from meetings of August 7, 2026.', '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(2, 1, 'Summary Report & ePay Report improvements', 'REL-Summary&ePay', 'Summary Report & ePay Report improvements, it includes interaction with AdminAPI', 8, NULL, '2023-08-31', NULL, NULL, NULL, NULL, '2026-08-16 16:20:38.000000', '2026-08-16 16:20:38.000000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `release_items`
--

DROP TABLE IF EXISTS `release_items`;
CREATE TABLE `release_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `release_id` bigint(20) UNSIGNED NOT NULL,
  `module_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `item_type_id` bigint(20) UNSIGNED NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `priority_id` bigint(20) UNSIGNED NOT NULL,
  `owner_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `jira_key` varchar(40) DEFAULT NULL,
  `jira_url` varchar(2048) DEFAULT NULL,
  `next_action` varchar(500) DEFAULT NULL,
  `target_date` date DEFAULT NULL,
  `closed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `release_items`
--

INSERT INTO `release_items` (`id`, `project_id`, `release_id`, `module_id`, `title`, `description`, `item_type_id`, `status_id`, `priority_id`, `owner_person_id`, `jira_key`, `jira_url`, `next_action`, `target_date`, `closed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, 'Cross-cutting UI Improvements', 'Some improvements which are related to all reports', 17, 13, 21, 4, NULL, NULL, 'Confirm sprint assignment and promotion to TATU', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-16 16:14:00.000000', NULL),
(2, 1, 1, 2, 'Payrun History – Base Release', 'Baseline item RPT-PH-BASE', 16, 13, 21, 4, NULL, NULL, 'Confirm availability date, enabled plans and companies with Ameet', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-16 17:25:41.000000', NULL),
(3, 1, 1, 3, 'ePay Report – Base Release', 'Baseline item RPT-EP-BASE', 16, 13, 21, 6, NULL, NULL, 'Confirm production version and client availability with Ameet', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(4, 1, 1, 3, 'ePay Report – AdminAPI / Rejections / Dynamics Improvements', 'Baseline item RPT-EP-IMP', 17, 13, 21, 6, NULL, NULL, 'Confirm QA result, release notes and promotion to SITA', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(5, 1, 1, 4, 'Summary Report – Base Release', 'Baseline item RPT-SR-BASE', 16, 13, 21, 6, NULL, NULL, 'Complete TATU validation and record QA approval', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(6, 1, 1, 5, 'Cheques & Payslips – Transfer', 'Baseline item RPT-CP-TRANSFER', 17, 13, 21, 6, NULL, NULL, 'Finish merge and confirm deployment to TATU', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(7, 1, 1, 5, 'Cheques & Payslips – Report', 'Baseline item RPT-CP-REPORT', 16, 13, 22, NULL, NULL, NULL, 'Confirm readiness and define the TATU promotion plan', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(8, 1, 1, 6, 'PayExplorer – Current Development Scope', 'Baseline item RPT-PE-BASE', 16, 13, 22, NULL, NULL, NULL, 'Confirm scope, target sprint and readiness criteria', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(9, 1, 1, 7, 'Reports Homepage – Current Development Scope', 'Baseline item RPT-HOME-BASE', 16, 13, 22, NULL, NULL, NULL, 'Confirm scope, target sprint and readiness criteria', '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `release_item_environment_states`
--

DROP TABLE IF EXISTS `release_item_environment_states`;
CREATE TABLE `release_item_environment_states` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `release_item_id` bigint(20) UNSIGNED NOT NULL,
  `project_environment_id` bigint(20) UNSIGNED NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `status_changed_at` datetime(6) NOT NULL,
  `verified_at` datetime(6) NOT NULL,
  `confirmed_by_person_id` bigint(20) UNSIGNED DEFAULT NULL,
  `confirmed_by_text` varchar(150) DEFAULT NULL,
  `source_summary` varchar(500) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `release_item_environment_states`
--

INSERT INTO `release_item_environment_states` (`id`, `project_id`, `release_item_id`, `project_environment_id`, `status_id`, `status_changed_at`, `verified_at`, `confirmed_by_person_id`, `confirmed_by_text`, `source_summary`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 30, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(2, 1, 1, 2, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(3, 1, 1, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(4, 1, 1, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(5, 1, 2, 1, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(6, 1, 2, 2, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(7, 1, 2, 3, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(8, 1, 2, 4, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(9, 1, 3, 1, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(10, 1, 3, 2, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(11, 1, 3, 3, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(12, 1, 3, 4, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(13, 1, 4, 1, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(14, 1, 4, 2, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(15, 1, 4, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(16, 1, 4, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(17, 1, 5, 1, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(18, 1, 5, 2, 29, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(19, 1, 5, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(20, 1, 5, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(21, 1, 6, 1, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(22, 1, 6, 2, 27, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(23, 1, 6, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(24, 1, 6, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(25, 1, 7, 1, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(26, 1, 7, 2, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(27, 1, 7, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(28, 1, 7, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(29, 1, 8, 1, 25, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(30, 1, 8, 2, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(31, 1, 8, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(32, 1, 8, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(33, 1, 9, 1, 25, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(34, 1, 9, 2, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(35, 1, 9, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(36, 1, 9, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `audit_events`
--
ALTER TABLE `audit_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_events_entity_type_entity_id_occurred_at_index` (`entity_type`,`entity_id`,`occurred_at`),
  ADD KEY `audit_events_event_type_occurred_at_index` (`event_type`,`occurred_at`),
  ADD KEY `audit_events_actor_person_id_occurred_at_index` (`actor_person_id`,`occurred_at`);

--
-- Indices de la tabla `catalog_values`
--
ALTER TABLE `catalog_values`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `catalog_values_category_code_unique` (`category`,`code`),
  ADD KEY `catalog_values_category_is_active_sort_order_index` (`category`,`is_active`,`sort_order`);

--
-- Indices de la tabla `client_activations`
--
ALTER TABLE `client_activations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `client_activations_release_item_id_unique` (`release_item_id`),
  ADD KEY `client_activations_confirmed_by_person_id_foreign` (`confirmed_by_person_id`),
  ADD KEY `client_activations_status_id_verified_at_index` (`status_id`,`verified_at`);

--
-- Indices de la tabla `environments`
--
ALTER TABLE `environments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `environments_code_unique` (`code`);

--
-- Indices de la tabla `evidences`
--
ALTER TABLE `evidences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evidences_evidence_type_id_foreign` (`evidence_type_id`),
  ADD KEY `evidences_created_by_person_id_foreign` (`created_by_person_id`),
  ADD KEY `evidences_release_item_id_captured_at_index` (`release_item_id`,`captured_at`),
  ADD KEY `evidences_audit_event_id_index` (`audit_event_id`);

--
-- Indices de la tabla `follow_ups`
--
ALTER TABLE `follow_ups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `follow_ups_priority_id_foreign` (`priority_id`),
  ADD KEY `follow_ups_contact_person_id_foreign` (`contact_person_id`),
  ADD KEY `follow_ups_status_id_due_date_index` (`status_id`,`due_date`),
  ADD KEY `follow_ups_owner_person_id_status_id_due_date_index` (`owner_person_id`,`status_id`,`due_date`),
  ADD KEY `follow_ups_release_item_id_status_id_index` (`release_item_id`,`status_id`),
  ADD KEY `follow_ups_is_blocker_status_id_index` (`is_blocker`,`status_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `modules_project_id_code_unique` (`project_id`,`code`),
  ADD KEY `modules_status_id_foreign` (`status_id`),
  ADD KEY `modules_owner_person_id_foreign` (`owner_person_id`),
  ADD KEY `modules_project_id_status_id_deleted_at_index` (`project_id`,`status_id`,`deleted_at`);

--
-- Indices de la tabla `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `people_email_unique` (`email`),
  ADD KEY `people_display_name_index` (`display_name`),
  ADD KEY `people_is_active_index` (`is_active`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `projects_code_unique` (`code`),
  ADD KEY `projects_status_id_deleted_at_index` (`status_id`,`deleted_at`),
  ADD KEY `projects_owner_person_id_deleted_at_index` (`owner_person_id`,`deleted_at`);

--
-- Indices de la tabla `project_environments`
--
ALTER TABLE `project_environments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `project_environments_project_id_environment_id_unique` (`project_id`,`environment_id`),
  ADD UNIQUE KEY `project_environments_project_id_sequence_unique` (`project_id`,`sequence`),
  ADD KEY `project_environments_environment_id_foreign` (`environment_id`),
  ADD KEY `project_environments_project_id_is_active_sequence_index` (`project_id`,`is_active`,`sequence`);

--
-- Indices de la tabla `releases`
--
ALTER TABLE `releases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `releases_project_id_code_unique` (`project_id`,`code`),
  ADD KEY `releases_status_id_foreign` (`status_id`),
  ADD KEY `releases_owner_person_id_foreign` (`owner_person_id`),
  ADD KEY `releases_project_id_status_id_target_date_index` (`project_id`,`status_id`,`target_date`);

--
-- Indices de la tabla `release_items`
--
ALTER TABLE `release_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `release_items_item_type_id_foreign` (`item_type_id`),
  ADD KEY `release_items_status_id_foreign` (`status_id`),
  ADD KEY `release_items_priority_id_foreign` (`priority_id`),
  ADD KEY `release_items_owner_person_id_foreign` (`owner_person_id`),
  ADD KEY `release_items_release_id_status_id_index` (`release_id`,`status_id`),
  ADD KEY `release_items_module_id_status_id_index` (`module_id`,`status_id`),
  ADD KEY `release_items_project_id_priority_id_target_date_index` (`project_id`,`priority_id`,`target_date`);

--
-- Indices de la tabla `release_item_environment_states`
--
ALTER TABLE `release_item_environment_states`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_env_unique` (`release_item_id`,`project_environment_id`),
  ADD KEY `release_item_environment_states_project_id_foreign` (`project_id`),
  ADD KEY `release_item_environment_states_confirmed_by_person_id_foreign` (`confirmed_by_person_id`),
  ADD KEY `env_status_idx` (`project_environment_id`,`status_id`),
  ADD KEY `status_ver_idx` (`status_id`,`verified_at`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audit_events`
--
ALTER TABLE `audit_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `catalog_values`
--
ALTER TABLE `catalog_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `client_activations`
--
ALTER TABLE `client_activations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `environments`
--
ALTER TABLE `environments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `evidences`
--
ALTER TABLE `evidences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `follow_ups`
--
ALTER TABLE `follow_ups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `people`
--
ALTER TABLE `people`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `project_environments`
--
ALTER TABLE `project_environments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `releases`
--
ALTER TABLE `releases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `release_items`
--
ALTER TABLE `release_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `release_item_environment_states`
--
ALTER TABLE `release_item_environment_states`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `audit_events`
--
ALTER TABLE `audit_events`
  ADD CONSTRAINT `audit_events_actor_person_id_foreign` FOREIGN KEY (`actor_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `client_activations`
--
ALTER TABLE `client_activations`
  ADD CONSTRAINT `client_activations_confirmed_by_person_id_foreign` FOREIGN KEY (`confirmed_by_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `client_activations_release_item_id_foreign` FOREIGN KEY (`release_item_id`) REFERENCES `release_items` (`id`),
  ADD CONSTRAINT `client_activations_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `catalog_values` (`id`);

--
-- Filtros para la tabla `evidences`
--
ALTER TABLE `evidences`
  ADD CONSTRAINT `evidences_audit_event_id_foreign` FOREIGN KEY (`audit_event_id`) REFERENCES `audit_events` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `evidences_created_by_person_id_foreign` FOREIGN KEY (`created_by_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `evidences_evidence_type_id_foreign` FOREIGN KEY (`evidence_type_id`) REFERENCES `catalog_values` (`id`),
  ADD CONSTRAINT `evidences_release_item_id_foreign` FOREIGN KEY (`release_item_id`) REFERENCES `release_items` (`id`);

--
-- Filtros para la tabla `follow_ups`
--
ALTER TABLE `follow_ups`
  ADD CONSTRAINT `follow_ups_contact_person_id_foreign` FOREIGN KEY (`contact_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `follow_ups_owner_person_id_foreign` FOREIGN KEY (`owner_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `follow_ups_priority_id_foreign` FOREIGN KEY (`priority_id`) REFERENCES `catalog_values` (`id`),
  ADD CONSTRAINT `follow_ups_release_item_id_foreign` FOREIGN KEY (`release_item_id`) REFERENCES `release_items` (`id`),
  ADD CONSTRAINT `follow_ups_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `catalog_values` (`id`);

--
-- Filtros para la tabla `modules`
--
ALTER TABLE `modules`
  ADD CONSTRAINT `modules_owner_person_id_foreign` FOREIGN KEY (`owner_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `modules_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `modules_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `catalog_values` (`id`);

--
-- Filtros para la tabla `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_owner_person_id_foreign` FOREIGN KEY (`owner_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `projects_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `catalog_values` (`id`);

--
-- Filtros para la tabla `project_environments`
--
ALTER TABLE `project_environments`
  ADD CONSTRAINT `project_environments_environment_id_foreign` FOREIGN KEY (`environment_id`) REFERENCES `environments` (`id`),
  ADD CONSTRAINT `project_environments_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`);

--
-- Filtros para la tabla `releases`
--
ALTER TABLE `releases`
  ADD CONSTRAINT `releases_owner_person_id_foreign` FOREIGN KEY (`owner_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `releases_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `releases_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `catalog_values` (`id`);

--
-- Filtros para la tabla `release_items`
--
ALTER TABLE `release_items`
  ADD CONSTRAINT `release_items_item_type_id_foreign` FOREIGN KEY (`item_type_id`) REFERENCES `catalog_values` (`id`),
  ADD CONSTRAINT `release_items_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`),
  ADD CONSTRAINT `release_items_owner_person_id_foreign` FOREIGN KEY (`owner_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `release_items_priority_id_foreign` FOREIGN KEY (`priority_id`) REFERENCES `catalog_values` (`id`),
  ADD CONSTRAINT `release_items_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `release_items_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`),
  ADD CONSTRAINT `release_items_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `catalog_values` (`id`);

--
-- Filtros para la tabla `release_item_environment_states`
--
ALTER TABLE `release_item_environment_states`
  ADD CONSTRAINT `release_item_environment_states_confirmed_by_person_id_foreign` FOREIGN KEY (`confirmed_by_person_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `release_item_environment_states_project_environment_id_foreign` FOREIGN KEY (`project_environment_id`) REFERENCES `project_environments` (`id`),
  ADD CONSTRAINT `release_item_environment_states_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `release_item_environment_states_release_item_id_foreign` FOREIGN KEY (`release_item_id`) REFERENCES `release_items` (`id`),
  ADD CONSTRAINT `release_item_environment_states_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `catalog_values` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
