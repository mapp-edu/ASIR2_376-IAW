---
layout: doc
title: UP4 — Adaptación y personalización de gestores de contenidos
sidebar: true
outline: [2, 3]
aside: true
---

# 🧩 UP4 — Adaptación y personalización de gestores de contenidos

Cuando la configuración y los plugins no bastan, un CMS se adapta escribiendo código. En esta unidad se añaden funcionalidades propias a WordPress con PHP, de forma segura y sin tocar los archivos del sistema, usando el plugin Code Snippets.

::: info-box Ficha de la unidad
- **Resultado de aprendizaje:** RA7 — 10 % de la nota del módulo.
- **Duración prevista:** 15 horas.
- **Punto de partida:** el portal de la [UP3](/up3/) y los conocimientos de PHP de la [UP5](/up5/).
:::

## Resultado de aprendizaje

**RA7.** Realizar modificaciones en gestores de contenidos adaptando su apariencia y funcionalidades.

## Criterios de evaluación

| CE | Criterio de evaluación |
|:--:|:-----------------------|
| 7a | Se ha identificado la estructura de directorios del gestor de contenidos. |
| 7b | Se ha reconocido la funcionalidad de los ficheros que utiliza y su naturaleza (código, imágenes, configuración, entre otros). |
| 7c | Se han seleccionado las funcionalidades que hay que adaptar e incorporar. |
| 7d | Se han identificado los recursos afectados por las modificaciones. |
| 7e | Se ha modificado el código de la aplicación para incorporar nuevas funcionalidades y adaptar otras existentes. |
| 7f | Se ha verificado el correcto funcionamiento de los cambios realizados. |
| 7g | Se han documentado los cambios realizados. |

## Contenidos del currículo

- Características de los principales gestores de contenidos.
- Identificación del funcionamiento interno del gestor.
- Selección de modificaciones a realizar.
- Reconocimiento de elementos involucrados.
- Modificación de la apariencia.
- Incorporación y adaptación de funcionalidades.
- Verificación del funcionamiento.
- Documentación.

## Contenidos de la unidad

| Tema | Qué vas a aprender |
|:-----|:-------------------|
| [1. Adaptación de gestores de contenidos](./contenidos/1-adaptacion-cms) | Estructura de WordPress, temas hijo, plugins propios, ganchos, *shortcodes* y acceso a la base de datos con `$wpdb`. |
| [2. Ejemplo guiado: Code Snippets](./contenidos/2-ejemplo-code-snippets) | Crear una tabla propia en la base de datos de WordPress, rellenarla y mostrarla en una página con un *shortcode*. |

## Prácticas

| Práctica | Qué se hace | CE |
|:---------|:------------|:--:|
| [P4.1 PHP en WordPress con Code Snippets](./ejercicios/1-code-snippets) | Añadir al portal un listado de incidencias resueltas programado en PHP. | 7c, 7d, 7e, 7f, 7g |
| [P4.2 Modificar la apariencia con un tema hijo](./ejercicios/2-apariencia-tema-hijo) | Aplicar la imagen corporativa sin perderla al actualizar el tema. | 7a, 7b, 7e, 7g |
| [P4.3 Incorporar funcionalidades con un plugin propio](./ejercicios/3-plugin-propio) | Combinar un plugin de formularios con uno programado por ti. | 7c, 7d, 7e, 7f, 7g |

---

[Empezar por la adaptación de gestores de contenidos →](./contenidos/1-adaptacion-cms)
