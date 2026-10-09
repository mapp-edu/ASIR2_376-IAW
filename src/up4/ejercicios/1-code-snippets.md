---
layout: doc
title: P4.1 — PHP en WordPress con Code Snippets
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P4.1 — Incorporar código PHP en WordPress

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP4 · RA7.
- **Criterios de evaluación:** 7c, 7d, 7e, 7f, 7g.
- **Proyecto:** [portal interno con WordPress](/up2/ejercicios/).
- **Punto de partida:** el sitio tal como quedó en la [P3.1](/up3/ejercicios/1-actualizaciones-copias).
- **Entrega:** punto 7 del manual de usuario.
:::

## Descripción

Añadirás funcionalidades personalizadas a WordPress mediante PHP usando el plugin **Code Snippets**. Con él se incorpora código PHP propio de forma segura, sin tocar los archivos del sistema de WordPress, y se comprueba su funcionamiento en el sitio.

## Objetivos

- Decidir qué funcionalidad nueva necesita el portal y cómo incorporarla.
- Identificar qué recursos de WordPress se ven afectados por el cambio.
- Escribir código PHP que cree, rellene y consulte una tabla propia.
- Verificar el resultado en el sitio y documentar lo que hace el código.

## Requisitos

1. Instalar y activar el plugin **Code Snippets**.
2. Crear una tabla dentro de la base de datos de WordPress que contenga información sobre **incidencias resueltas**. Como mínimo debe tener estos campos:
   - fecha y hora de la incidencia,
   - descripción,
   - quién la abrió,
   - cuándo fue resuelta.
3. Rellenar la tabla con 4 o 5 incidencias resueltas.
4. Crear un *snippet* PHP que muestre de forma vistosa las incidencias resueltas, ordenadas por fecha de la más actual a la más antigua.
5. Enlazar esta funcionalidad en WordPress, en la página **Mensajes → Incidencias resueltas** del portal.
6. Documentar brevemente qué hace cada fragmento de código.

::: warning-box No edites los archivos de WordPress
Todo el código se añade desde Code Snippets. Modificar directamente los archivos del núcleo o del tema hace que los cambios se pierdan en la siguiente actualización.
:::

## Entregable

Dentro del manual de usuario:

- **Punto 7. Instalación y uso del plugin Code Snippets.**

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Selección de la funcionalidad**<br>CE 7c | No queda claro qué funcionalidad se añade ni dónde se mostrará. | Se describe la funcionalidad que se incorpora y la página en la que se enlaza. | Justifica por qué se resuelve con código propio y no con un plugin o con contenido estático. | La funcionalidad encaja con el uso del portal definido en las prácticas anteriores. |
| **Recursos afectados**<br>CE 7d | No se identifica la tabla creada ni dónde se guarda el código. | Se indica la tabla, sus campos y los *snippets* que intervienen. | Explica el uso del prefijo de tablas de WordPress y por qué el código no va en los archivos del sistema. | El manual deja un inventario de lo añadido que permite deshacer el cambio. |
| **Código PHP**<br>CE 7e | La tabla no se crea, no tiene los campos mínimos o el listado no funciona. | Tabla creada con los campos mínimos, 4 o 5 incidencias insertadas y listado ordenado por fecha. | Justifica las funciones de WordPress utilizadas y el escapado de los datos al mostrarlos. | El código está organizado en *snippets* con una responsabilidad cada uno y nombres que se explican solos. |
| **Verificación**<br>CE 7f | No se muestra el resultado en el sitio, o el orden o los datos son incorrectos. | El listado se ve en la página enlazada, con los datos y el orden pedidos. | Comprueba también los casos límite: tabla vacía y ejecución repetida del *snippet* de inserción. | Las pruebas quedan descritas de forma que otra persona puede repetirlas. |
| **Documentación del código**<br>CE 7g | No se explica qué hace el código. | Cada fragmento va acompañado de una explicación breve de lo que hace. | La documentación explica las decisiones tomadas, además de lo que hace el código. | El punto del manual permite a otro administrador mantener o ampliar la funcionalidad. |
