---
layout: doc
title: P6.4 — Proyecto integrador. Gestor de tareas colaborativo
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P6.4 — Proyecto integrador: gestor de tareas colaborativo

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidades:** UP4, UP5, UP6 y UP7 · RA4, RA5, RA6 y RA7.
- **Criterios de evaluación:** 4d, 5f, 5h, 5i, 6e, 6f, 6g, 7e.
- **Entrega:** informe en PDF, código en `.zip`, URL del sitio y vídeo explicativo.
:::

## Descripción

Este proyecto reúne lo trabajado en el segundo bloque del módulo. Desarrollarás una aplicación web en PHP y MySQL para que un equipo gestione sus tareas de forma colaborativa, la integrarás con una aplicación de ofimática web y la publicarás dentro de un sitio WordPress.

## Qué debe hacer la aplicación

### Pantallas

| Pantalla | Contenido |
|:---------|:----------|
| **Cabecera común** | Logotipo y nombre de la aplicación, y navegación: Inicio, Todas las tareas, Mis tareas, Nueva tarea, Perfil y Cerrar sesión. |
| **Todas las tareas** | Lista con título, descripción breve, fecha de vencimiento, estado (pendiente o completada), usuario creador y usuario asignado. Los botones **Editar** y **Borrar** solo aparecen si el usuario conectado creó la tarea. |
| **Mis tareas** | Las tareas asignadas al usuario conectado, con un botón **Marcar como completada**. |
| **Nueva tarea** | Formulario con título, descripción, fecha de vencimiento y usuario asignado, elegido entre los usuarios existentes. |
| **Perfil** | Nombre, correo y rol del usuario, cambio de contraseña y acceso a sus tareas. |

### Integración con ofimática web

Al crear una tarea, la aplicación ofrece añadirla al calendario del usuario. Elige **una** de estas opciones y justifica la elección:

- Un enlace que abra el calendario de Google o de Outlook con el evento ya relleno.
- La descarga de un archivo `.ics` con el evento, que se pueda importar en cualquier calendario, incluido el de Nextcloud.
- La creación del evento mediante la API de Google Calendar o la de CalDAV de Nextcloud.

### Avisos

La aplicación avisa al usuario, al entrar, de las tareas que vencen en los próximos dos días.

## Fases

### Fase 1. Planificación

Elabora un documento con:

1. El propósito de la aplicación.
2. Un resumen de aplicaciones de ofimática web y de gestión de tareas existentes (por ejemplo, Google Tasks, Microsoft To Do, Nextcloud Deck, Trello) y qué ideas tomas de ellas.
3. Los requisitos funcionales y no funcionales.
4. La infraestructura necesaria, un calendario de desarrollo y cómo se harán el mantenimiento y el soporte.
5. El modelo de datos: tablas, campos y relaciones, con un diagrama.

### Fase 2. Entorno

6. Servidor web, PHP y MariaDB o MySQL instalados y configurados, con un usuario de base de datos propio para la aplicación.

### Fase 3. Desarrollo

7. Creación de las tablas desde PHP.
8. Al menos cuatro usuarios de prueba, con dos roles: **administrador**, que puede borrar cualquier tarea y gestionar usuarios, y **colaborador**.
9. Autenticación con contraseñas cifradas con `password_hash()` y sesiones. Ninguna página privada es accesible sin iniciar sesión.
10. Alta, edición, borrado y cambio de estado de tareas, con validación de los formularios y gestión de errores.
11. La integración con el calendario y los avisos de vencimiento.

### Fase 4. Integración en WordPress

12. Publica la aplicación dentro de un sitio WordPress que sirva de portada: una página con la presentación de la aplicación y el acceso a ella, con el aspecto del tema del sitio. Adapta el tema con un tema hijo o un plugin propio si lo necesitas.

### Fase 5. Verificación y documentación

13. Pruebas de funcionamiento, de seguridad (accesos sin sesión, un usuario intentando editar una tarea ajena, inyección de SQL en los formularios) y de rendimiento.
14. Informe final con todas las fases, el código documentado y un manual de usuario.
15. Vídeo, con tu voz, mostrando la aplicación en funcionamiento con dos usuarios distintos.

## Entregable

1. **Informe final** en PDF.
2. **Código** en `.zip`, con la exportación SQL de la base de datos.
3. **URL** del sitio publicado.
4. **Vídeo** explicativo.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Integración con ofimática web**<br>CE 4d | No hay integración con el calendario. | La tarea se añade al calendario con la opción elegida. | Justifica la opción elegida frente a las otras dos. | La integración funciona con el calendario de la intranet (Nextcloud) además de con uno externo. |
| **Formularios**<br>CE 5f | Algún formulario no funciona o no valida los datos. | Todos los formularios funcionan y validan en el servidor, conservando los datos si hay errores. | Explica la validación de cada campo. | Los formularios son cómodos de usar y los mensajes orientan al usuario. |
| **Autenticación y control de acceso**<br>CE 5h | Se puede entrar sin contraseña o las contraseñas están en texto claro. | Inicio de sesión con contraseñas cifradas, dos roles y páginas privadas protegidas. | Explica cómo se comprueba la sesión y el rol en cada página. | La comprobación de acceso está centralizada y se reutiliza en todas las páginas. |
| **Aislamiento entre usuarios**<br>CE 5i | Un usuario puede editar o borrar tareas ajenas. | Cada usuario solo edita y borra sus tareas, salvo el administrador, comprobado también en el servidor. | Demuestra con dos usuarios a la vez que las sesiones no se mezclan. | Las pruebas incluyen intentos de saltarse la restricción modificando la URL o el formulario. |
| **Datos de la aplicación**<br>CE 6e | Falta alguna operación sobre las tareas o el modelo de datos no la permite. | Alta, consulta, edición, borrado y cambio de estado de tareas funcionando sobre el modelo de datos diseñado. | Justifica el modelo de datos y las consultas de cada pantalla. | El modelo y las consultas permiten ampliar la aplicación sin rehacerla. |
| **Seguridad en el acceso a los datos**<br>CE 6f | Hay consultas con datos del usuario concatenados o salida sin escapar. | Sentencias preparadas, salida escapada y usuario de base de datos propio. | Explica cada medida y la prueba de inyección de SQL realizada. | Los errores se registran sin mostrar detalles técnicos y las credenciales están fuera del código público. |
| **Verificación**<br>CE 6g | No se documentan pruebas. | Pruebas de funcionamiento, seguridad y rendimiento documentadas. | Explica qué demuestra cada prueba. | Las pruebas se pueden repetir y cubren los casos límite. |
| **Integración en el CMS**<br>CE 7e | La aplicación no se publica en WordPress. | La aplicación se publica en una página del sitio WordPress. | Explica cómo se ha integrado y qué se ha adaptado del tema. | La aplicación y el sitio tienen un aspecto coherente y la adaptación sobrevive a las actualizaciones. |
