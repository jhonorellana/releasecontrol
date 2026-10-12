---
title: Sistema de Control de Proyectos y Releases — PRD del MVP Local (Línea Base Implementada v1.0)
lang: es
---

# DOCUMENTO DE REQUERIMIENTOS DE PRODUCTO (PRD)

# Sistema de Control de Proyectos y Releases

MVP Local · Angular + Laravel + MySQL

**Responsable (Owner):** Jhon  
**Estado:** Aprobado y Línea Base de MVP Implementada  
**Versión:** 1.0  
**Fecha:** 12 de octubre de 2026 (Actualizado desde el borrador v0.1 del 14 de agosto de 2026)  
**Proyectos Soportados:** Reports (Piloto base), AdminAPI, Invoicing, Dashboard y Fintrac

---

## Resumen Ejecutivo

El **Sistema de Control de Proyectos y Releases** es una aplicación operativa concebida como única fuente de verdad (*single source of truth*), diseñada para erradicar la fragmentación, la ambigüedad en los estados y las suposiciones no verificadas a lo largo de los entornos de desarrollo de software.

Históricamente, el seguimiento del avance de los releases dependía de hojas de cálculo estáticas y actualizaciones verbales en reuniones. Aunque útiles como fotografías de un momento puntual, estos métodos no conservaban quién había verificado cada estado, cuándo se probó, qué acciones pendientes o bloqueos existían, ni si una funcionalidad desplegada en PROD estaba realmente habilitada para los clientes.

El **MVP Local Implementado (v1.0)** resuelve esta problemática unificando:
1. **Gestión Jerárquica del Portafolio de Proyectos:** Proyectos, Módulos, Releases y Unidades Atómicas de Release (*Release Units / Release Items*).
2. **Matriz Interactiva de Promoción por Entornos:** Seguimiento visual del pipeline a través de MOJA, TATU, SITA y PROD con atribución de confirmador y marcas de tiempo.
3. **Desacoplamiento entre Despliegue Técnico y Activación a Clientes:** Distinción operativa explícita entre el código residente en PROD y la disponibilidad real para los clientes (global, selectiva, por planes o grupos).
4. **Puntos de Acción (*Follow-ups*) con Banderas de Prioridad y Antigüedad:** Visibilidad instantánea de qué debe hacerse, quién es el responsable, fechas límite, banderas de prioridad (🚩 Crítico/Bloqueo, ⚡ Alta, 🔹 Media, 🟢 Baja) y antigüedad en días (`Today`, `1 day`, `X days`) con alertas de estancamiento (> 7 días).
5. **Historial Auditable y Archivado Lógico (*Soft Deletes*):** Trazabilidad completa mediante eventos inmutables de auditoría y eliminación lógica no destructiva en todos los modelos.
6. **Persistencia de Filtros entre Pantallas:** Retención de estado en memoria y `localStorage` a través de la navegación y recargas de página.

---

# 1. Control del Documento

| **Campo** | **Definición** |
|---|---|
| Nombre del producto | Sistema de Control de Proyectos y Releases |
| Tipo de documento | PRD — Documento de Requerimientos de Producto (Línea Base As-Built) |
| Versión / Estado | 1.0 / Aprobado e Implementado |
| Dueño del producto (PO) | Jhon |
| Usuario operativo | Jhon (Operación local mono-usuario con registro de actor de auditoría) |
| Pila tecnológica | Angular (Frontend SPA), Laravel (Backend API REST), MySQL (Base de datos) |
| Fuente de verdad | Aplicación Web Operativa (`http://localhost:4200`) respaldada en MySQL |
| Proyectos activos | Reports, AdminAPI, Invoicing, Dashboard, Fintrac |

## 1.1 Historial de Revisiones

| **Versión** | **Fecha** | **Autor** | **Resumen de Cambios** |
|---|---|---|---|
| 0.1 | 14 de ago, 2026 | Jhon | Borrador inicial para revisión y descubrimiento de viabilidad. |
| 1.0 | 12 de oct, 2026 | Jhon / AI Pair | Actualización formal que refleja el MVP completamente implementado y probado. Consolidación de pantallas en 6 módulos unificados, relaciones definitivas Proyecto-Módulo-Release, integración de Banderas de Prioridad, cálculo de Antigüedad, alineación en grid 1 a 1, persistencia de filtros y cierre de todas las preguntas abiertas. |

---

# 2. Declaración del Problema y Filosofía Operativa

## 2.1 El Problema Fundamental
- **Verdad dispersa:** Los estados críticos de los releases se encontraban repartidos entre tickets de Jira, mensajes de chat, notas de reuniones y la memoria de las personas.
- **La falacia de "PROD":** Se confundía frecuentemente "está en PROD" con "los clientes lo están usando". El despliegue técnico y la activación comercial no se gestionaban como ciclos de vida independientes.
- **Caja negra de entornos:** Las promociones entre entornos (ej. de TATU a SITA/PROD) carecían de fechas de verificación trazables y de la persona que las confirmó.
- **Accionabilidad ambigua:** Las iniciativas pendientes no contaban con una próxima acción clara, designación de bloqueos ni mecanismos de escalamiento.

## 2.2 Principio Operativo Central
> **"Un estado sin fecha, fuente y persona confirmadora es tan solo una hipótesis. Una hipótesis debe producir una acción inmediata de verificación, no reportarse como un hecho."**

---

# 3. Visión del Producto, Objetivos y Criterios de Éxito

## 3.1 Visión
Proveer un espacio de trabajo centralizado, verificable y accionable que permita al Product Owner y a los líderes técnicos responder a tres preguntas en cuestión de segundos:
1. *¿Dónde se encuentra exactamente cada funcionalidad en nuestros entornos?*
2. *¿Está técnicamente desplegada y, además, habilitada para los clientes?*
3. *¿Qué está bloqueando el avance, quién es el responsable y cuál es el siguiente paso?*

## 3.2 Objetivos del MVP y Resultados de Verificación

| **Objetivo** | **Meta de Aceptación** | **Estado Implementado** |
|---|---|---|
| Cobertura del portafolio | 100% de los temas base representados a través de los proyectos. | **Alcanzado.** Línea base de Reports y módulos de AdminAPI/Invoicing activos. |
| Accionabilidad | Todo ítem abierto cuenta con una acción siguiente, responsable, bandera de prioridad y antigüedad. | **Alcanzado.** Los puntos de acción disponen de banderas de prioridad, badges de antigüedad y etiquetas de bloqueo. |
| Trazabilidad | Cada promoción registra fecha, persona confirmadora y notas opcionales. | **Alcanzado.** Capturado en `release_item_environment_states` y `audit_events`. |
| Rapidez de consulta | Identificar bloqueos y seguimientos vencidos en menos de 30 segundos. | **Alcanzado.** Los combos de filtrado y KPIs destacan bloqueos y elementos estancados al instante. |
| Distinción en PROD | Cero confusión entre despliegue técnico y disponibilidad para clientes. | **Alcanzado.** Módulo dedicado de Client Activation con estados independientes. |
| Seguridad de datos | Operaciones no destructivas y respaldos validados de base de datos. | **Alcanzado.** SoftDeletes en todos los modelos; volcado SQL base establecido. |

---

# 4. Alcance Implementado (v1.0)

## 4.1 Capacidades Incluidas y Operativas

1. **Dashboard de Portafolio (`/dashboard`):** Resumen de KPIs en tiempo real (Total Releases, Bloqueos Activos, Acciones Vencidas, Activaciones No Confirmadas), insignias de salud del proyecto y enlaces directos a vistas de detalle filtradas.
2. **Matriz de Seguimiento por Entornos (`/matrix`):** Rejilla interactiva que muestra todas las Unidades de Release frente a MOJA, TATU, SITA y PROD. Incluye:
   - Modales interactivos para promocionar de estado con atribución de confirmador.
   - Acciones siguientes alineadas mediante una disposición responsiva 1 a 1 para textos multilínea.
   - Columnas dedicadas y ordenables para `OWNER` y `AGE`.
   - Filtro tri-estado: *All Units* (Todas), *With Active Actions* (Con acciones activas), *Without Active Actions* (Sin acciones activas).
   - Persistencia de filtros mediante `FilterStateService`.
3. **Módulo de Activación a Clientes (`/activations`):** Matriz dedicada que rastrea la habilitación post-PROD con alcances: `global`, `selective`, `off`, `all`, `group`, `plan`, `not_applicable`, `unknown`.
4. **Bandeja de Acciones y Puntos de Seguimiento (`/follow-ups`):** Tabla integral con:
   - **Banderas de Prioridad Visuales:** 🚩 Crítico / Bloqueo, ⚡ Alta, 🔹 Media, 🟢 Baja.
   - **Seguimiento de Antigüedad (`AGE`):** Días calculados desde la creación (`Today`, `1 day`, `X days`) con alertas visuales en ámbar para elementos estancados (> 7 días).
   - Ordenación completa en todas las cabeceras (`ID`, `RELEASE UNIT`, `ACTION POINT`, `STATUS`, `PRIORITY`, `AGE`, `OWNER`, `TARGET DATE`).
   - Modales de actualización rápida para reasignación, cambios de estado y registro del resultado final.
5. **Historial de Auditoría (`/audit`):** Libro mayor inmutable y con opción de búsqueda que registra tipos de entidad (`project`, `release`, `release_item`, `follow_up`), valores antes/después, actores lógicos y marcas de tiempo exactas.
6. **Datos Maestros y Configuración (`/settings`):** Panel administrativo con 5 pestañas:
   - Proyectos (CRUD, responsables, estado).
   - Paquetes de Release (CRUD, fechas estimadas, alcance, notas).
   - Unidades de Release (CRUD, asociaciones proyecto/módulo/release).
   - Catálogos (Estados, Prioridades, Estados de Entorno, Alcances de Activación).
   - Personas y Contactos (Miembros del equipo, roles, correos).
   - Archivado lógico (*Soft Deletes*) con modales de confirmación.

## 4.2 Fuera del Alcance (Postergado para Fases Futuras)
- Autenticación multi-usuario corporativa con Microsoft Entra / SSO.
- Sincronización bidireccional automática con APIs REST de Jira.
- Notificaciones push externas (Slack, Microsoft Teams, correo automático).
- Almacenamiento de credenciales de clientes, secretos o datos protegidos de producción.
- Disparadores automatizados de pipelines CI/CD.

---

# 5. Arquitectura de Pantallas Implementada

La propuesta inicial de 8 pantallas dispersas se consolidó en **6 módulos cohesivos de alta eficiencia operativa**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   BARRA DE NAVEGACIÓN RELEASE CONTROL                  │
├─────────────┬────────────────────┬─────────────────┬───────────────────┤
│  Dashboard  │ Environment Matrix │ Client Activat. │ Action Items      │
│  (/dashboard)│ (/matrix)          │ (/activations)  │ (/follow-ups)     │
├─────────────┴────────────────────┴─────────────────┴───────────────────┤
│  Audit History (/audit)          │ Settings & Master Data (/settings)  │
└──────────────────────────────────┴─────────────────────────────────────┘
```

### Detalle de Pantallas y Capacidades:

| **Pantalla** | **Ruta** | **Componentes y Capacidades Clave** |
|---|---|---|
| **Portfolio Dashboard** | `/dashboard` | Resumen de salud del sistema, conteo de releases activos, alertas de bloqueos, acciones vencidas, advertencias de activaciones pendientes y atajos rápidos de navegación. |
| **Environment Tracking Matrix** | `/matrix` | Cuadrícula operativa principal. Rastrea unidades de release frente a MOJA, TATU, SITA, PROD. Celdas cliqueables para promoción, acciones alineadas con responsables y días de antigüedad, fecha de última verificación, búsqueda por texto y filtros por Proyecto, Módulo y Estado de Acción. |
| **Client Activation** | `/activations` | Separación operativa entre código en PROD y uso de los clientes. Presenta fecha de despliegue, estado de activación, alcance (Global, Grupo, Plan, Selectivo) y registros de confirmación. |
| **Action Items & Follow-ups** | `/follow-ups` | Bandeja centralizada de acciones pendientes. Filtros por Proyecto, Estado, Prioridad, Responsable y solo Bloqueos. Banderas visuales de prioridad (🚩, ⚡, 🔹, 🟢), antigüedad en días (`Today`, `X days`) y cabeceras interactivas ordenables. |
| **Audit History** | `/audit` | Historial de auditoría searchable que muestra entidades (`project`, `release`, `release_item`, `follow_up`), valores previos y nuevos, autores lógicos y marcas temporales. |
| **Master Data & Settings** | `/settings` | Panel administrativo de 5 pestañas: (1) Proyectos, (2) Paquetes de Release, (3) Unidades de Release, (4) Catálogos y Valores, (5) Miembros del Equipo. Incluye confirmación de borrado lógico y persistencia de filtros. |

---

# 6. Modelo de Datos Conceptual y Técnico

## 6.1 Relaciones Principales de Entidad

El modelo garantiza integridad referencial estricta y permite que los releases se gestionen a nivel de proyecto abarcando múltiples módulos:

```text
[Proyecto] ──1:N──> [Módulo]
   │
   ├──1:N──> [Release] (Paquete de Release por Proyecto)
   │            │
   │            └──1:N──> [ReleaseItem] (Unidad de Release) <──1:N── [Módulo]
   │                         │
   ├──1:N──> [ProjectEnv]   ├──1:N──> [ReleaseItemEnvironmentState]
   │                         ├──1:1──> [ClientActivation]
   │                         ├──1:N──> [FollowUp] (Punto de Acción)
   │                         └──1:N──> [AuditEvent]
   └──1:N──> [Persona] (Líderes Asignados y Confirmadores)
```

## 6.2 Entidades Implementadas y Esquema

| **Entidad** | **Nombre de Tabla** | **Atributos Clave** | **Notas** |
|---|---|---|---|
| **Project** | `projects` | `id`, `name`, `code`, `description`, `status_id`, `owner_person_id`, `deleted_at` | Contenedor principal de portafolio. Usa SoftDeletes. |
| **Module** | `modules` | `id`, `project_id`, `name`, `code`, `description`, `status_id`, `owner_person_id`, `deleted_at` | División funcional de un Proyecto. Su borrado lógico se propaga en cascada a sus Unidades de Release. |
| **Release** | `releases` | `id`, `project_id`, `name`, `code`, `status_id`, `owner_person_id`, `target_date`, `scope`, `release_notes_url`, `notes`, `deleted_at` | Hito planificado de despliegue dentro de un Proyecto. |
| **ReleaseItem** | `release_items` | `id`, `project_id`, `module_id`, `release_id`, `title`, `type_id`, `priority_id`, `status_id`, `jira_key`, `jira_url`, `description`, `deleted_at` | Unidad atómica de seguimiento (*Release Unit*). Vincula Proyecto, Módulo y Release. |
| **ProjectEnvironment** | `project_environments` | `id`, `project_id`, `name`, `code`, `sort_order`, `is_active` | Entornos configurables por proyecto (ej. MOJA, TATU, SITA, PROD). |
| **EnvironmentState** | `release_item_environment_states` | `id`, `release_item_id`, `project_environment_id`, `status_id`, `verified_at`, `source_summary`, `confirmed_by_person_id`, `notes` | Único por `(release_item_id, project_environment_id)`. Registra la evolución en entornos. |
| **ClientActivation** | `client_activations` | `id`, `release_item_id`, `scope_type`, `scope_detail`, `activated_at`, `confirmed_by_person_id`, `notes` | Tipos de alcance: `global`, `selective`, `off`, `all`, `group`, `plan`, `not_applicable`, `unknown`. |
| **FollowUp** | `follow_ups` | `id`, `release_item_id`, `action`, `status_id`, `priority_id`, `owner_person_id`, `contact_person_id`, `due_date`, `is_blocker`, `notes`, `completed_at`, `created_at`, `updated_at`, `deleted_at` | Puntos de Acción. Alimentan `NEXT ACTION`, Banderas de Prioridad y Antigüedad. |
| **CatalogValue** | `catalog_values` | `id`, `category`, `code`, `label`, `description`, `color`, `sort_order`, `is_active` | Catálogos dinámicos: `project_status`, `release_status`, `environment_state`, `follow_up_status`, `priority`, etc. |
| **Person** | `people` | `id`, `name`, `email`, `role`, `display_name`, `is_active`, `deleted_at` | Integrantes del equipo, líderes técnicos, responsables y confirmadores. |
| **AuditEvent** | `audit_events` | `id`, `entity_type`, `entity_id`, `event_type`, `changes` (JSON), `context` (JSON), `actor_name`, `occurred_at` | Registro append-only de auditoría que guarda cambios de estado y actualizaciones. |

---

# 7. Reglas de Negocio y Matriz Lógica

| **ID** | **Nombre de Regla** | **Lógica Operativa** |
|---|---|---|
| **BR-001** | Desacoplamiento PROD / Activación | El despliegue a PROD genera un hito técnico, pero mantiene la Activación a Clientes en estado inactivo o no confirmado hasta verificarse expresamente su alcance. |
| **BR-002** | Atribución de Promoción | Toda promoción de entorno exige seleccionar una persona confirmadora (`confirmed_by_person_id`) y registra la fecha de verificación actual. |
| **BR-003** | Código de Colores de Prioridad | Los Puntos de Acción aplican estrictamente los colores de catálogo: Crítico/Bloqueo (`#EF4444`), Alta (`#F59E0B`), Media (`#3B82F6`), Baja (`#10B981`). |
| **BR-004** | Cálculo de Antigüedad y Alerta de Estancamiento | La antigüedad del pendiente se calcula dinámicamente desde `created_at` (`Today`, `1 day`, `X days`). Aquellos ítems abiertos por más de 7 días activan la alerta visual en ámbar (`.age-stale`). |
| **BR-005** | Fecha de Última Verificación | La columna `LAST VERIFIED` de la Matriz resuelve la marca de tiempo más reciente entre los Puntos de Acción asociados (`updated_at` / `created_at`) y las confirmaciones de entorno (`verified_at`). |
| **BR-006** | Alineación de Filas 1 a 1 en Grid | La Matriz utiliza `.action-row-grid` (`1fr 105px 85px`), asegurando que cada descripción de actividad, responsable y días de antigüedad permanezcan bloqueados y centrados verticalmente entre sí, incluso con textos de múltiples líneas. |
| **BR-007** | Archivado No Destructivo | Toda eliminación invoca el trait `SoftDeletes` de Laravel Eloquent (`deleted_at = NOW()`), resguardando las referencias históricas en consultas y auditoría. |
| **BR-008** | Integridad en Cascada de Módulos | La eliminación lógica de un Módulo desencadena automáticamente la eliminación lógica de sus Unidades de Release subordinadas. |
| **BR-009** | Persistencia de Filtros | Las búsquedas, combos desplegables (Proyecto, Módulo, Acciones), pestañas activas y ordenaciones se guardan en `localStorage` al navegar entre pantallas. |
| **BR-010** | Controles de Fecha de Alto Contraste | Los datepickers implementan `color-scheme: dark` y `filter: brightness(0) invert(1)` para que el icono del calendario se muestre en blanco puro sobre fondos oscuros. |

## 7.1 Matriz de Precedencia de Salud

Para determinar la salud global de un release o proyecto en el dashboard:

| **Precedencia** | **Estado** | **Condición Disparadora** | **Token de Color** |
|:---:|---|---|---|
| **1 (Más alta)** | **Blocked (Bloqueado)** | Existe al menos un Punto de Acción con `is_blocker = true`. | `--danger` (`#EF4444`) |
| **2** | **Overdue (Vencido)** | Existe un Punto de Acción abierto con `due_date < HOY`. | `--danger` (`#F87171`) |
| **3** | **Needs Follow-up (Requiere Seguimiento)** | Desplegado en PROD pero con Activación a Clientes pendiente o no confirmada. | `--warning` (`#F59E0B`) |
| **4** | **Action Required (Acción Requerida)** | Unidad de release abierta sin puntos de acción activos o sin responsable asignado. | `--warning` (`#F97316`) |
| **5** | **In Progress (En Progreso)** | Ítems activos avanzando en MOJA, TATU o SITA. | `--info` (`#3B82F6`) |
| **6 (Más baja)** | **On Track (Al Día)** | Progreso normal sin excepciones, bloqueos ni fechas vencidas. | `--success` (`#10B981`) |

---

# 8. Resolución de Preguntas Abiertas (Del Borrador v0.1)

Todas las preguntas abiertas planteadas en el borrador inicial están **completamente resueltas e implementadas**:

| **ID Pregunta** | **Pregunta en Borrador** | **Resolución e Implementación** |
|---|---|---|
| **OQ-01** | ¿Qué versiones de la pila tecnológica se requieren? | **Resuelto:** PHP 8.2+, Laravel 11, Angular 18/19, Node.js 20+, MySQL 8.0+. |
| **OQ-02** | ¿Se requiere login local o es suficiente un actor lógico? | **Resuelto:** Operación local mono-usuario con actor lógico (`Jhon`, PO) registrado en `audit_events`. Autenticación corporativa delegada a Fase 3. |
| **OQ-03** | ¿Cómo se gestionan las evidencias (URL vs archivo adjunto)? | **Resuelto:** URLs validadas, enlaces a Jira y notas de resultado. Carga de archivos binarios pesados postergada. |
| **OQ-04** | ¿Los entornos son globales o por proyecto? | **Resuelto:** Configurables por proyecto en la tabla `project_environments` (MOJA, TATU, SITA, PROD). |
| **OQ-05** | ¿Cuál es el umbral para considerar datos "estancados"? | **Resuelto:** Establecido en **7 días**. Los ítems abiertos > 7 días muestran badges ámbar `.age-stale`. |
| **OQ-06** | ¿Cómo se gestionan los respaldos de la base de datos? | **Resuelto:** Volcados SQL locales generados en cada hito (ej. `database/release_control_db_06.sql`). Procedimiento de restauración documentado. |
| **OQ-07** | ¿Excel o la aplicación como fuente de verdad? | **Resuelto:** La Aplicación Web (`http://localhost:4200`) es la fuente oficial definitiva; Excel queda superado. |
| **OQ-08** | ¿Qué proyectos validan la reusabilidad del modelo? | **Resuelto:** Modelo validado con éxito en Reports, AdminAPI, Invoicing, Dashboard y Fintrac. |

---

# 9. Especificaciones No Funcionales y Calidad

- **Ejecución Local:** Tanto el backend (`php artisan serve --port=8001`) como el frontend (`ng serve --port=4200`) se ejecutan localmente sin dependencia de red externa.
- **Rendimiento de Consulta:** La aplicación SPA carga y filtra colecciones de datos en menos de 200 ms mediante señales reactivas de Angular y caché en memoria.
- **Sistema de Diseño:** CSS a medida que aplica lineamientos oscuros premium:
  - Fondo base: Slate oscuro (`#0F172A`), superficie de tarjetas (`#1E293B`), glassmorphism con filtros de desenfoque.
  - Tipografía: Fuentes de Google Fonts `Outfit` (títulos) e `Inter` (cuerpo de texto).
  - Demarcación de tablas con contraste: Bordes visibles de 1px, franjas cebra (`rgba(255, 255, 255, 0.025)`) y resaltado interactivo en hover (`rgba(99, 102, 241, 0.09)`).
- **Integridad y Seguridad de Datos:** Claves foráneas con restricciones en cascada, índices únicos compuestos (`['release_item_id', 'project_environment_id']`) y transacciones de base de datos en operaciones multi-tabla.

---

# 10. Hoja de Ruta Post-MVP (Fases Futuras)

| **Fase** | **Nombre del Hito** | **Objetivos Principales** |
|---|---|---|
| **Fase 1** | **MVP Local (Actual)** | **Entregado.** Plataforma operativa completa mono-usuario para Jhon que cubre todos los proyectos base. |
| **Fase 2** | **Expansión de Portafolio** | Herramientas de importación/exportación masiva en Excel/CSV y reportes ejecutivos consolidados. |
| **Fase 3** | **Nube y Multi-usuario** | Despliegue en contenedores (Docker), hosting en la nube, autenticación con Microsoft Entra / SSO y control de roles (Lector, Líder, Administrador). |
| **Fase 4** | **Integraciones** | Webhooks de Jira, trazabilidad de despliegues desde GitHub/GitLab y notificaciones automáticas en Microsoft Teams. |
| **Fase 5** | **Analítica y Métricas** | Análisis de tiempos de ciclo (*cycle time*), mapas de calor de cuellos de botella por entorno y predicción de confiabilidad en releases. |

---

# 11. Aprobaciones y Cierre

| **Rol** | **Nombre** | **Estado** | **Fecha** |
|---|---|---|---|
| **Product Owner / BA** | Jhon | **Aprobado (Línea Base v1.0)** | 12 de octubre de 2026 |
| **Líder Técnico AI / Arquitecto** | Antigravity AI | **Validado y Verificado** | 12 de octubre de 2026 |
