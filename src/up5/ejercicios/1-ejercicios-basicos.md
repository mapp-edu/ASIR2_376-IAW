---
layout: doc
title: P5.1 — Ejercicios básicos de PHP
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P5.1 — Ejercicios básicos de PHP

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP5 · RA5.
- **Criterios de evaluación:** 5a, 5b, 5c, 5d.
- **Contenidos de apoyo:** temas [1. Introducción a PHP](../contenidos/1-introduccion-php) y [2. Expresiones y control de flujo](../contenidos/2-control-flujo).
- **Entrega:** un archivo `.zip` con un PDF y un archivo PHP por ejercicio.
:::

## Descripción

Siete programas cortos para practicar la sintaxis de PHP, las estructuras de control y la generación de HTML desde el servidor. En todos, los datos de partida están en variables al principio del archivo: cambia su valor para probar distintos casos.

## Normas para todos los ejercicios

- Un archivo por ejercicio: `ejercicio1.php`, `ejercicio2.php`…
- Cada archivo genera una página HTML completa y válida.
- Comenta el código: qué hace cada bloque y por qué.
- Prueba cada ejercicio con al menos tres valores distintos, incluidos los casos límite.

## Ejercicios

### Ejercicio 0. Los lenguajes de servidor

Antes de programar, elabora una tabla con cinco lenguajes de servidor relevantes (por ejemplo PHP, Python, Java, C# y JavaScript con Node.js) que indique, para cada uno: cómo se ejecuta en el servidor, un *framework* destacado, dos aplicaciones o sitios conocidos que lo usen y su cuota de uso aproximada en la web, citando la fuente. Termina con un párrafo que explique por qué PHP es el lenguaje de los CMS que se implantan en el módulo. Entrégala en un archivo `ejercicio0.pdf`.

### Ejercicio 1. Múltiplo de tres

A partir de un número entero guardado en `$numero`, muestra dentro de un `<h2>` si es múltiplo de 3 o no.

> Con `$numero = 12`: «12 es múltiplo de 3».

### Ejercicio 2. Calificación con texto

A partir de una nota entera de 0 a 10 en `$nota`, muestra en un párrafo en negrita su calificación: *Insuficiente* (0–4), *Suficiente* (5), *Bien* (6), *Notable* (7–8) o *Sobresaliente* (9–10). Si la nota está fuera del rango, muestra un aviso en rojo. Usa `switch` o `match`.

### Ejercicio 3. Saludo según la hora

A partir de la hora actual del servidor, muestra «Buenos días» de 6 a 13, «Buenas tardes» de 14 a 20 y «Buenas noches» el resto. Muestra también la fecha y la hora con el formato `dd/mm/aaaa – hh:mm`.

### Ejercicio 4. Fila de números

Genera una tabla HTML con borde y una sola fila que contenga los números desde 1 hasta el valor de `$limite`. Las celdas de los números pares deben tener otro color de fondo.

### Ejercicio 5. Tablas de multiplicar

Genera una tabla HTML por cada número del array `$tablas` (por ejemplo `[3, 7]`), con las operaciones del 1 al 10 y su resultado, centrados en cada celda.

### Ejercicio 6. Lista de la compra

Guarda en un array asociativo estos productos con su precio: *Arroz* 1,10; *Aceite* 8,95; *Lentejas* 1,35; *Café* 4,20; *Yogures* 2,15. Muéstralos en una lista ordenada (`<ol>`) con el precio en formato `1,10 €` y, debajo, el total de la compra.

### Ejercicio 7. Estadística de temperaturas

Guarda en un array las temperaturas máximas de los siete días de una semana. Con un bucle `foreach`, calcula la media, la máxima y la mínima sin usar las funciones `max`, `min` ni `array_sum`. Muestra la media en un `<h1>` de color azul si es menor de 20 °C y rojo si es igual o mayor.

## Entregable

Un archivo `.zip` con `ejercicio0.pdf` y los siete archivos PHP.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Lenguajes de servidor**<br>CE 5a | La tabla está incompleta o no cita fuentes. | Tabla con los cinco lenguajes y todos los datos pedidos, con su fuente. | El párrafo final justifica el uso de PHP con datos de la tabla. | La tabla compara los lenguajes con criterios útiles para elegir uno en un proyecto real. |
| **PHP y HTML**<br>CE 5b | Las páginas generadas no son HTML válido o el código PHP se ve en el navegador. | Los siete ejercicios generan páginas HTML completas con los elementos pedidos. | Los comentarios explican qué genera PHP y qué recibe el navegador. | El HTML generado está bien estructurado y se separa con claridad del código PHP. |
| **Sintaxis del lenguaje**<br>CE 5c | Hay errores de sintaxis o avisos de PHP. | Los siete ejercicios funcionan sin errores ni avisos, con variables, operadores y arrays bien usados. | Los comentarios justifican el tipo de dato y el operador elegidos en cada caso. | El código es legible: nombres de variables claros, sangrado coherente. |
| **Estructuras de control**<br>CE 5d | Algún ejercicio no da el resultado correcto en los casos de prueba. | Todos los ejercicios dan el resultado correcto, también en los casos límite. | Justifica la estructura elegida (`if`, `switch`, `match`, `for`, `foreach`) en cada ejercicio. | Las soluciones son sencillas y no repiten código innecesariamente. |

---

**Siguiente práctica:** [P5.2 Bucles, arrays y funciones →](./2-bucles-arrays-funciones)
