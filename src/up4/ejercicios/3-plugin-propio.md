---
layout: doc
title: P4.3 — Incorporar funcionalidades con un plugin propio
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P4.3 — Incorporar funcionalidades con un plugin propio

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP4 · RA7.
- **Criterios de evaluación:** 7c, 7d, 7e, 7f, 7g.
- **Contenidos de apoyo:** [Adaptación de gestores de contenidos](../contenidos/1-adaptacion-cms), apartados de plugins propios, ganchos y *shortcodes*.
- **Punto de partida:** cualquier instalación de WordPress de las unidades anteriores.
- **Entrega:** memoria en PDF y el plugin comprimido en `.zip`.
:::

## Descripción

El departamento comercial quiere un formulario de contacto en la web y, además, un listado rápido en el panel de los mensajes recibidos. Combinarás un plugin existente con un plugin propio que complemente lo que el primero no hace.

## Objetivos

- Seleccionar las funcionalidades que hay que incorporar y decidir cuáles se programan.
- Identificar los recursos de WordPress afectados.
- Programar un plugin con ganchos, un *shortcode* y una página de administración.
- Verificar el funcionamiento y documentar los cambios.

## Requisitos

### Parte 1. Análisis

1. Revisa al menos dos plugins de formularios de contacto del repositorio oficial y elige uno. Justifica la elección con los criterios vistos en la [UP3](/up3/contenidos/1-administracion-cms#modulos-y-plugins).
2. Instala y configura el plugin elegido y publica una página *Contacto* con el formulario.
3. Indica qué funcionalidad **no** cubre el plugin y vas a programar tú, y qué recursos de WordPress (tablas, ganchos, pantallas) se verán afectados.

### Parte 2. Plugin propio

Crea el plugin `comercial-iaw` con:

4. Una cabecera completa: nombre, descripción, versión, autor y licencia.
5. Una protección contra la ejecución directa del archivo.
6. Un *shortcode* `[horario_comercial]` que muestre el horario de atención, con un atributo opcional para indicar el día.
7. Una acción enganchada a `wp_footer` o un filtro sobre `the_content` que añada el teléfono comercial a la página *Contacto*.
8. Una página en el panel de administración, visible solo para administradores y editores, con una tabla de los mensajes recibidos o, si el plugin de formularios no los guarda en la base de datos, con las últimas páginas publicadas y su autor. Usa `` y escapa los datos al mostrarlos.

### Parte 3. Verificación

9. Prueba el *shortcode* con y sin atributo, y en dos páginas distintas.
10. Comprueba con un usuario Autor que no ve la página de administración.
11. Activa el modo de depuración y comprueba que el plugin no genera avisos. Después, desactívalo.
12. Desactiva y vuelve a activar el plugin para comprobar que el sitio sigue funcionando.

## Entregable

1. **Memoria en PDF** con el análisis, el código comentado y las pruebas.
2. **El plugin** comprimido en `.zip`, listo para instalarse desde **Plugins → Añadir nuevo → Subir plugin**.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Selección de funcionalidades**<br>CE 7c | No se comparan plugins o no se indica qué se va a programar. | Dos plugins revisados, uno elegido e instalado, y la funcionalidad propia definida. | Justifica la elección del plugin y por qué el resto se programa. | El reparto entre plugin existente y código propio evita duplicar funciones. |
| **Recursos afectados**<br>CE 7d | No se identifican tablas, ganchos ni pantallas. | Se enumeran las tablas, ganchos y pantallas que intervienen. | Explica cómo afecta el plugin a cada recurso. | La lista permite deshacer por completo el cambio. |
| **Código del plugin**<br>CE 7e | El plugin no se activa o falta alguna de sus partes. | Cabecera, protección, *shortcode*, acción o filtro y página de administración funcionando. | Justifica los ganchos y funciones de WordPress usados, la capacidad elegida y el escapado. | El código usa prefijos, está comentado y cada función hace una sola cosa. |
| **Verificación**<br>CE 7f | No se muestran pruebas. | Las cuatro pruebas de la parte 3 realizadas y documentadas. | Explica qué demuestra cada prueba y qué fallaría sin cada protección. | Las pruebas se pueden repetir siguiendo la memoria. |
| **Documentación**<br>CE 7g | No se explica el código. | El código está comentado y la memoria explica cada parte. | La documentación incluye cómo instalar, usar y desinstalar el plugin. | Otra persona podría mantener el plugin solo con la memoria. |
