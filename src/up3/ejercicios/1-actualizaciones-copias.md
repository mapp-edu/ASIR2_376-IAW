---
layout: doc
title: P3.1 — Actualizaciones, plugins, copias de seguridad e importación
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P3.1 — Actualizaciones, plugins, copias de seguridad y exportar e importar contenido

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP3 · RA3.
- **Criterios de evaluación:** 3c, 3d, 3e, 3h.
- **Proyecto:** [portal interno con WordPress](/up2/ejercicios/).
- **Punto de partida:** el sitio configurado en la [P2.2](/up2/ejercicios/2-uso-basico-wordpress).
- **Entrega:** puntos 3, 4, 5 y 6 del manual de usuario.
:::

## Descripción

Realizarás las tareas de administración y mantenimiento esenciales en WordPress: actualización de WordPress, gestión de plugins, copias de respaldo y migración de contenidos del sitio.

## Objetivos

- Conocer el estado de actualización de un sitio WordPress y mantenerlo al día.
- Gestionar los plugins instalados y añadir los que hagan falta.
- Programar copias de seguridad, guardarlas fuera del servidor y restaurarlas.
- Exportar e importar contenidos comprobando que no se pierde información.

## Requisitos

### Actualizaciones de WordPress

En **Escritorio → Actualizaciones**:

1. Averiguar la versión de WordPress que está instalada.
2. Comprobar si existen actualizaciones pendientes de instalar.
3. Activar las actualizaciones de WordPress para que se realicen de forma automática.

### Gestión de plugins

En **Plugins → Plugins instalados**:

1. Averiguar dónde aparecen los plugins instalados en WordPress.
2. Realizar la actualización de un plugin instalado.
3. Activar las actualizaciones automáticas del plugin.
4. Instalar el plugin para copias de seguridad **UpdraftPlus**, desde **Plugins → Añadir nuevo**.

### Copias de seguridad

Con UpdraftPlus:

1. Programar una copia de seguridad.
2. Configurar un destino externo para almacenar la copia.
3. Restaurar una copia de seguridad.

### Exportación e importación de contenido

En **Herramientas → Exportar** y **Herramientas → Importar**:

1. Exportar las páginas creadas en WordPress en la P2.2.
2. Eliminar páginas de WordPress para poder comprobar el funcionamiento de la importación.
3. Importar las páginas y comprobar que la exportación y la importación se han realizado correctamente.

::: danger-box Haz una copia antes de borrar
Antes de eliminar páginas, asegúrate de que tienes el archivo de exportación descargado y una copia de seguridad reciente.
:::

## Entregable

Añade estos puntos al manual de usuario:

- **Punto 3. Parches y actualizaciones.**
- **Punto 4. Gestión de plugins.**
- **Punto 5. Copias de seguridad.**
- **Punto 6. Exportación e importación de contenido.**

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Actualizaciones de WordPress y de plugins**<br>CE 3h | No se identifica la versión instalada, o las actualizaciones automáticas no quedan activadas. | Versión identificada, actualizaciones pendientes revisadas y actualizaciones automáticas activadas en WordPress y en un plugin. | Explica qué riesgos evita actualizar y qué puede romper una actualización automática. | El manual propone una rutina de actualización para el portal, coherente con la política de copias. |
| **Integración de plugins**<br>CE 3c | UpdraftPlus no está instalado o no está activo. | UpdraftPlus instalado y activo; se sabe localizar y actualizar los plugins instalados. | Justifica por qué se añade ese plugin y qué necesidad del portal cubre. | El manual explica cómo valorar e instalar un plugin nuevo de forma que sirva para otros casos. |
| **Copias de seguridad**<br>CE 3d | No hay copia programada, o no se ha conseguido restaurar. | Copia programada, destino externo configurado y una restauración realizada. | Justifica la frecuencia, el contenido de la copia y el destino elegidos. | El manual recoge el procedimiento completo de copia y de recuperación ante un fallo. |
| **Exportación e importación de contenidos**<br>CE 3e | La exportación o la importación no se completan, o se pierden páginas. | Páginas exportadas, eliminadas e importadas de nuevo sin pérdidas. | Explica qué incluye el archivo de exportación y en qué se diferencia de una copia de seguridad. | El manual documenta cómo comprobar que el contenido importado es correcto. |

---

**Siguiente práctica:** [P4.1 PHP en WordPress con Code Snippets →](/up4/ejercicios/1-code-snippets)
