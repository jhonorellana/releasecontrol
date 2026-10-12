-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-09-2026 a las 17:05:57
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
CREATE DATABASE IF NOT EXISTS `release_control_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
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
(10, 'follow_up', 7, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Confirm readiness and define the TATU promotion plan...\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-16 18:00:25.000000', '2026-08-16 18:00:25.000000'),
(11, 'follow_up', 7, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Confirm readiness and define the TATU promotion plan\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:09:25.000000', '2026-08-17 19:09:25.000000'),
(12, 'follow_up', 7, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Confirm that payslips transference is ready. Ater that define the TATU promotion plan\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:34:22.000000', '2026-08-17 19:34:22.000000'),
(13, 'release_item', 6, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":27,\"new_status_id\":29,\"source_summary\":\"Coordinating with Ximena and Mario -  2026-08-17\"}', '{\"notes\":\"Backend is ready. AdminAPI in progress\"}', NULL, 'Jhon', '2026-08-17 19:36:21.000000', '2026-08-17 19:36:21.000000'),
(14, 'follow_up', 6, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Finish backend merge and confirm deployment to TATU\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:37:37.000000', '2026-08-17 19:37:37.000000'),
(15, 'follow_up', 10, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Mario confirm deployment on TATU\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:40:25.000000', '2026-08-17 19:40:25.000000'),
(16, 'follow_up', 10, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Mario confirm frontend deployment on TATU\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:41:04.000000', '2026-08-17 19:41:04.000000'),
(17, 'release_item', 1, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":30,\"new_status_id\":28,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:41:38.000000', '2026-08-17 19:41:38.000000'),
(18, 'release_item', 1, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":24,\"new_status_id\":28,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:42:08.000000', '2026-08-17 19:42:08.000000'),
(19, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:45:29.000000', '2026-08-17 19:45:29.000000'),
(20, 'follow_up', 8, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Dontinue development\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:46:05.000000', '2026-08-17 19:46:05.000000'),
(21, 'follow_up', 8, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Continue development\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:46:16.000000', '2026-08-17 19:46:16.000000'),
(22, 'follow_up', 9, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Continue develpment\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:49:06.000000', '2026-08-17 19:49:06.000000'),
(23, 'release_item', 7, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":28,\"new_status_id\":30,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:53:38.000000', '2026-08-17 19:53:38.000000'),
(24, 'release_item', 6, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:54:00.000000', '2026-08-17 19:54:00.000000'),
(25, 'release_item', 1, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":28,\"new_status_id\":29,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:54:19.000000', '2026-08-17 19:54:19.000000'),
(26, 'release_item', 1, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":29,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:54:34.000000', '2026-08-17 19:54:34.000000'),
(27, 'release_item', 2, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:54:57.000000', '2026-08-17 19:54:57.000000'),
(28, 'release_item', 2, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:55:04.000000', '2026-08-17 19:55:04.000000'),
(29, 'release_item', 2, 'environment_state_changed', '{\"project_environment_id\":\"3\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:55:12.000000', '2026-08-17 19:55:12.000000'),
(30, 'release_item', 5, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:55:36.000000', '2026-08-17 19:55:36.000000'),
(31, 'release_item', 4, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:58:05.000000', '2026-08-17 19:58:05.000000'),
(32, 'release_item', 4, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":28,\"new_status_id\":30,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:58:19.000000', '2026-08-17 19:58:19.000000'),
(33, 'follow_up', 4, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Confirm with Ameet to deploy on SITA\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 19:58:50.000000', '2026-08-17 19:58:50.000000'),
(34, 'release_item', 3, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:59:05.000000', '2026-08-17 19:59:05.000000'),
(35, 'release_item', 3, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:59:10.000000', '2026-08-17 19:59:10.000000'),
(36, 'release_item', 3, 'environment_state_changed', '{\"project_environment_id\":\"3\",\"old_status_id\":28,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-17 19:59:17.000000', '2026-08-17 19:59:17.000000'),
(37, 'follow_up', 7, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Confirm that payslips transference is ready. After that define the TATU promotion plan\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-17 20:22:07.000000', '2026-08-17 20:22:07.000000'),
(38, 'release_item', 10, 'item_created', '{\"title\":\"eMailReminder Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-17 20:38:56.000000', '2026-08-17 20:38:56.000000'),
(39, 'release_item', 11, 'item_created', '{\"title\":\"Upload Files Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-17 21:53:14.000000', '2026-08-17 21:53:14.000000'),
(40, 'release_item', 12, 'item_created', '{\"title\":\"EDI - BillPay Files Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-17 22:03:34.000000', '2026-08-17 22:03:34.000000'),
(41, 'release_item', 13, 'item_created', '{\"title\":\"EFT Files Processing\"}', NULL, NULL, 'Jhon', '2026-08-17 23:06:01.000000', '2026-08-17 23:06:01.000000'),
(42, 'release_item', 14, 'item_created', '{\"title\":\"EDI DBID AutoFix Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-17 23:13:07.000000', '2026-08-17 23:13:07.000000'),
(43, 'release_item', 15, 'item_created', '{\"title\":\"EFT Generation\"}', NULL, NULL, 'Jhon', '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000'),
(44, 'release_item', 16, 'item_created', '{\"title\":\"EFT Generated Files UI\"}', NULL, NULL, 'Jhon', '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000'),
(45, 'release_item', 17, 'item_created', '{\"title\":\"EFT Reconciliation Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-18 00:42:58.000000', '2026-08-18 00:42:58.000000'),
(46, 'release_item', 18, 'item_created', '{\"title\":\"EFT Reconciliation Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-18 00:43:18.000000', '2026-08-18 00:43:18.000000'),
(47, 'release_item', 20, 'item_created', '{\"title\":\"EFT Reconciliation Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-18 00:45:42.000000', '2026-08-18 00:45:42.000000'),
(48, 'release_item', 21, 'item_created', '{\"title\":\"EFT Reconciliation Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-18 00:45:54.000000', '2026-08-18 00:45:54.000000'),
(49, 'release_item', 22, 'item_created', '{\"title\":\"EFT Reconciliation Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-18 00:47:22.000000', '2026-08-18 00:47:22.000000'),
(50, 'release_item', 23, 'item_created', '{\"title\":\"EFT Reconciliation Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-18 00:47:37.000000', '2026-08-18 00:47:37.000000'),
(51, 'release_item', 24, 'item_created', '{\"title\":\"SQL - Twine Sync\"}', NULL, NULL, 'Jhon', '2026-08-18 01:42:39.000000', '2026-08-18 01:42:39.000000'),
(52, 'release_item', 21, 'item_created', '{\"title\":\"Fintrac Blacklist Release Unit\"}', NULL, NULL, 'Jhon', '2026-08-18 01:55:18.000000', '2026-08-18 01:55:18.000000'),
(53, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":24,\"new_status_id\":29,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 01:56:37.000000', '2026-08-18 01:56:37.000000'),
(54, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":null,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 01:57:24.000000', '2026-08-18 01:57:24.000000'),
(55, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":52,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 01:57:44.000000', '2026-08-18 01:57:44.000000'),
(56, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":52,\"new_status_id\":24,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 01:57:56.000000', '2026-08-18 01:57:56.000000'),
(57, 'release_item', 12, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":null,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 01:58:27.000000', '2026-08-18 01:58:27.000000'),
(58, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":\"dfrqwer\"}', NULL, 'Jhon', '2026-08-18 01:59:30.000000', '2026-08-18 01:59:30.000000'),
(59, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":24,\"new_status_id\":29,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 01:59:54.000000', '2026-08-18 01:59:54.000000'),
(60, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":52,\"new_status_id\":29,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:00:09.000000', '2026-08-18 02:00:09.000000'),
(61, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":29,\"new_status_id\":24,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:00:32.000000', '2026-08-18 02:00:32.000000'),
(62, 'release_item', 12, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":52,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:01:24.000000', '2026-08-18 02:01:24.000000'),
(63, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":24,\"new_status_id\":24,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:02:09.000000', '2026-08-18 02:02:09.000000'),
(64, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":29,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:02:29.000000', '2026-08-18 02:02:29.000000'),
(65, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":52,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:02:32.000000', '2026-08-18 02:02:32.000000'),
(66, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":null,\"new_status_id\":29,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:17:41.000000', '2026-08-18 02:17:41.000000'),
(67, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":null,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:18:29.000000', '2026-08-18 02:18:29.000000'),
(68, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":29,\"new_status_id\":24,\"source_summary\":\"Item initial creation jajaja\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:19:33.000000', '2026-08-18 02:19:33.000000'),
(69, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation no es verdad\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:21:22.000000', '2026-08-18 02:21:22.000000'),
(70, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":52,\"new_status_id\":52,\"source_summary\":\"Item initial creation que paso\"}', '{\"notes\":\"que paso\"}', NULL, 'Jhon', '2026-08-18 02:23:04.000000', '2026-08-18 02:23:04.000000'),
(71, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation prueba\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:29:44.000000', '2026-08-18 02:29:44.000000'),
(72, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":52,\"new_status_id\":29,\"source_summary\":\"Item initial creation prueba\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:31:16.000000', '2026-08-18 02:31:16.000000'),
(73, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:31:41.000000', '2026-08-18 02:31:41.000000'),
(74, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:32:01.000000', '2026-08-18 02:32:01.000000'),
(75, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":52,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:32:10.000000', '2026-08-18 02:32:10.000000'),
(76, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"8\",\"old_status_id\":24,\"new_status_id\":28,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:32:49.000000', '2026-08-18 02:32:49.000000'),
(77, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"8\",\"old_status_id\":28,\"new_status_id\":28,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:33:01.000000', '2026-08-18 02:33:01.000000'),
(78, 'release_item', 12, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 02:33:30.000000', '2026-08-18 02:33:30.000000'),
(79, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"7\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:38:45.000000', '2026-08-18 03:38:45.000000'),
(80, 'release_item', 11, 'environment_state_changed', '{\"project_environment_id\":\"7\",\"old_status_id\":52,\"new_status_id\":24,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:38:58.000000', '2026-08-18 03:38:58.000000'),
(81, 'release_item', 12, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:39:24.000000', '2026-08-18 03:39:24.000000'),
(82, 'release_item', 12, 'environment_state_changed', '{\"project_environment_id\":\"8\",\"old_status_id\":24,\"new_status_id\":28,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:39:42.000000', '2026-08-18 03:39:42.000000'),
(83, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:40:09.000000', '2026-08-18 03:40:09.000000'),
(84, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:40:23.000000', '2026-08-18 03:40:23.000000'),
(85, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"8\",\"old_status_id\":24,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:40:33.000000', '2026-08-18 03:40:33.000000'),
(86, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"8\",\"old_status_id\":25,\"new_status_id\":28,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:40:41.000000', '2026-08-18 03:40:41.000000'),
(87, 'release_item', 14, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":29,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:41:03.000000', '2026-08-18 03:41:03.000000'),
(88, 'release_item', 15, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:41:30.000000', '2026-08-18 03:41:30.000000'),
(89, 'release_item', 16, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:41:46.000000', '2026-08-18 03:41:46.000000'),
(90, 'release_item', 17, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:42:05.000000', '2026-08-18 03:42:05.000000'),
(91, 'release_item', 17, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:42:27.000000', '2026-08-18 03:42:27.000000'),
(92, 'release_item', 17, 'environment_state_changed', '{\"project_environment_id\":\"8\",\"old_status_id\":24,\"new_status_id\":28,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:42:46.000000', '2026-08-18 03:42:46.000000'),
(93, 'release_item', 18, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:43:13.000000', '2026-08-18 03:43:13.000000'),
(94, 'release_item', 18, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:43:30.000000', '2026-08-18 03:43:30.000000'),
(95, 'release_item', 18, 'environment_state_changed', '{\"project_environment_id\":\"8\",\"old_status_id\":24,\"new_status_id\":28,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:43:47.000000', '2026-08-18 03:43:47.000000'),
(96, 'release_item', 19, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:44:01.000000', '2026-08-18 03:44:01.000000'),
(97, 'release_item', 20, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:44:18.000000', '2026-08-18 03:44:18.000000'),
(98, 'release_item', 21, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:44:33.000000', '2026-08-18 03:44:33.000000'),
(99, 'release_item', 21, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 03:44:52.000000', '2026-08-18 03:44:52.000000'),
(100, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":29,\"new_status_id\":25,\"source_summary\":\"Item initial creation prueba\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 13:57:15.000000', '2026-08-18 13:57:15.000000'),
(101, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":25,\"new_status_id\":29,\"source_summary\":\"Item initial creation prueba\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 13:57:28.000000', '2026-08-18 13:57:28.000000'),
(102, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":52,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:01:54.000000', '2026-08-18 14:01:54.000000'),
(103, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":25,\"new_status_id\":30,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:02:04.000000', '2026-08-18 14:02:04.000000'),
(104, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":52,\"new_status_id\":24,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:02:17.000000', '2026-08-18 14:02:17.000000'),
(105, 'release_item', 14, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":29,\"new_status_id\":30,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:02:50.000000', '2026-08-18 14:02:50.000000'),
(106, 'follow_up', 13, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Deploy on TATU new develpment related to Autofix DBIDs\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-18 14:03:57.000000', '2026-08-18 14:03:57.000000'),
(107, 'release_item', 19, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":25,\"new_status_id\":30,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:06:05.000000', '2026-08-18 14:06:05.000000'),
(108, 'client_activation', 12, 'client_activation_changed', '{\"old_status_id\":33,\"new_status_id\":37,\"scope_type\":\"not_applicable\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:08:07.000000', '2026-08-18 14:08:07.000000'),
(109, 'client_activation', 18, 'client_activation_changed', '{\"old_status_id\":33,\"new_status_id\":37,\"scope_type\":\"not_applicable\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:08:52.000000', '2026-08-18 14:08:52.000000'),
(110, 'client_activation', 13, 'client_activation_changed', '{\"old_status_id\":33,\"new_status_id\":37,\"scope_type\":\"not_applicable\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:09:08.000000', '2026-08-18 14:09:08.000000'),
(111, 'client_activation', 17, 'client_activation_changed', '{\"old_status_id\":33,\"new_status_id\":37,\"scope_type\":\"not_applicable\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:09:22.000000', '2026-08-18 14:09:22.000000'),
(112, 'client_activation', 11, 'client_activation_changed', '{\"old_status_id\":33,\"new_status_id\":37,\"scope_type\":\"not_applicable\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:10:14.000000', '2026-08-18 14:10:14.000000'),
(113, 'client_activation', 2, 'client_activation_changed', '{\"old_status_id\":34,\"new_status_id\":34,\"scope_type\":\"unknown\",\"source_summary\":\"2026-08-17 release status review with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 14:49:23.000000', '2026-08-18 14:49:23.000000'),
(114, 'client_activation', 18, 'client_activation_changed', '{\"old_status_id\":37,\"new_status_id\":33,\"scope_type\":\"unknown\",\"source_summary\":\"we are waiting for Sync\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 15:15:27.000000', '2026-08-18 15:15:27.000000'),
(115, 'release_item', 21, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":52,\"new_status_id\":30,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 15:22:09.000000', '2026-08-18 15:22:09.000000'),
(116, 'release_item', 21, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":52,\"new_status_id\":29,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-18 15:22:17.000000', '2026-08-18 15:22:17.000000'),
(117, 'client_activation', 2, 'client_activation_changed', '{\"old_status_id\":34,\"new_status_id\":35,\"scope_type\":\"unknown\",\"source_summary\":\"2026-08-17 release status review with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-24 03:21:36.000000', '2026-08-24 03:21:36.000000'),
(118, 'client_activation', 2, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":35,\"scope_type\":\"unknown\",\"source_summary\":\"2026-08-17 release status review with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-24 03:24:36.000000', '2026-08-24 03:24:36.000000'),
(119, 'client_activation', 3, 'client_activation_changed', '{\"old_status_id\":34,\"new_status_id\":29,\"scope_type\":\"selective\",\"source_summary\":\"2026-08-18 release status review\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-24 03:34:14.000000', '2026-08-24 03:34:14.000000'),
(120, 'client_activation', 3, 'client_activation_changed', '{\"old_status_id\":29,\"new_status_id\":35,\"scope_type\":\"selective\",\"source_summary\":\"2026-08-18 release status review\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-24 03:35:14.000000', '2026-08-24 03:35:14.000000'),
(121, 'client_activation', 2, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":35,\"scope_type\":\"selective\",\"source_summary\":\"2026-08-17 release status review with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-24 03:35:37.000000', '2026-08-24 03:35:37.000000'),
(122, 'follow_up', 2, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Confirm availability date, enabled plans and companies with Ameet\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:36:53.000000', '2026-08-24 03:36:53.000000'),
(123, 'follow_up', 3, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Confirm production version and client availability with Ameet\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:37:52.000000', '2026-08-24 03:37:52.000000'),
(124, 'follow_up', 19, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Wait for Payrun History released to clients\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:39:00.000000', '2026-08-24 03:39:00.000000'),
(125, 'follow_up', 17, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Continue development\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:53:04.000000', '2026-08-24 03:53:04.000000'),
(126, 'follow_up', 7, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Confirm that payslips transference is ready. After that define the TATU promotion plan\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:53:22.000000', '2026-08-24 03:53:22.000000'),
(127, 'follow_up', 12, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Update Client Account via API\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:54:45.000000', '2026-08-24 03:54:45.000000'),
(128, 'follow_up', 11, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Finish testing related to email format and DBID deactivation\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:55:05.000000', '2026-08-24 03:55:05.000000'),
(129, 'follow_up', 19, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Wait for Payrun History released to clients\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:57:53.000000', '2026-08-24 03:57:53.000000'),
(130, 'follow_up', 23, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Coordinate release two weeks after Payrun History release\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 03:58:02.000000', '2026-08-24 03:58:02.000000'),
(131, 'follow_up', 4, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Confirm with Ameet to deploy on SITA\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 04:01:39.000000', '2026-08-24 04:01:39.000000'),
(132, 'follow_up', 26, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"If Reports was tested in TATU it could be releases in PROD. Coordinate with Himani to do it during next release to PROD\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-24 04:06:18.000000', '2026-08-24 04:06:18.000000'),
(133, 'release_item', 1, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":28,\"new_status_id\":30,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-28 23:15:55.000000', '2026-08-28 23:15:55.000000'),
(134, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:17:09.000000', '2026-08-28 23:17:09.000000'),
(135, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:17:22.000000', '2026-08-28 23:17:22.000000'),
(136, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:18:14.000000', '2026-08-28 23:18:14.000000'),
(137, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:18:16.000000', '2026-08-28 23:18:16.000000'),
(138, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:18:26.000000', '2026-08-28 23:18:26.000000'),
(139, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:18:29.000000', '2026-08-28 23:18:29.000000'),
(140, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:18:32.000000', '2026-08-28 23:18:32.000000'),
(141, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:18:35.000000', '2026-08-28 23:18:35.000000'),
(142, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:18:51.000000', '2026-08-28 23:18:51.000000'),
(143, 'release_item', 6, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":29,\"new_status_id\":30,\"source_summary\":\"Coordinating with Ximena and Mario -  2026-08-17\"}', '{\"notes\":\"Backend is ready. AdminAPI in progress\"}', NULL, 'Jhon', '2026-08-28 23:31:38.000000', '2026-08-28 23:31:38.000000'),
(144, 'follow_up', 11, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Finish testing related to email format and DBID deactivation\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:35:18.000000', '2026-08-28 23:35:18.000000'),
(145, 'follow_up', 11, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Finish testing related to email format and DBID deactivation\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-28 23:35:43.000000', '2026-08-28 23:35:43.000000'),
(146, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":30,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-28 23:36:39.000000', '2026-08-28 23:36:39.000000'),
(147, 'release_item', 19, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":30,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-28 23:37:42.000000', '2026-08-28 23:37:42.000000'),
(148, 'release_item', 21, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":29,\"new_status_id\":30,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-28 23:38:05.000000', '2026-08-28 23:38:05.000000'),
(149, 'release_item', 14, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":30,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-08-31 20:34:28.000000', '2026-08-31 20:34:28.000000'),
(150, 'follow_up', 13, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Deploy on TATU new develpment related to Autofix DBIDs\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-31 20:35:09.000000', '2026-08-31 20:35:09.000000'),
(151, 'follow_up', 16, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Deploy on TATU new develpment related to payslips Sync\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-08-31 20:37:23.000000', '2026-08-31 20:37:23.000000'),
(152, 'follow_up', 33, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"ADMNAPI-1021 Should be developed by Mario\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 13:02:58.000000', '2026-09-01 13:02:58.000000'),
(153, 'follow_up', 32, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"RPS-318 Should be developed\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 13:03:05.000000', '2026-09-01 13:03:05.000000'),
(154, 'follow_up', 32, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"RPS-318 Should be developed\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 13:03:35.000000', '2026-09-01 13:03:35.000000'),
(155, 'follow_up', 10, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Mario confirm frontend deployment on TATU\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 13:03:48.000000', '2026-09-01 13:03:48.000000'),
(156, 'follow_up', 20, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Wait for Twine - SQL Sync features\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 14:02:52.000000', '2026-09-01 14:02:52.000000'),
(157, 'follow_up', 21, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Wait for Twine - SQL Sync features\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 14:03:17.000000', '2026-09-01 14:03:17.000000'),
(158, 'client_activation', 18, 'client_activation_changed', '{\"old_status_id\":33,\"new_status_id\":35,\"scope_type\":\"unknown\",\"source_summary\":\"we are waiting for Sync\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-01 15:07:12.000000', '2026-09-01 15:07:12.000000'),
(159, 'client_activation', 17, 'client_activation_changed', '{\"old_status_id\":37,\"new_status_id\":35,\"scope_type\":\"off\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-01 15:07:45.000000', '2026-09-01 15:07:45.000000'),
(160, 'client_activation', 18, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":35,\"scope_type\":\"off\",\"source_summary\":\"we are waiting for Sync\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-01 15:07:59.000000', '2026-09-01 15:07:59.000000'),
(161, 'client_activation', 12, 'client_activation_changed', '{\"old_status_id\":37,\"new_status_id\":37,\"scope_type\":\"global\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-01 15:08:16.000000', '2026-09-01 15:08:16.000000'),
(162, 'client_activation', 13, 'client_activation_changed', '{\"old_status_id\":37,\"new_status_id\":37,\"scope_type\":\"global\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-01 15:08:37.000000', '2026-09-01 15:08:37.000000'),
(163, 'release_item', 22, 'item_created', '{\"title\":\"Twine - SQL  Sync\"}', NULL, NULL, 'Jhon', '2026-09-01 15:35:50.000000', '2026-09-01 15:35:50.000000'),
(164, 'release_item', 22, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":24,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-01 15:49:35.000000', '2026-09-01 15:49:35.000000'),
(165, 'follow_up', 34, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":39,\"action\":\"Continue Development\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 15:50:13.000000', '2026-09-01 15:50:13.000000'),
(166, 'follow_up', 34, 'follow_up_updated', '{\"old_status_id\":39,\"new_status_id\":38,\"action\":\"Continue Development\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 15:50:41.000000', '2026-09-01 15:50:41.000000'),
(167, 'follow_up', 34, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Continue Development\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-01 15:51:08.000000', '2026-09-01 15:51:08.000000'),
(168, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":29,\"new_status_id\":30,\"source_summary\":\"Item initial creation prueba\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-09 23:48:42.000000', '2026-09-09 23:48:42.000000'),
(169, 'follow_up', 28, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Third email development\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-09 23:49:04.000000', '2026-09-09 23:49:04.000000'),
(170, 'follow_up', 12, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Update Client Account via API\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-09 23:51:12.000000', '2026-09-09 23:51:12.000000'),
(171, 'follow_up', 29, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Add new tickets according feedback received during demo 2026-08-31\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-10 00:00:36.000000', '2026-09-10 00:00:36.000000'),
(172, 'follow_up', 30, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Include this feature during next DEMO\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-10 00:01:38.000000', '2026-09-10 00:01:38.000000'),
(173, 'release_item', 21, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":30,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-10 00:02:28.000000', '2026-09-10 00:02:28.000000'),
(174, 'release_item', 21, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":30,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-10 00:02:33.000000', '2026-09-10 00:02:33.000000'),
(175, 'release_item', 21, 'environment_state_changed', '{\"project_environment_id\":\"8\",\"old_status_id\":24,\"new_status_id\":28,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-10 00:02:43.000000', '2026-09-10 00:02:43.000000'),
(176, 'release_item', 23, 'item_created', '{\"title\":\"Geolocation Release Unit\"}', NULL, NULL, 'Jhon', '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000'),
(177, 'follow_up', 38, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Investigate modules using Geolocation\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-10 00:16:06.000000', '2026-09-10 00:16:06.000000'),
(178, 'follow_up', 39, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Update functionality to use populated table\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-10 00:16:38.000000', '2026-09-10 00:16:38.000000'),
(179, 'release_item', 23, 'environment_state_changed', '{\"project_environment_id\":\"9\",\"old_status_id\":24,\"new_status_id\":25,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-10 00:16:58.000000', '2026-09-10 00:16:58.000000'),
(180, 'client_activation', 21, 'client_activation_changed', '{\"old_status_id\":33,\"new_status_id\":37,\"scope_type\":\"global\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-10 00:18:28.000000', '2026-09-10 00:18:28.000000'),
(181, 'client_activation', 2, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":49,\"scope_type\":\"selective\",\"source_summary\":\"2026-08-17 release status review with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-10 00:19:09.000000', '2026-09-10 00:19:09.000000'),
(182, 'follow_up', 5, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Complete TATU validation and record QA approval\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:13:40.000000', '2026-09-11 12:13:40.000000'),
(183, 'follow_up', 7, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Confirm that payslips transference is ready. After that define the TATU promotion plan\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:14:19.000000', '2026-09-11 12:14:19.000000'),
(184, 'follow_up', 8, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Continue development\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:14:42.000000', '2026-09-11 12:14:42.000000'),
(185, 'follow_up', 9, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Continue develpment\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:14:58.000000', '2026-09-11 12:14:58.000000'),
(186, 'follow_up', 18, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Contact Warren and coordinate release to Growth\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:15:51.000000', '2026-09-11 12:15:51.000000'),
(187, 'follow_up', 19, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Wait for Payrun History released to clients\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:16:20.000000', '2026-09-11 12:16:20.000000'),
(188, 'follow_up', 22, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Review results in production\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:16:47.000000', '2026-09-11 12:16:47.000000'),
(189, 'follow_up', 23, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Coordinate release two weeks after Payrun History release\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:17:16.000000', '2026-09-11 12:17:16.000000'),
(190, 'follow_up', 23, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Coordinate release two weeks after Payrun History release\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:17:31.000000', '2026-09-11 12:17:31.000000'),
(191, 'follow_up', 24, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"AdminAPI endpoint can be deployed on production\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:17:53.000000', '2026-09-11 12:17:53.000000'),
(192, 'follow_up', 25, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Reports can be deployed in production after endpoint\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:18:11.000000', '2026-09-11 12:18:11.000000'),
(193, 'follow_up', 26, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"If Reports was tested in TATU it could be releases in PROD. Coordinate with Himani to do it during next release to PROD\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:18:30.000000', '2026-09-11 12:18:30.000000');
INSERT INTO `audit_events` (`id`, `entity_type`, `entity_id`, `event_type`, `changes`, `context`, `actor_person_id`, `actor_name`, `occurred_at`, `created_at`) VALUES
(194, 'follow_up', 27, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"include RPS-298 in next deployment to SITA\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:18:44.000000', '2026-09-11 12:18:44.000000'),
(195, 'follow_up', 32, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"RPS-318 Should be developed\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:19:03.000000', '2026-09-11 12:19:03.000000'),
(196, 'follow_up', 33, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"ADMNAPI-1021 Should be developed by Mario\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:19:26.000000', '2026-09-11 12:19:26.000000'),
(197, 'follow_up', 22, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Review results in production\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:21:52.000000', '2026-09-11 12:21:52.000000'),
(198, 'follow_up', 23, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Coordinate release two weeks after Payrun History release\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:22:23.000000', '2026-09-11 12:22:23.000000'),
(199, 'follow_up', 24, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"AdminAPI endpoint can be deployed on production\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:23:38.000000', '2026-09-11 12:23:38.000000'),
(200, 'follow_up', 24, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"AdminAPI endpoint can be deployed on production\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 12:23:58.000000', '2026-09-11 12:23:58.000000'),
(201, 'follow_up', 36, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Coordinate meeting with Sam to explain the new feature\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:02:24.000000', '2026-09-11 14:02:24.000000'),
(202, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":30,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-11 14:03:03.000000', '2026-09-11 14:03:03.000000'),
(203, 'release_item', 13, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":30,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-11 14:03:10.000000', '2026-09-11 14:03:10.000000'),
(204, 'release_item', 19, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":30,\"new_status_id\":52,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-11 14:04:00.000000', '2026-09-11 14:04:00.000000'),
(205, 'release_item', 19, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":30,\"new_status_id\":29,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-11 14:04:22.000000', '2026-09-11 14:04:22.000000'),
(206, 'follow_up', 31, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Create new tickets according the feedback received from Ameet\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:04:40.000000', '2026-09-11 14:04:40.000000'),
(207, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"5\",\"old_status_id\":30,\"new_status_id\":52,\"source_summary\":\"Item initial creation prueba\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-11 14:05:33.000000', '2026-09-11 14:05:33.000000'),
(208, 'release_item', 10, 'environment_state_changed', '{\"project_environment_id\":\"6\",\"old_status_id\":24,\"new_status_id\":29,\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-11 14:05:55.000000', '2026-09-11 14:05:55.000000'),
(209, 'follow_up', 35, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Deploy solution in TATU\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:06:06.000000', '2026-09-11 14:06:06.000000'),
(210, 'follow_up', 40, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Access Level control ... testing by Ricardo\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:15:18.000000', '2026-09-11 14:15:18.000000'),
(211, 'follow_up', 41, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Sign-off from QA\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:15:48.000000', '2026-09-11 14:15:48.000000'),
(212, 'follow_up', 32, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"RPS-318 Should be developed\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:21:14.000000', '2026-09-11 14:21:14.000000'),
(213, 'follow_up', 32, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"RPS-318 Should be developed\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:21:34.000000', '2026-09-11 14:21:34.000000'),
(214, 'follow_up', 33, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"ADMNAPI-1021 Should be developed by Mario\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:22:29.000000', '2026-09-11 14:22:29.000000'),
(215, 'follow_up', 33, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"ADMNAPI-1021 Should be developed by Mario\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:22:52.000000', '2026-09-11 14:22:52.000000'),
(216, 'follow_up', 46, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Evolv should be updated in SITA\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:42:45.000000', '2026-09-11 14:42:45.000000'),
(217, 'follow_up', 48, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Fix issues raised by Ricardo Fumachi & Andrea\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:47:42.000000', '2026-09-11 14:47:42.000000'),
(218, 'follow_up', 48, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Fix issues raised by Ricardo Fumachi & Andrea\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:48:31.000000', '2026-09-11 14:48:31.000000'),
(219, 'follow_up', 45, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"Pending solve fix - Ricardo Haro\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:52:41.000000', '2026-09-11 14:52:41.000000'),
(220, 'follow_up', 48, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":42,\"action\":\"Fix issues raised by Ricardo Fumachi & Andrea\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-11 14:53:11.000000', '2026-09-11 14:53:11.000000'),
(221, 'client_activation', 12, 'client_activation_changed', '{\"old_status_id\":37,\"new_status_id\":37,\"scope_type\":\"global\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-16 16:17:49.000000', '2026-09-16 16:17:49.000000'),
(222, 'client_activation', 18, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":35,\"scope_type\":\"off\",\"source_summary\":\"we are waiting for Sync\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-16 16:18:35.000000', '2026-09-16 16:18:35.000000'),
(223, 'client_activation', 13, 'client_activation_changed', '{\"old_status_id\":37,\"new_status_id\":37,\"scope_type\":\"global\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-16 16:19:13.000000', '2026-09-16 16:19:13.000000'),
(224, 'client_activation', 17, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":35,\"scope_type\":\"off\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-16 16:19:30.000000', '2026-09-16 16:19:30.000000'),
(225, 'client_activation', 17, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":35,\"scope_type\":\"off\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-16 16:19:50.000000', '2026-09-16 16:19:50.000000'),
(226, 'client_activation', 21, 'client_activation_changed', '{\"old_status_id\":37,\"new_status_id\":37,\"scope_type\":\"global\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-16 16:20:26.000000', '2026-09-16 16:20:26.000000'),
(227, 'client_activation', 17, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":35,\"scope_type\":\"off\",\"source_summary\":\"Item initial creation\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-16 16:20:40.000000', '2026-09-16 16:20:40.000000'),
(228, 'client_activation', 18, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":35,\"scope_type\":\"off\",\"source_summary\":\"we are waiting for Sync\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-16 16:20:49.000000', '2026-09-16 16:20:49.000000'),
(229, 'follow_up', 1, 'follow_up_updated', '{\"old_status_id\":41,\"new_status_id\":41,\"action\":\"Start testing - Ticket RPS-298\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-23 19:40:10.000000', '2026-09-23 19:40:10.000000'),
(230, 'release_item', 2, 'environment_state_changed', '{\"project_environment_id\":\"3\",\"old_status_id\":52,\"new_status_id\":24,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-23 20:12:57.000000', '2026-09-23 20:12:57.000000'),
(231, 'release_item', 2, 'environment_state_changed', '{\"project_environment_id\":\"3\",\"old_status_id\":24,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-23 20:13:05.000000', '2026-09-23 20:13:05.000000'),
(232, 'follow_up', 44, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"Pending solve fix - Ricardo Haro\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-23 20:13:35.000000', '2026-09-23 20:13:35.000000'),
(233, 'release_item', 1, 'environment_state_changed', '{\"project_environment_id\":\"1\",\"old_status_id\":52,\"new_status_id\":52,\"source_summary\":\"Reconstructed baseline from 2026-08-07 meeting with Ximena\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-23 20:40:03.000000', '2026-09-23 20:40:03.000000'),
(234, 'release_item', 1, 'environment_state_changed', '{\"project_environment_id\":\"2\",\"old_status_id\":30,\"new_status_id\":52,\"source_summary\":\"It was confirmed by Ricahr Fumachi\"}', '{\"notes\":\"wasfasdfa\"}', NULL, 'Jhon', '2026-09-23 20:40:47.000000', '2026-09-23 20:40:47.000000'),
(235, 'release_item', 1, 'environment_state_changed', '{\"project_environment_id\":\"3\",\"old_status_id\":24,\"new_status_id\":29,\"source_summary\":\"asfdsadf\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-23 20:41:15.000000', '2026-09-23 20:41:15.000000'),
(236, 'follow_up', 27, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":41,\"action\":\"include RPS-298 in next deployment to SITA\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-23 20:42:15.000000', '2026-09-23 20:42:15.000000'),
(237, 'follow_up', 50, 'follow_up_updated', '{\"old_status_id\":38,\"new_status_id\":38,\"action\":\"New activity\"}', '{\"outcome\":null}', NULL, 'Jhon', '2026-09-23 20:42:37.000000', '2026-09-23 20:42:37.000000'),
(238, 'client_activation', 3, 'client_activation_changed', '{\"old_status_id\":35,\"new_status_id\":51,\"scope_type\":\"selective\",\"source_summary\":\"2026-08-18 release status review\"}', '{\"notes\":null}', NULL, 'Jhon', '2026-09-23 20:44:44.000000', '2026-09-23 20:44:44.000000');

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
(25, 'environment_state', 'development', 'Development', 'Active development in the environment.', 20, '#187efb', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-17 20:10:55.000000'),
(26, 'environment_state', 'ready_to_promote', 'Ready to promote', 'Validated in the source environment and ready for promotion.', 25, '#A78BFA', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(27, 'environment_state', 'code_merging', 'Code merging', 'Merge or deployment preparation is in progress.', 30, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(28, 'environment_state', 'deployed', 'Deployed', 'Presence confirmed; test result is not yet recorded.', 40, '#73a6f7', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-17 20:11:59.000000'),
(29, 'environment_state', 'in_testing', 'Testing', 'Presence confirmed and QA validation is in progress.', 50, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(30, 'environment_state', 'QASignoff', 'QA - Signoff', 'QA Signed- off - Presence and successful validation are confirmed.', 60, '#10B981', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-17 19:52:20.000000'),
(31, 'environment_state', 'blocked', 'Blocked', 'The release unit cannot progress until a blocker is resolved.', 70, '#EF4444', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(32, 'environment_state', 'unconfirmed', 'Unconfirmed', 'Environment presence or status needs confirmation.', 80, '#F97316', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(33, 'activation_status', 'not_applicable', 'N/A', 'Activation is not applicable before production.', 60, '#9CA3AF', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(34, 'activation_status', 'unconfirmed', 'Unconfirmed', 'Production presence or client access needs confirmation.', 20, '#F97316', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(35, 'activation_status', 'inactive', 'Deployed to PROD — Not released to clients', 'Confirmed in production but not enabled for clients.', 50, '#F59E0B', 1, 1, '2026-08-15 12:00:00.000000', '2026-08-24 03:22:35.000000'),
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
(51, 'activation_status', 'bPlus', 'Business Plus V2', 'Enabled for Bussiness Plus Plan', 30, '#36ecbc', 1, 1, '0000-00-00 00:00:00.000000', '2026-08-16 15:19:46.000000'),
(52, 'environment_state', 'POSignoff', 'PO - Sign off', 'PO - Sign off', 0, '#6ee61e', 0, 1, '2026-08-17 19:53:03.000000', '2026-08-17 20:17:39.000000');

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
(2, 2, 49, 'selective', 'Usage in production needs confirmation with Ameet', NULL, '2026-09-10 00:19:09.000000', 3, NULL, '2026-08-17 release status review with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-09-10 00:19:09.000000'),
(3, 3, 51, 'selective', 'Usage in production needs confirmation with Ameet', NULL, '2026-09-23 20:44:44.000000', 3, NULL, '2026-08-18 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-09-23 20:44:44.000000'),
(4, 4, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(5, 5, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(6, 6, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(7, 7, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(8, 8, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(9, 9, 33, 'not_applicable', NULL, NULL, '2026-08-07 10:00:00.000000', 2, NULL, '2026-08-07 release status review', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(10, 10, 33, 'not_applicable', NULL, NULL, '2026-08-17 20:38:56.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-17 20:38:56.000000', '2026-08-17 20:38:56.000000'),
(11, 11, 37, 'not_applicable', NULL, NULL, '2026-08-18 14:10:14.000000', NULL, NULL, 'Item initial creation', NULL, '2026-08-17 21:53:14.000000', '2026-08-18 14:10:14.000000'),
(12, 12, 37, 'global', 'Module to upload EDI Files', NULL, '2026-09-16 16:17:49.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 22:03:34.000000', '2026-09-16 16:17:49.000000'),
(13, 13, 37, 'global', 'Workflow to process EFT Files', NULL, '2026-09-16 16:19:13.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 23:06:01.000000', '2026-09-16 16:19:13.000000'),
(14, 14, 33, 'not_applicable', NULL, NULL, '2026-08-17 23:13:07.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-17 23:13:07.000000', '2026-08-17 23:13:07.000000'),
(15, 15, 33, 'not_applicable', NULL, NULL, '2026-08-18 00:06:13.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000'),
(16, 16, 33, 'not_applicable', NULL, NULL, '2026-08-18 00:08:34.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000'),
(17, 17, 35, 'off', 'Module to allow EDI files Reconciliation', NULL, '2026-09-16 16:20:40.000000', 3, NULL, 'Item initial creation', NULL, '2026-08-18 00:42:59.000000', '2026-09-16 16:20:40.000000'),
(18, 18, 35, 'off', 'Module to allow EDI files Reconciliation', NULL, '2026-09-16 16:20:49.000000', 3, NULL, 'we are waiting for Sync', NULL, '2026-08-18 00:43:19.000000', '2026-09-16 16:20:49.000000'),
(19, 19, 33, 'not_applicable', NULL, NULL, '2026-08-18 00:45:42.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:45:43.000000', '2026-08-18 00:45:43.000000'),
(20, 20, 33, 'not_applicable', NULL, NULL, '2026-08-18 00:45:42.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:45:43.000000', '2026-08-18 00:45:43.000000'),
(21, 21, 37, 'global', 'Module to control Fintrac Backlist', NULL, '2026-09-16 16:20:26.000000', 11, NULL, 'Item initial creation', NULL, '2026-08-18 01:55:18.000000', '2026-09-16 16:20:26.000000'),
(22, 22, 33, 'not_applicable', NULL, NULL, '2026-09-01 15:35:50.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-09-01 15:35:51.000000', '2026-09-01 15:35:51.000000'),
(23, 23, 33, 'not_applicable', NULL, NULL, '2026-09-10 00:10:47.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000');

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
(1, 1, 'Start testing - Ticket RPS-298', 41, 21, 1, 2, '2026-09-25', 0, 'Start testing', NULL, '2026-08-28 23:17:09.000000', '2026-08-15 12:00:00.000000', '2026-09-23 19:40:10.000000', NULL),
(2, 2, 'Confirm availability date, enabled plans and companies with Ameet', 41, 21, 1, 3, '2026-08-21', 0, 'Action required for baseline advancement', NULL, '2026-08-24 03:36:53.000000', '2026-08-15 12:00:00.000000', '2026-08-24 03:36:53.000000', NULL),
(3, 3, 'Confirm production version and client availability with Ameet', 41, 21, 1, 3, '2026-08-21', 0, 'Action required for baseline advancement', NULL, '2026-08-24 03:37:52.000000', '2026-08-15 12:00:00.000000', '2026-08-24 03:37:52.000000', NULL),
(4, 4, 'Confirm with Ameet to deploy on SITA', 41, 21, 1, 7, '2026-08-21', 0, 'Confirm with Ameet to deploy on SITA', NULL, '2026-08-24 04:01:39.000000', '2026-08-15 12:00:00.000000', '2026-08-24 04:01:39.000000', NULL),
(5, 5, 'Complete TATU validation and record QA approval', 38, 21, 1, 5, '2026-09-15', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-09-11 12:13:39.000000', NULL),
(6, 6, 'Finish backend merge and confirm deployment to TATU', 41, 21, 1, 2, '2026-08-21', 0, 'We are waiting for frontend decployment', NULL, '2026-08-17 19:37:37.000000', '2026-08-15 12:00:00.000000', '2026-08-17 19:37:37.000000', NULL),
(7, 7, 'Confirm that payslips transference is ready. After that define the TATU promotion plan', 38, 22, 1, 2, '2026-09-30', 0, 'We are waiting for Payslips transference', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-09-11 12:14:19.000000', NULL),
(8, 8, 'Continue development', 38, 22, 1, 2, '2026-10-01', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-09-11 12:14:42.000000', NULL),
(9, 9, 'Continue develpment', 38, 22, 1, 2, '2026-10-01', 0, 'Action required for baseline advancement', NULL, NULL, '2026-08-15 12:00:00.000000', '2026-09-11 12:14:58.000000', NULL),
(10, 6, 'Mario confirm frontend deployment on TATU', 41, 21, 6, NULL, '2026-08-18', 0, 'Deployment on TATU', NULL, '2026-09-01 13:03:48.000000', '2026-08-17 19:40:13.000000', '2026-09-01 13:03:48.000000', NULL),
(11, 10, 'Finish testing related to email format and DBID deactivation', 41, 20, 8, NULL, '2026-08-18', 0, NULL, NULL, '2026-08-28 23:35:18.000000', '2026-08-18 13:58:19.000000', '2026-08-28 23:35:18.000000', NULL),
(12, 13, 'Update Client Account via API', 41, 20, 8, NULL, '2026-08-18', 0, NULL, NULL, '2026-09-09 23:51:12.000000', '2026-08-18 14:01:40.000000', '2026-09-09 23:51:12.000000', NULL),
(13, 14, 'Deploy on TATU new develpment related to Autofix DBIDs', 41, 21, 8, NULL, '2026-08-18', 0, NULL, NULL, '2026-08-31 20:35:09.000000', '2026-08-18 14:03:44.000000', '2026-08-31 20:35:09.000000', NULL),
(14, 15, 'Continue development', 38, 21, 8, NULL, '2026-08-18', 0, NULL, NULL, NULL, '2026-08-18 14:04:29.000000', '2026-08-18 14:04:29.000000', NULL),
(15, 16, 'Continue development', 38, 21, 8, NULL, '2026-08-18', 0, NULL, NULL, NULL, '2026-08-18 14:04:57.000000', '2026-08-18 14:04:57.000000', NULL),
(16, 19, 'Deploy on TATU new develpment related to payslips Sync', 41, 21, 8, NULL, '2026-08-18', 0, NULL, NULL, '2026-08-31 20:37:23.000000', '2026-08-18 14:06:38.000000', '2026-08-31 20:37:23.000000', NULL),
(17, 20, 'Continue development', 38, 23, 8, NULL, '2026-08-18', 0, NULL, NULL, NULL, '2026-08-18 14:07:07.000000', '2026-08-24 03:53:04.000000', NULL),
(18, 2, 'Contact Warren and coordinate release to Growth', 41, 21, 1, NULL, '2026-08-18', 0, NULL, NULL, '2026-09-11 12:15:51.000000', '2026-08-18 15:06:20.000000', '2026-09-11 12:15:51.000000', NULL),
(19, 3, 'Wait for Payrun History released to clients', 38, 23, 1, NULL, '2026-10-15', 0, 'ePay Report should be deployed two weeks after Payrun History', NULL, NULL, '2026-08-18 15:07:04.000000', '2026-09-11 12:16:20.000000', NULL),
(20, 17, 'Wait for Twine - SQL Sync features', 38, 21, 8, NULL, '2026-09-18', 0, NULL, NULL, NULL, '2026-08-18 15:21:18.000000', '2026-09-01 14:02:52.000000', NULL),
(21, 18, 'Wait for Twine - SQL Sync features', 38, 21, 8, NULL, '2026-09-18', 0, NULL, NULL, NULL, '2026-08-18 15:21:25.000000', '2026-09-01 14:03:17.000000', NULL),
(22, 2, 'Review results in production', 38, 22, 2, NULL, '2026-09-18', 0, NULL, NULL, NULL, '2026-08-24 03:56:58.000000', '2026-09-11 12:21:52.000000', NULL),
(23, 3, 'Coordinate release two weeks after Payrun History release', 38, 23, 1, NULL, '2026-10-01', 0, NULL, NULL, NULL, '2026-08-24 03:57:42.000000', '2026-09-11 12:22:23.000000', NULL),
(24, 4, 'AdminAPI endpoint can be deployed on production', 38, 20, 8, NULL, '2026-09-18', 0, NULL, NULL, NULL, '2026-08-24 04:00:43.000000', '2026-09-11 12:23:58.000000', NULL),
(25, 4, 'Reports can be deployed in production after endpoint', 38, 23, 6, NULL, '2026-10-01', 0, NULL, NULL, NULL, '2026-08-24 04:02:25.000000', '2026-09-11 12:18:11.000000', NULL),
(26, 4, 'If Reports was tested in TATU it could be releases in PROD. Coordinate with Himani to do it during next release to PROD', 38, 21, 6, NULL, '2026-09-15', 0, NULL, NULL, NULL, '2026-08-24 04:05:54.000000', '2026-09-11 12:18:30.000000', NULL),
(27, 1, 'include RPS-298 in next deployment to SITA', 41, 21, 4, NULL, '2026-09-15', 0, NULL, NULL, '2026-09-23 20:42:15.000000', '2026-08-28 23:19:58.000000', '2026-09-23 20:42:15.000000', NULL),
(28, 10, 'Third email development', 41, 21, 8, NULL, '2026-08-28', 0, NULL, NULL, '2026-09-09 23:49:04.000000', '2026-08-28 23:32:51.000000', '2026-09-09 23:49:04.000000', NULL),
(29, 13, 'Add new tickets according feedback received during demo 2026-08-31', 41, 21, 1, NULL, '2026-08-31', 0, NULL, NULL, '2026-09-10 00:00:36.000000', '2026-08-31 20:33:41.000000', '2026-09-10 00:00:36.000000', NULL),
(30, 14, 'Include this feature during next DEMO', 41, 21, 1, NULL, '2026-08-31', 0, NULL, NULL, '2026-09-10 00:01:38.000000', '2026-08-31 20:35:51.000000', '2026-09-10 00:01:38.000000', NULL),
(31, 19, 'Create new tickets according the feedback received from Ameet', 41, 21, 8, NULL, '2026-08-31', 0, NULL, NULL, '2026-09-11 14:04:40.000000', '2026-08-31 20:37:58.000000', '2026-09-11 14:04:40.000000', NULL),
(32, 6, 'RPS-318 Should be developed', 41, 21, 6, NULL, '2026-09-17', 0, NULL, NULL, '2026-09-11 14:21:34.000000', '2026-09-01 13:01:27.000000', '2026-09-11 14:21:34.000000', NULL),
(33, 6, 'ADMNAPI-1021 Should be developed by Mario', 41, 21, 8, NULL, '2026-09-22', 0, NULL, NULL, '2026-09-11 14:22:52.000000', '2026-09-01 13:02:41.000000', '2026-09-11 14:22:52.000000', NULL),
(34, 22, 'Continue Development', 38, 23, 8, NULL, '2026-09-01', 0, NULL, NULL, NULL, '2026-09-01 15:50:03.000000', '2026-09-01 15:51:08.000000', NULL),
(35, 10, 'Deploy solution in TATU', 41, 21, 8, NULL, '2026-09-15', 0, NULL, NULL, '2026-09-11 14:06:06.000000', '2026-09-09 23:49:37.000000', '2026-09-11 14:06:06.000000', NULL),
(36, 14, 'Coordinate meeting with Sam to explain the new feature', 41, 21, 8, NULL, '2026-09-11', 0, NULL, NULL, '2026-09-11 14:02:24.000000', '2026-09-10 00:01:31.000000', '2026-09-11 14:02:24.000000', NULL),
(37, 21, 'Waiting for feedback from Warren', 38, 21, 11, NULL, '2026-09-10', 0, NULL, NULL, NULL, '2026-09-10 00:03:05.000000', '2026-09-10 00:03:05.000000', NULL),
(38, 23, 'Investigate modules using Geolocation', 38, 22, 14, 14, '2026-09-17', 0, NULL, NULL, NULL, '2026-09-10 00:12:54.000000', '2026-09-10 00:16:06.000000', NULL),
(39, 23, 'Update functionality to use populated table', 38, 22, 14, 14, '2026-09-30', 0, NULL, NULL, NULL, '2026-09-10 00:14:34.000000', '2026-09-10 00:16:38.000000', NULL),
(40, 12, 'Access Level control ... testing by Ricardo', 38, 21, 14, NULL, '2026-09-16', 0, NULL, NULL, NULL, '2026-09-11 14:01:57.000000', '2026-09-11 14:15:18.000000', NULL),
(41, 19, 'Sign-off from QA', 38, 21, 8, NULL, '2026-09-15', 0, NULL, NULL, NULL, '2026-09-11 14:05:11.000000', '2026-09-11 14:15:48.000000', NULL),
(42, 10, 'Finalize Testing', 38, 21, 8, NULL, '2026-09-15', 0, NULL, NULL, NULL, '2026-09-11 14:06:26.000000', '2026-09-11 14:06:26.000000', NULL),
(43, 6, 'Wait for ADMNAPI-1021 deployment in production', 38, 21, 6, NULL, '2026-09-11', 0, NULL, NULL, NULL, '2026-09-11 14:23:48.000000', '2026-09-11 14:23:48.000000', NULL),
(44, 2, 'Pending solve fix - Ricardo Haro', 38, 21, 4, NULL, '2026-09-25', 0, NULL, NULL, NULL, '2026-09-11 14:40:49.000000', '2026-09-23 20:13:35.000000', NULL),
(45, 2, 'Pending solve fix - Ricardo Haro', 41, 21, 4, NULL, '2026-09-11', 0, NULL, NULL, '2026-09-11 14:52:41.000000', '2026-09-11 14:41:10.000000', '2026-09-11 14:52:41.000000', NULL),
(46, 4, 'Evolv should be updated in SITA', 38, 21, 6, NULL, '2026-09-17', 0, NULL, NULL, NULL, '2026-09-11 14:42:13.000000', '2026-09-11 14:42:45.000000', NULL),
(47, 5, 'Fix issues assigned to Felipe - RPS 347', 38, 21, 12, NULL, '2026-09-11', 0, NULL, NULL, NULL, '2026-09-11 14:44:29.000000', '2026-09-11 14:44:29.000000', NULL),
(48, 6, 'Fix issues raised by Ricardo Fumachi & Andrea', 42, 21, 6, NULL, '2026-09-16', 0, NULL, NULL, NULL, '2026-09-11 14:47:01.000000', '2026-09-11 14:53:11.000000', NULL),
(49, 7, 'Fix issues raised by Ricardo Fumachi & Andrea', 38, 21, 2, NULL, '2026-09-16', 0, NULL, NULL, NULL, '2026-09-11 14:48:45.000000', '2026-09-11 14:48:45.000000', NULL),
(50, 1, 'New activity', 38, 21, 14, NULL, '2026-09-23', 0, 'assaf', NULL, NULL, '2026-09-23 20:42:01.000000', '2026-09-23 20:42:37.000000', NULL);

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
(15, '2026_08_15_000014_create_app_settings_table', 1),
(16, '2026_08_17_000001_drop_next_action_from_release_items_table', 2),
(17, '2026_08_17_000002_drop_project_id_from_release_items_table', 3),
(18, '2026_08_17_000003_cleanup_and_unique_release_item_environment_states', 4);

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
  `updated_at` datetime(6) NOT NULL DEFAULT current_timestamp(6),
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
(8, 2, 'EFT Rejects', 'EFT_Rejects', 'EFT Rejects. It includes debit and credit EFT Rejects', 4, NULL, '2026-08-16 16:44:58.000000', '2026-09-16 15:51:04.000000', NULL),
(9, 2, 'EDI Processing', 'EDI_Processing', 'EDI_Processing. Worflow to control EDI payments.', 4, NULL, '2026-08-16 16:45:26.000000', '2026-09-16 15:51:36.000000', NULL),
(10, 2, 'EFT Processing', 'EFT_Processing', 'EDI_Processing. Worflow to control EFT payments.', 4, NULL, '2026-08-16 16:56:27.000000', '2026-09-16 15:51:54.000000', NULL),
(11, 2, 'EFT Sync & Generation', 'EFT_Sync_Generation', 'EFT Sync & Generation workflow', 4, NULL, '2026-08-16 16:57:21.000000', '2026-09-16 15:52:12.000000', NULL),
(12, 2, 'eMailReminders', 'eMailReminders', 'eMailReminders. Three emails should be sent when an EDI payment is received. 1. One day before payment. 2. One day after payment. 3. two days after payment, account is blocked', 4, NULL, '2026-08-16 16:58:02.000000', '2026-09-16 15:54:17.000000', NULL),
(13, 2, 'Upload Files', 'UploadFiles', 'Module that allows to upload EDI and EFT Files', 4, NULL, '2026-08-17 21:41:42.000000', '2026-09-01 14:07:22.000000', '2026-09-01 14:07:22.000000'),
(14, 2, 'EFT & EDI Recondiliation', 'EFT_EDI_Recondiliation', 'Module for EDI and EFT Files reconciliation', 4, NULL, '2026-08-17 21:41:42.000000', '2026-08-17 21:41:42.000000', NULL),
(15, 2, 'Payslips Sync', 'PayslipsSync', 'PayslipsSync. Workflow to control Payslips Syncrhonization', 4, NULL, '0000-00-00 00:00:00.000000', '2026-09-16 15:54:54.000000', NULL),
(16, 2, 'Fintrac Blacklist', 'FintracBlacklist', 'Fintrac Blacklist control', 4, NULL, '0000-00-00 00:00:00.000000', '2026-09-16 15:55:08.000000', NULL),
(17, 3, 'Geolocation', 'Geolocation', 'Geolocation API functionality', 4, NULL, '2026-09-10 00:06:56.000000', '2026-09-16 15:59:59.000000', NULL),
(18, 3, 'BankValidation', 'BankValidation', 'BankValidation - Account numbers control', 4, NULL, '2026-09-10 00:07:18.000000', '2026-09-16 16:00:27.000000', NULL);

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
(11, 'Valli', 'valli@paymentevolution.com', 'Backend Developer', 'Engineering', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(12, 'Felipe', 'felipe@paymentevolution.com', 'Fullstack Developer', 'Engineering', 1, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(13, 'Warren', 'warren@paymentevolution.com', 'Customer Success Manager', 'Customer Success', 1, '2026-08-28 22:52:41.000000', '2026-08-28 22:52:41.000000', NULL),
(14, 'Jesus', 'Jesus.Garcia@paymentevolution.com', 'Full Stack', 'Full Stack', 1, '2026-09-10 00:05:47.000000', '2026-09-10 00:06:28.000000', NULL);

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
(2, 'AdminAPI', 'AdminAPI', 'All features related to EFT and EDI files', 1, 1, '2026-08-16 16:43:35.000000', '2026-08-17 21:42:01.000000', NULL),
(3, 'PE Utilities', 'PEUTILITIES', NULL, 1, 14, '2026-09-10 00:04:27.000000', '2026-09-10 00:06:13.000000', NULL);

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
(8, 2, 4, 40, 1, 1, '2026-08-16 16:43:35.000000', '2026-08-16 16:43:35.000000'),
(9, 3, 1, 10, 1, 1, '2026-09-10 00:04:27.000000', '2026-09-10 00:04:27.000000'),
(10, 3, 2, 20, 1, 1, '2026-09-10 00:04:27.000000', '2026-09-10 00:04:27.000000'),
(11, 3, 3, 30, 1, 1, '2026-09-10 00:04:27.000000', '2026-09-10 00:04:27.000000'),
(12, 3, 4, 40, 1, 1, '2026-09-10 00:04:27.000000', '2026-09-10 00:04:27.000000');

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
(2, 1, 'Summary Report & ePay Report improvements', 'REL-Summary&ePay', 'Summary Report & ePay Report improvements, it includes interaction with AdminAPI', 8, 1, '2023-08-31', NULL, NULL, NULL, NULL, '2026-08-16 16:20:38.000000', '2026-08-17 22:02:24.000000', NULL),
(3, 2, 'eMailReminders Package', 'REL_EmailReminder', 'Sending email reminders and DBID deactivation after second reminder', 8, 8, '2026-08-25', NULL, NULL, NULL, NULL, '2026-08-17 20:35:54.000000', '2026-08-17 22:18:36.000000', NULL),
(5, 2, 'Upload EDI & EFT Files Package', 'REL_UploadFiles', 'Packate related to Upload EDI & EFT Files Package', 8, 8, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-17 21:45:44.000000', '2026-08-17 22:18:18.000000', NULL),
(6, 2, 'EDI - BillPay Files Package', 'REL_EDIBillPay', 'EDI - BillPay Files Processing', 8, 8, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-17 22:01:50.000000', '2026-08-17 22:01:50.000000', NULL),
(7, 2, 'EDI DBID Autofix Names Package', 'REL_EDI_DBID_Autofix', 'Autofix DBID common names', 8, 8, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-17 22:17:46.000000', '2026-08-17 22:18:03.000000', NULL),
(8, 2, 'EFT Files Processing Package', 'REL_EFTFILESPROCESSING', 'EFT Files Processing', 8, 8, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-17 22:20:32.000000', '2026-08-17 22:20:32.000000', NULL),
(9, 2, 'EFT Generation & EFT Sync Package', 'REL_EFTGENERATIONSYNC', 'EFT Generation & EFT Sync', 8, 8, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-18 00:02:00.000000', '2026-08-18 00:02:00.000000', NULL),
(10, 2, 'EFT Reconciliation Package', 'REL EFT_RECONCILIATION', 'EFT Reconciliation', 8, 8, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-18 00:38:10.000000', '2026-08-18 00:38:10.000000', NULL),
(11, 2, 'EDI Reconciliation Package', 'REL EDI_RECONCILIATION', 'EDI Reconciliation', 8, 8, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-18 00:38:10.000000', '2026-08-18 00:38:10.000000', NULL),
(12, 2, 'Payslips Sync Package', 'REL_PAYSLIPS_SYNC', 'Payslips Sync', 8, 8, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-18 00:38:10.000000', '2026-08-18 00:38:10.000000', NULL),
(13, 2, 'Fintrac Blacklist Package', 'REL_FintracBlacklist', 'Fintrac Blacklist Package', 8, 11, '2026-08-31', NULL, NULL, NULL, NULL, '2026-08-18 01:54:15.000000', '2026-08-18 01:54:15.000000', NULL),
(14, 3, 'Geolocation Package', 'GeolocationPkg', 'Geolocation', 8, 14, '2026-10-31', NULL, NULL, NULL, NULL, '2026-09-10 00:09:29.000000', '2026-09-10 00:09:51.000000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `release_items`
--

DROP TABLE IF EXISTS `release_items`;
CREATE TABLE `release_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
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
  `target_date` date DEFAULT NULL,
  `closed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `release_items`
--

INSERT INTO `release_items` (`id`, `release_id`, `module_id`, `title`, `description`, `item_type_id`, `status_id`, `priority_id`, `owner_person_id`, `jira_key`, `jira_url`, `target_date`, `closed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 'Cross-cutting UI Improvements', 'Some improvements which are related to all reports', 17, 13, 21, 4, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-16 16:14:00.000000', NULL),
(2, 1, 2, 'Payrun History – Base Release', 'Baseline item RPT-PH-BASE', 16, 13, 21, 4, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-16 17:25:41.000000', NULL),
(3, 1, 3, 'ePay Report – Base Release', 'Baseline item RPT-EP-BASE', 16, 13, 21, 6, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(4, 1, 3, 'ePay Report – AdminAPI / Rejections / Dynamics Improvements', 'Baseline item RPT-EP-IMP', 17, 13, 21, 6, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(5, 1, 4, 'Summary Report – Base Release', 'Baseline item RPT-SR-BASE', 16, 13, 21, 6, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(6, 1, 5, 'Cheques & Payslips – Transfer', 'Baseline item RPT-CP-TRANSFER', 17, 13, 21, 6, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000', NULL),
(7, 1, 5, 'Cheques & Payslips – Report', 'Baseline item RPT-CP-REPORT', 16, 13, 22, 2, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 21:56:38.000000', NULL),
(8, 1, 6, 'PayExplorer – Current Development Scope', 'Baseline item RPT-PE-BASE', 16, 13, 22, 10, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 21:54:31.000000', NULL),
(9, 1, 7, 'Reports Homepage – Current Development Scope', 'Baseline item RPT-HOME-BASE', 16, 13, 22, 10, NULL, NULL, '2026-08-31', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 21:54:21.000000', NULL),
(10, 3, 12, 'eMailReminder Release Unit', 'email reminders and DBID deactivation', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-17 20:38:56.000000', '2026-08-17 21:54:08.000000', NULL),
(11, 5, 9, 'Upload Files Release Unit', 'Upload Files Release Unit', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-17 21:53:14.000000', '2026-09-01 14:24:23.000000', '2026-09-01 14:24:23.000000'),
(12, 6, 9, 'EDI - BillPay Files Release Unit', 'EDI - BillPay Files Processing Release Unit', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-17 22:03:34.000000', '2026-08-17 22:03:34.000000', NULL),
(13, 8, 10, 'EFT Files Processing Release Unit', 'EFT Files Processing Release Unit', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-17 23:06:01.000000', '2026-08-17 23:06:01.000000', NULL),
(14, 7, 9, 'EDI DBID AutoFix Release Unit', 'EDI DBID AutoFix Release Unit', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-17 23:13:07.000000', '2026-08-17 23:13:07.000000', NULL),
(15, 9, 11, 'EFT Generation Release Unit', 'EFT Generation Release Unit', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000', NULL),
(16, 9, 11, 'EFT Generated Files UI', 'EFT Generated Files UI', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000', NULL),
(17, 10, 14, 'EFT Reconciliation Release Unit', 'EFT Reconciliation Release Unit', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-18 00:42:58.000000', '2026-08-18 00:42:58.000000', NULL),
(18, 11, 14, 'EDI Reconciliation Release Unit', 'EDI Reconciliation Release Unit', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-18 00:43:18.000000', '2026-08-18 00:43:18.000000', NULL),
(19, 12, 15, 'Payslips Sync Release Unit', 'Payslips Sync Release Unit', 16, 13, 22, 8, NULL, NULL, '2026-08-31', NULL, '2026-08-18 00:42:58.000000', '2026-08-18 00:52:11.000000', NULL),
(20, 9, 11, 'SQL - Twine Sync Release Unit', 'SQL - Twine Sync Release Unit', 16, 13, 22, 8, NULL, NULL, NULL, NULL, '2026-08-18 01:42:39.000000', '2026-08-18 01:42:59.000000', NULL),
(21, 13, 16, 'Fintrac Blacklist Release Unit', 'Fintrac Blacklist Release Unit', 16, 13, 22, 11, NULL, NULL, NULL, NULL, '2026-08-18 01:55:18.000000', '2026-08-18 01:55:18.000000', NULL),
(22, 9, 11, 'Twine - SQL Sync Release Unit', 'Twine-SQL Sync Release Unit', 16, 13, 22, 8, NULL, NULL, NULL, NULL, '2026-09-01 15:35:50.000000', '2026-09-01 15:47:45.000000', NULL),
(23, 14, 17, 'Geolocation Release Unit', NULL, 16, 13, 22, 14, NULL, NULL, NULL, NULL, '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000', NULL);

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
(1, 1, 1, 1, 52, '2026-09-23 20:40:03.000000', '2026-09-23 20:40:03.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-09-23 20:40:04.000000'),
(2, 1, 1, 2, 52, '2026-09-23 20:40:47.000000', '2026-09-23 20:40:47.000000', 5, NULL, 'It was confirmed by Ricahr Fumachi', 'wasfasdfa', '2026-08-15 12:00:00.000000', '2026-09-23 20:40:47.000000'),
(3, 1, 1, 3, 29, '2026-09-23 20:41:15.000000', '2026-09-23 20:41:15.000000', 1, NULL, 'asfdsadf', NULL, '2026-08-15 12:00:00.000000', '2026-09-23 20:41:15.000000'),
(4, 1, 1, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(5, 1, 2, 1, 52, '2026-08-17 19:54:57.000000', '2026-08-17 19:54:57.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:54:57.000000'),
(6, 1, 2, 2, 52, '2026-08-17 19:55:04.000000', '2026-08-17 19:55:04.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:55:04.000000'),
(7, 1, 2, 3, 52, '2026-09-23 20:13:05.000000', '2026-09-23 20:13:05.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-09-23 20:13:05.000000'),
(8, 1, 2, 4, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(9, 1, 3, 1, 52, '2026-08-17 19:59:05.000000', '2026-08-17 19:59:05.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:59:05.000000'),
(10, 1, 3, 2, 52, '2026-08-17 19:59:10.000000', '2026-08-17 19:59:10.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:59:10.000000'),
(11, 1, 3, 3, 52, '2026-08-17 19:59:17.000000', '2026-08-17 19:59:17.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:59:17.000000'),
(12, 1, 3, 4, 28, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(13, 1, 4, 1, 52, '2026-08-17 19:58:05.000000', '2026-08-17 19:58:05.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:58:05.000000'),
(14, 1, 4, 2, 30, '2026-08-17 19:58:19.000000', '2026-08-17 19:58:19.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:58:19.000000'),
(15, 1, 4, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(16, 1, 4, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(17, 1, 5, 1, 52, '2026-08-17 19:55:36.000000', '2026-08-17 19:55:36.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:55:36.000000'),
(18, 1, 5, 2, 29, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(19, 1, 5, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(20, 1, 5, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(21, 1, 6, 1, 52, '2026-08-17 19:54:00.000000', '2026-08-17 19:54:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:54:00.000000'),
(22, 1, 6, 2, 30, '2026-08-28 23:31:38.000000', '2026-08-28 23:31:38.000000', 2, NULL, 'Coordinating with Ximena and Mario -  2026-08-17', 'Backend is ready. AdminAPI in progress', '2026-08-15 12:00:00.000000', '2026-08-28 23:31:38.000000'),
(23, 1, 6, 3, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(24, 1, 6, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(25, 1, 7, 1, 30, '2026-08-17 19:53:38.000000', '2026-08-17 19:53:38.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-17 19:53:38.000000'),
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
(36, 1, 9, 4, 24, '2026-08-07 10:00:00.000000', '2026-08-07 10:00:00.000000', 2, NULL, 'Reconstructed baseline from 2026-08-07 meeting with Ximena', NULL, '2026-08-15 12:00:00.000000', '2026-08-15 12:00:00.000000'),
(41, 2, 11, 5, 52, '2026-08-18 02:31:41.000000', '2026-08-18 02:31:41.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 21:53:14.000000', '2026-08-18 02:31:41.000000'),
(42, 2, 11, 6, 52, '2026-08-18 02:32:10.000000', '2026-08-18 02:32:10.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 21:53:14.000000', '2026-08-18 02:32:10.000000'),
(43, 2, 11, 7, 24, '2026-08-18 03:38:58.000000', '2026-08-18 03:38:58.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 21:53:14.000000', '2026-08-18 03:38:58.000000'),
(44, 2, 11, 8, 28, '2026-08-18 02:33:01.000000', '2026-08-18 02:33:01.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-17 21:53:14.000000', '2026-08-18 02:33:02.000000'),
(45, 2, 12, 5, 52, '2026-08-18 02:33:30.000000', '2026-08-18 02:33:30.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 22:03:34.000000', '2026-08-18 02:33:30.000000'),
(46, 2, 12, 6, 52, '2026-08-18 03:39:24.000000', '2026-08-18 03:39:24.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 22:03:34.000000', '2026-08-18 03:39:24.000000'),
(47, 2, 12, 7, 24, '2026-08-17 22:03:34.000000', '2026-08-17 22:03:34.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-17 22:03:34.000000', '2026-08-17 22:03:34.000000'),
(48, 2, 12, 8, 28, '2026-08-18 03:39:42.000000', '2026-08-18 03:39:42.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-17 22:03:34.000000', '2026-08-18 03:39:42.000000'),
(49, 2, 13, 5, 52, '2026-09-11 14:03:03.000000', '2026-09-11 14:03:03.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 23:06:01.000000', '2026-09-11 14:03:03.000000'),
(50, 2, 13, 6, 52, '2026-09-11 14:03:10.000000', '2026-09-11 14:03:10.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 23:06:01.000000', '2026-09-11 14:03:10.000000'),
(51, 2, 13, 7, 24, '2026-08-17 23:06:01.000000', '2026-08-17 23:06:01.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-17 23:06:01.000000', '2026-08-17 23:06:01.000000'),
(52, 2, 13, 8, 28, '2026-08-18 03:40:41.000000', '2026-08-18 03:40:41.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 23:06:01.000000', '2026-08-18 03:40:41.000000'),
(53, 2, 14, 5, 30, '2026-08-18 14:02:50.000000', '2026-08-18 14:02:50.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-17 23:13:07.000000', '2026-08-18 14:02:50.000000'),
(54, 2, 14, 6, 30, '2026-08-31 20:34:28.000000', '2026-08-31 20:34:28.000000', NULL, NULL, 'Item initial creation', NULL, '2026-08-17 23:13:07.000000', '2026-08-31 20:34:28.000000'),
(55, 2, 14, 7, 24, '2026-08-17 23:13:07.000000', '2026-08-17 23:13:07.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-17 23:13:07.000000', '2026-08-17 23:13:07.000000'),
(56, 2, 14, 8, 24, '2026-08-17 23:13:07.000000', '2026-08-17 23:13:07.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-17 23:13:07.000000', '2026-08-17 23:13:07.000000'),
(57, 2, 15, 5, 25, '2026-08-18 03:41:30.000000', '2026-08-18 03:41:30.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-18 00:06:13.000000', '2026-08-18 03:41:30.000000'),
(58, 2, 15, 6, 24, '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000'),
(59, 2, 15, 7, 24, '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000'),
(60, 2, 15, 8, 24, '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:06:13.000000', '2026-08-18 00:06:13.000000'),
(61, 2, 16, 5, 25, '2026-08-18 03:41:46.000000', '2026-08-18 03:41:46.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-18 00:08:34.000000', '2026-08-18 03:41:46.000000'),
(62, 2, 16, 6, 24, '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000'),
(63, 2, 16, 7, 24, '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000'),
(64, 2, 16, 8, 24, '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:08:34.000000', '2026-08-18 00:08:34.000000'),
(65, 2, 17, 5, 52, '2026-08-18 03:42:05.000000', '2026-08-18 03:42:05.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-18 00:42:58.000000', '2026-08-18 03:42:05.000000'),
(66, 2, 17, 6, 52, '2026-08-18 03:42:27.000000', '2026-08-18 03:42:27.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-18 00:42:58.000000', '2026-08-18 03:42:27.000000'),
(67, 2, 17, 7, 24, '2026-08-18 00:42:58.000000', '2026-08-18 00:42:58.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:42:59.000000', '2026-08-18 00:42:59.000000'),
(68, 2, 17, 8, 28, '2026-08-18 03:42:46.000000', '2026-08-18 03:42:46.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-18 00:42:59.000000', '2026-08-18 03:42:46.000000'),
(69, 2, 18, 5, 52, '2026-08-18 03:43:13.000000', '2026-08-18 03:43:13.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-18 00:43:18.000000', '2026-08-18 03:43:13.000000'),
(70, 2, 18, 6, 52, '2026-08-18 03:43:30.000000', '2026-08-18 03:43:30.000000', 5, NULL, 'Item initial creation', NULL, '2026-08-18 00:43:18.000000', '2026-08-18 03:43:30.000000'),
(71, 2, 18, 7, 24, '2026-08-18 00:43:18.000000', '2026-08-18 00:43:18.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:43:19.000000', '2026-08-18 00:43:19.000000'),
(72, 2, 18, 8, 28, '2026-08-18 03:43:47.000000', '2026-08-18 03:43:47.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-18 00:43:19.000000', '2026-08-18 03:43:47.000000'),
(73, 2, 19, 5, 52, '2026-09-11 14:04:00.000000', '2026-09-11 14:04:00.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-18 00:45:42.000000', '2026-09-11 14:04:00.000000'),
(74, 2, 19, 6, 29, '2026-09-11 14:04:22.000000', '2026-09-11 14:04:22.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-18 00:45:42.000000', '2026-09-11 14:04:22.000000'),
(75, 2, 19, 7, 24, '2026-08-18 00:45:42.000000', '2026-08-18 00:45:42.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:45:42.000000', '2026-08-18 00:45:42.000000'),
(76, 2, 19, 8, 24, '2026-08-18 01:42:39.000000', '2026-08-18 01:42:39.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 01:42:39.000000', '2026-08-18 01:42:39.000000'),
(81, 2, 20, 5, 25, '2026-08-18 03:44:18.000000', '2026-08-18 03:44:18.000000', 8, NULL, 'Item initial creation', NULL, '2026-08-18 00:45:42.000000', '2026-08-18 03:44:18.000000'),
(82, 2, 20, 6, 24, '2026-08-18 00:45:42.000000', '2026-08-18 00:45:42.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:45:42.000000', '2026-08-18 00:45:42.000000'),
(83, 2, 20, 7, 24, '2026-08-18 00:45:42.000000', '2026-08-18 00:45:42.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 00:45:42.000000', '2026-08-18 00:45:42.000000'),
(84, 2, 20, 8, 24, '2026-08-18 01:42:39.000000', '2026-08-18 01:42:39.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 01:42:39.000000', '2026-08-18 01:42:39.000000'),
(85, 2, 21, 5, 52, '2026-09-10 00:02:28.000000', '2026-09-10 00:02:28.000000', 11, NULL, 'Item initial creation', NULL, '2026-08-18 01:55:18.000000', '2026-09-10 00:02:28.000000'),
(86, 2, 21, 6, 52, '2026-09-10 00:02:33.000000', '2026-09-10 00:02:33.000000', 11, NULL, 'Item initial creation', NULL, '2026-08-18 01:55:18.000000', '2026-09-10 00:02:33.000000'),
(87, 2, 21, 7, 24, '2026-08-18 01:55:18.000000', '2026-08-18 01:55:18.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 01:55:18.000000', '2026-08-18 01:55:18.000000'),
(88, 2, 21, 8, 28, '2026-09-10 00:02:43.000000', '2026-09-10 00:02:43.000000', NULL, NULL, 'Item initial creation', NULL, '2026-08-18 01:55:18.000000', '2026-09-10 00:02:43.000000'),
(91, 2, 10, 5, 52, '2026-09-11 14:05:33.000000', '2026-09-11 14:05:33.000000', 1, NULL, 'Item initial creation prueba', NULL, '2026-08-18 02:13:07.000000', '2026-09-11 14:05:33.000000'),
(92, 2, 10, 6, 29, '2026-09-11 14:05:55.000000', '2026-09-11 14:05:55.000000', NULL, NULL, 'Item initial creation', NULL, '2026-08-18 02:13:07.000000', '2026-09-11 14:05:55.000000'),
(93, 2, 10, 7, 24, '2026-08-18 02:13:07.000000', '2026-08-18 02:13:07.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 02:13:07.000000', '2026-08-18 02:13:07.000000'),
(94, 2, 10, 8, 24, '2026-08-18 02:13:07.000000', '2026-08-18 02:13:07.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-08-18 02:13:07.000000', '2026-08-18 02:13:07.000000'),
(97, 2, 22, 5, 25, '2026-09-01 15:49:35.000000', '2026-09-01 15:49:35.000000', 8, NULL, 'Item initial creation', NULL, '2026-09-01 15:35:50.000000', '2026-09-01 15:49:35.000000'),
(98, 2, 22, 6, 24, '2026-09-01 15:35:50.000000', '2026-09-01 15:35:50.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-09-01 15:35:51.000000', '2026-09-01 15:35:51.000000'),
(99, 2, 22, 7, 24, '2026-09-01 15:35:50.000000', '2026-09-01 15:35:50.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-09-01 15:35:51.000000', '2026-09-01 15:35:51.000000'),
(100, 2, 22, 8, 24, '2026-09-01 15:35:50.000000', '2026-09-01 15:35:50.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-09-01 15:35:51.000000', '2026-09-01 15:35:51.000000'),
(101, 3, 23, 9, 25, '2026-09-10 00:16:58.000000', '2026-09-10 00:16:58.000000', NULL, NULL, 'Item initial creation', NULL, '2026-09-10 00:10:47.000000', '2026-09-10 00:16:58.000000'),
(102, 3, 23, 10, 24, '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000'),
(103, 3, 23, 11, 24, '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000'),
(104, 3, 23, 12, 24, '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000', NULL, 'Initial Creation', 'Item initial creation', NULL, '2026-09-10 00:10:47.000000', '2026-09-10 00:10:47.000000');

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
  ADD KEY `release_items_project_id_priority_id_target_date_index` (`priority_id`,`target_date`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239;

--
-- AUTO_INCREMENT de la tabla `catalog_values`
--
ALTER TABLE `catalog_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `client_activations`
--
ALTER TABLE `client_activations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `people`
--
ALTER TABLE `people`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `project_environments`
--
ALTER TABLE `project_environments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `releases`
--
ALTER TABLE `releases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `release_items`
--
ALTER TABLE `release_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `release_item_environment_states`
--
ALTER TABLE `release_item_environment_states`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

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
