---
layout: doc
title: P4.2 — Modificar la apariencia con un tema hijo
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P4.2 — Modificar la apariencia de un CMS con un tema hijo

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP4 · RA7.
- **Criterios de evaluación:** 7a, 7b, 7e, 7g.
- **Contenidos de apoyo:** [Adaptación de gestores de contenidos](../contenidos/1-adaptacion-cms), apartados de estructura de directorios y modificación de la apariencia.
- **Punto de partida:** cualquier instalación de WordPress de las unidades anteriores.
- **Entrega:** memoria en PDF y el tema hijo comprimido en `.zip`.
:::

## Descripción

La empresa quiere que su web tenga la imagen corporativa definida por el departamento de comunicación, sin perder los cambios cada vez que se actualice el tema. Adaptarás la apariencia de WordPress, primero con las herramientas del panel y después con un tema hijo.

## Objetivos

- Identificar la estructura de directorios del CMS y la naturaleza de sus archivos.
- Modificar la apariencia sin tocar el núcleo ni el tema original.
- Documentar los cambios realizados.

## Requisitos

### Parte 1. Reconocer la estructura

1. Elabora una tabla con los directorios y archivos principales de tu instalación de WordPress, su naturaleza (código, estilos, imágenes, configuración, traducciones) y si se deben modificar o no.
2. Localiza la carpeta del tema activo y explica qué archivos contiene y para qué sirve cada uno.

### Parte 2. Apariencia desde el panel

3. Con el editor del sitio o el personalizador, cambia la paleta de colores y la tipografía para que se ajusten a esta imagen corporativa: azul marino `#1c375b` para la cabecera y el pie, naranja `#ed6e51` para los botones y una tipografía sin remates.
4. Añade CSS adicional que modifique al menos dos elementos que no se puedan cambiar desde las opciones del tema. Explica cómo has encontrado sus selectores.

### Parte 3. Tema hijo

5. Crea un tema hijo del tema activo, con su `style.css` y, si el tema padre lo necesita, `functions.php`.
6. Lleva al tema hijo las reglas CSS de la parte 2 y elimina el CSS adicional del panel.
7. Modifica en el tema hijo una plantilla o parte de plantilla del padre (por ejemplo, el pie) para añadir el nombre de la empresa y el año actual, generado con PHP o con un bloque.
8. Activa el tema hijo y comprueba que el sitio mantiene el aspecto.
9. Actualiza o reinstala el tema padre y demuestra que los cambios se conservan.

## Entregable

1. **Memoria en PDF** con la tabla de la parte 1, capturas del antes y el después, y el código de cada archivo del tema hijo explicado.
2. **El tema hijo** comprimido en `.zip`, listo para instalarse desde **Apariencia → Temas → Añadir nuevo → Subir tema**.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Estructura de directorios**<br>CE 7a | La tabla está incompleta o confunde ubicaciones. | Tabla con los directorios y archivos principales, y la carpeta del tema descrita. | Justifica por qué unos directorios se modifican y otros no. | La tabla sirve de referencia para localizar dónde hacer cualquier adaptación. |
| **Naturaleza de los archivos**<br>CE 7b | No se indica la naturaleza de los archivos. | Cada archivo o directorio de la tabla tiene su naturaleza y su función. | Explica qué archivos del tema intervienen en el cambio de la parte 3. | Relaciona la naturaleza de cada archivo con cómo le afectan las actualizaciones. |
| **Modificación de la apariencia**<br>CE 7e | El tema hijo no funciona o los cambios se hacen en el tema padre. | Paleta, tipografía y CSS aplicados, tema hijo activo con el CSS y la plantilla modificada. | Explica la cabecera de `style.css`, cómo hereda el tema hijo y cómo se sustituye una plantilla. | Se demuestra que los cambios sobreviven a la actualización del tema padre. |
| **Documentación de los cambios**<br>CE 7g | No se explica el código ni se ven los cambios. | Capturas del antes y el después, y código de cada archivo explicado. | La documentación indica qué archivo controla cada cambio visible. | Con la memoria y el `.zip`, otra persona puede instalar y mantener el tema hijo. |

---

**Siguiente práctica:** [P4.3 Incorporar funcionalidades con un plugin propio →](./3-plugin-propio)
