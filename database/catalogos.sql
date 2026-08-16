-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-08-2026 a las 01:01:52
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `release_control_db`
--
CREATE DATABASE IF NOT EXISTS `release_control_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `release_control_db`;

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
(37, 'activation_status', 'active', 'Active for Clients', 'Enabled for the intended client scope.', 40, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
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
(50, 'activation_status', 'bBasic', 'Business Basic', 'Enabled for Bussiness Basic Plan', 20, '#109981', 1, 1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000'),
(51, 'activation_status', 'bPlus', 'Business Plus', 'Enabled for Bussiness Plus Plan', 30, '#10A981', 1, 1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `catalog_values`
--
ALTER TABLE `catalog_values`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `catalog_values_category_code_unique` (`category`,`code`),
  ADD KEY `catalog_values_category_is_active_sort_order_index` (`category`,`is_active`,`sort_order`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `catalog_values`
--
ALTER TABLE `catalog_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
