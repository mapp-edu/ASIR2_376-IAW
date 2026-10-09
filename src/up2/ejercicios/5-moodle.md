---
layout: doc
title: P2.5 — Instalación de Moodle
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P2.5 — Instalación y configuración de Moodle

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP2 · RA2.
- **Criterios de evaluación:** 2b, 2c, 2e, 2g.
- **Contenidos de apoyo:** [Gestores de contenidos](../contenidos/1-gestores-contenidos).
- **Punto de partida:** el servidor Ubuntu con Apache, PHP y MariaDB de la [UP1](/up1/ejercicios/).
- **Entrega:** memoria en PDF.
:::

## Descripción

Un centro de formación de la empresa quiere su propia plataforma de cursos. Instalarás Moodle, un gestor de contenidos especializado en el aprendizaje, en tu servidor Ubuntu y lo dejarás preparado para su primer curso.

## Objetivos

- Reconocer en qué se diferencia un LMS de un CMS generalista.
- Instalar un gestor de contenidos con requisitos propios, como un directorio de datos fuera de la carpeta pública.
- Realizar la configuración inicial de la plataforma.

## Requisitos

1. Consulta los requisitos de la última versión estable de Moodle e instala las extensiones de PHP que falten. Ajusta `max_input_vars` en `php.ini` al valor que pide Moodle.
2. Crea la base de datos `moodle` y su usuario.
3. Descarga Moodle y colócalo en `/var/www/moodle`.
4. Crea el directorio de datos `/var/moodledata`, **fuera** de la carpeta pública, con el propietario adecuado.
5. Crea un *virtual host* `moodle.empresa.local`.
6. Completa la instalación desde el navegador y crea la cuenta de administración.
7. Configura el nombre del sitio, el idioma español y la zona horaria.
8. Activa la tarea programada (*cron*) de Moodle para que se ejecute cada minuto.
9. Crea una categoría, un curso con dos secciones, un recurso y una actividad, y matricula a un usuario de prueba como estudiante.
10. Accede con el usuario de prueba y comprueba lo que ve.

::: tip-box Por qué el directorio de datos va fuera
Moodle guarda en `moodledata` los archivos que suben los usuarios. Si estuviera dentro de la carpeta pública, cualquiera podría descargarlos escribiendo su URL, saltándose los permisos de la plataforma.
:::

## Entregable

Un PDF con tu nombre y el de la práctica, con las órdenes, capturas y explicación de cada paso. Incluye un apartado final que compare Moodle con WordPress: para qué sirve cada uno, cómo organizan los contenidos y cómo gestionan los usuarios.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Clasificación del gestor**<br>CE 2b | No se compara Moodle con WordPress, o la comparación es una lista sin relación con el uso. | La comparación cubre finalidad, organización de contenidos y gestión de usuarios. | Justifica en qué situaciones elegiría cada uno. | Aplica la comparación al encargo del centro de formación. |
| **Instalación**<br>CE 2c | Moodle no termina de instalarse o `moodledata` está dentro de la carpeta pública. | Requisitos cumplidos, base de datos, archivos, directorio de datos y *virtual host* listos, e instalación completada. | Explica los requisitos propios de Moodle: `max_input_vars`, directorio de datos y *cron*. | La instalación se documenta como un procedimiento reutilizable. |
| **Configuración inicial**<br>CE 2e | Falta la configuración del sitio o el curso de prueba. | Sitio configurado, *cron* activo y curso con recurso, actividad y estudiante matriculado. | Justifica la estructura de categorías y secciones elegida. | El curso de prueba está pensado como modelo para los cursos del centro. |
| **Pruebas de funcionamiento**<br>CE 2g | No se comprueba el acceso como estudiante. | Se accede como estudiante y se comprueba lo que ve, y que el *cron* se ejecuta. | Explica las diferencias entre lo que ven el administrador y el estudiante. | Revisa los avisos de la página de notificaciones del administrador y resuelve los que dependen del servidor. |

---

**Siguiente práctica:** [P2.6 Joomla en un servidor remoto →](./6-joomla-remoto)
