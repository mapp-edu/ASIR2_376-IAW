---
layout: doc
title: P5.4 — Formularios con PHP
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P5.4 — Formularios con PHP

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP5 · RA5.
- **Criterios de evaluación:** 5d, 5e, 5f.
- **Contenidos de apoyo:** temas [3. Funciones](../contenidos/3-funciones) y [5. Formularios](../contenidos/5-formularios).
- **Entrega:** un archivo `.zip` con los archivos PHP.
:::

## Descripción

Cuatro pequeñas aplicaciones web en las que el usuario introduce datos en un formulario y PHP los valida y los procesa.

## Normas

- Usa solo las funciones y estructuras vistas en clase o indicadas en el enunciado.
- Comenta los bloques más relevantes del código.
- Valida siempre los datos en el servidor y escapa lo que muestres con `htmlspecialchars()`.
- Debes poder explicar cualquier parte de tu código: el profesorado puede pedirte que lo hagas.

## Ejercicios

### Ejercicio 1. Cuadrícula de números

Formulario que pide un número entero entre 1 y 100 y tiene un botón **Mostrar cuadrícula**.

- Si el número no está en el rango, se vuelve a mostrar el formulario con el valor escrito y un mensaje en rojo.
- Si es válido, se muestra una tabla con los números del 1 al indicado, ocho por fila. Las celdas de los múltiplos de 5 se resaltan.
- El formulario y el procesado están en el mismo archivo.

### Ejercicio 2. Contador de vocales

Formulario con método POST que pide una frase y muestra cuántas veces aparece cada vocal, sin distinguir mayúsculas de minúsculas ni vocales con tilde (`á` cuenta como `a`). Si la frase está vacía, se muestra un aviso.

### Ejercicio 3. Calculadora de perímetros

Página con un grupo de botones de opción para elegir la figura (cuadrado, rectángulo o círculo) y los campos numéricos *Lado*, *Base*, *Altura* y *Radio*.

- Se usan solo los campos que necesita la figura elegida, y deben contener números positivos.
- Los perímetros se calculan con las funciones `perimetroCuadrado`, `perimetroRectangulo` y `perimetroCirculo`, definidas en un archivo aparte `geometria.php`.
- El resultado se muestra con dos decimales.

### Ejercicio 4. Palabras de una frase

Formulario con método GET que recoge una frase y muestra:

- El número de palabras.
- La palabra más corta y la más larga. Si hay empate, cualquiera de ellas.
- Las palabras en orden alfabético, sin repetir.

Para separar las palabras puedes usar `explode()`; ten en cuenta que puede haber varios espacios seguidos.

## Entregable

Un archivo `.zip` con los archivos de los cuatro ejercicios.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Formularios y validación**<br>CE 5f | Algún formulario no envía los datos o no valida lo que recibe. | Los cuatro formularios envían y validan los datos en el servidor con el método pedido, y escapan lo que muestran. | Justifica el método de envío de cada ejercicio y qué valida y por qué. | Los formularios conservan los valores escritos y los mensajes de error orientan al usuario. |
| **Procesamiento de los datos**<br>CE 5d | Algún ejercicio da resultados incorrectos. | Los cuatro ejercicios dan el resultado correcto, también con datos vacíos, fuera de rango o con espacios de más. | Explica en los comentarios la lógica de cada ejercicio. | Las soluciones son claras y no repiten código. |
| **Funciones**<br>CE 5e | Las funciones de geometría no están en un archivo aparte o no se usan. | Funciones definidas en `geometria.php`, incluidas y usadas correctamente. | Las funciones tienen tipos declarados y devuelven su resultado sin imprimirlo. | Se usan funciones propias también en otros ejercicios para no repetir código. |

---

**Siguiente práctica:** [P5.5 Monitorización de procesos →](./5-monitorizacion-procesos)
