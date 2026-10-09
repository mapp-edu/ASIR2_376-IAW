---
layout: doc
title: P5.2 — Bucles, arrays y funciones
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P5.2 — Bucles, arrays y funciones

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP5 · RA5.
- **Criterios de evaluación:** 5d, 5e.
- **Contenidos de apoyo:** temas [2. Expresiones y control de flujo](../contenidos/2-control-flujo), [3. Funciones](../contenidos/3-funciones) y [4. Matrices](../contenidos/4-matrices).
- **Entrega:** un archivo `.zip` con los archivos PHP.
:::

## Descripción

Una batería de ejercicios en tres bloques de dificultad creciente. Los datos de partida están en variables o arrays al principio de cada archivo.

## Normas

- Un archivo por ejercicio, con el nombre `b1-e1.php`, `b1-e2.php`…
- Comenta el código.
- En el bloque 3, las funciones van en un archivo `funciones.php` que se incluye con `require_once`.

## Bloque 1. Bucles

1. Reescribe este bucle `for` como `while` y como `do…while`, y comprueba que los tres muestran lo mismo:

   ```php
   for ($i = 3; $i <= 30; $i += 3) {
       echo $i . " ";
   }
   ```

2. Muestra los números del 500 al 400 de 10 en 10, hacia atrás.
3. Muestra los números del 1 al 50 saltándote los múltiplos de 4. Usa `continue`.
4. Calcula el factorial del número guardado en `$n`. Si `$n` es negativo, muestra un aviso.
5. Indica cuántas cifras tiene el número entero positivo guardado en `$n`, sin convertirlo en texto.
6. Indica si el número guardado en `$n` es primo.

## Bloque 2. Arrays

7. Recorre un array de números y muestra el cuadrado de cada uno hasta encontrar el primer número negativo. Usa `break`.
8. Dado un array de 10 números, muestra la media de los positivos, la media de los negativos y cuántos ceros hay.
9. Dado un array asociativo de empleados con su sueldo, muestra en una tabla HTML los que cobran más de 1500 €, el sueldo total y el sueldo máximo con el nombre de quien lo cobra.
10. Dado un array multidimensional de facturas, cada una con código de artículo, litros vendidos y precio por litro, muestra la facturación total, los litros vendidos del artículo `A1` y cuántas facturas superan los 600 €.
11. Dado un array de alumnos con su edad y su altura, muestra la media de cada dato, cuántos son mayores de edad y cuántos miden más de 1,75 m.

## Bloque 3. Funciones

12. Escribe la función `esPar(int $n): bool` y úsala para mostrar los pares de un array.
13. Escribe la función `calificacion(float $nota): string` que devuelva *Insuficiente*, *Suficiente*, *Bien*, *Notable* o *Sobresaliente*, y úsala con la media de un array de notas.
14. Escribe la función `salarioSemanal(int $horas, float $precio = 12): float`. Las 40 primeras horas se pagan al precio indicado y las extras, un 30 % más caras.
15. Escribe la función `precioFinal(float $base, string $iva, string $promo): float`, donde `$iva` puede ser `general` (21 %), `reducido` (10 %) o `superreducido` (4 %), y `$promo`, `ninguna`, `mitad` (50 % de descuento sobre la base) o `menos5` (5 € de descuento sobre la base). Muestra el desglose: base, descuento, IVA y total.
16. Escribe la función `ordenarDescendente(array &$numeros): void`, que ordene el array recibido de mayor a menor **sin** usar funciones de ordenación de PHP, y demuestra que modifica el array original.

## Entregable

Un archivo `.zip` con todos los archivos PHP y `funciones.php`.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Bucles**<br>CE 5d | Algún ejercicio del bloque 1 no funciona o no termina. | Los seis ejercicios del bloque 1 dan el resultado correcto, también en los casos límite. | Justifica en los comentarios el tipo de bucle elegido y el uso de `break` y `continue`. | Las soluciones son sencillas y eficientes, por ejemplo al comprobar si un número es primo. |
| **Arrays**<br>CE 5d | Algún ejercicio del bloque 2 no funciona o no recorre bien el array. | Los cinco ejercicios del bloque 2 funcionan con los arrays pedidos. | Explica la estructura de cada array y cómo se recorre. | Los resultados se presentan en HTML claro y bien estructurado. |
| **Funciones**<br>CE 5e | Faltan funciones o no se usan desde otro archivo. | Las cinco funciones del bloque 3, con sus tipos, en `funciones.php`, incluidas con `require_once` y usadas correctamente. | Explica los tipos, el valor por defecto y el paso por referencia del ejercicio 16. | Las funciones son reutilizables: no imprimen nada, devuelven su resultado. |

---

**Siguiente práctica:** [P5.3 Envío de correos con PHP →](./3-envio-correos)
