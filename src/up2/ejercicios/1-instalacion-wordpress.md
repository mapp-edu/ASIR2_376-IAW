---
layout: doc
title: P2.1 — Instalación de WordPress en AMPPS
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P2.1 — Instalación de WordPress en AMPPS

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP2 · RA2.
- **Criterios de evaluación:** 2c, 2g.
- **Proyecto:** [portal interno con WordPress](./).
- **Entrega:** punto 1 del manual de usuario.
:::

## Descripción

Instalarás WordPress de forma local usando AMPPS, configurando la base de datos y verificando el correcto funcionamiento del sitio. El objetivo es comprender la instalación técnica y los primeros pasos de inicialización del CMS.

## Objetivos

- Poner en marcha los servicios que necesita un CMS: servidor web y servidor de bases de datos.
- Crear la base de datos y el usuario con los que trabajará WordPress.
- Completar la instalación de WordPress y acceder a su panel de administración.
- Comprobar que la instalación ha quedado como se pedía.

## Requisitos

Sustituye `nomAlumno` por tu nombre en todos los identificadores.

1. Iniciar los servicios de **Apache** y **MySQL** desde AMPPS.
2. Crear una base de datos desde el panel de AMPPS con estos datos:

   | Dato | Valor |
   |:-----|:------|
   | Nombre de la base de datos | `bd_nomAlumno` |
   | Usuario | `bdUser_nomAlumno` |
   | Contraseña | `bdPass_nomAlumno` |

3. Usar el instalador automático de WordPress.
4. Configurar el usuario administrador de WordPress y el nombre del sitio:

   | Dato | Valor |
   |:-----|:------|
   | Nombre del sitio | `wp_nomAlumno` |
   | Usuario administrador de WordPress | `wpUser_nomAlumno` |
   | Contraseña del administrador | `wpPass_nomAlumno` |

5. Verificar el acceso al panel de administración de WordPress y mostrar la configuración de la base de datos en el fichero `wp-config.php`.

::: warning-box Contraseñas de práctica
Las contraseñas de esta práctica siguen un patrón fijo para poder corregirla. En una instalación real nunca se usan contraseñas predecibles.
:::

## Entregable

Dentro del manual de usuario:

- **Punto 1. Instalación de WordPress sobre AMPPS en Windows.**

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Base de datos del CMS**<br>CE 2c | La base de datos o su usuario no existen, o no siguen los nombres pedidos. | Base de datos, usuario y contraseña creados con los nombres pedidos. | Explica para qué necesita WordPress la base de datos y por qué se le da un usuario propio. | El punto del manual permite a otra persona repetir la creación sin ayuda, con capturas que muestran cada paso. |
| **Instalación de WordPress**<br>CE 2c | La instalación no termina, o el sitio o el administrador no tienen los nombres pedidos. | WordPress instalado con el nombre de sitio y la cuenta de administración pedidos. | Justifica las opciones elegidas en el instalador y qué hace cada una. | La instalación se explica como un procedimiento ordenado y reutilizable, coherente con el punto anterior. |
| **Verificación del funcionamiento**<br>CE 2g | No se comprueba el acceso, o `wp-config.php` no coincide con la base de datos creada. | Se accede al panel y se muestra en `wp-config.php` la base de datos, el usuario y la contraseña. | Explica qué demuestra cada comprobación y qué fallaría si un dato fuera incorrecto. | Las comprobaciones quedan recogidas en el manual como lista de verificación para futuras instalaciones. |

---

**Siguiente práctica:** [P2.2 Uso básico de WordPress →](./2-uso-basico-wordpress)
