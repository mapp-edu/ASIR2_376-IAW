---
layout: doc
title: UP5 — PHP, lenguaje de guiones de servidor
sidebar: true
outline: [2, 3]
aside: true
---

# 🐘 UP5 — Programación de documentos web con lenguajes de script de servidor (PHP)

PHP es el lenguaje de servidor sobre el que están construidos WordPress y buena parte de las aplicaciones web que administrarás. En esta unidad se aprende desde la sintaxis básica hasta lo necesario para construir una zona privada: formularios, cookies, sesiones y autenticación de usuarios.

::: info-box Ficha de la unidad
- **Resultado de aprendizaje:** RA5 — 25 % de la nota del módulo.
- **Duración prevista:** 25 horas.
- **Entorno de trabajo:** stack local (AMPPS o XAMPP) con PHP 8 y Visual Studio Code.
:::

## Resultado de aprendizaje

**RA5.** Generar documentos web utilizando lenguajes de guiones de servidor.

## Criterios de evaluación

| CE | Criterio de evaluación |
|:--:|:-----------------------|
| 5a | Se han identificado los lenguajes de guiones de servidor más relevantes. |
| 5b | Se ha reconocido la relación entre los lenguajes de guiones de servidor y los lenguajes de marcas utilizados en los clientes. |
| 5c | Se ha reconocido la sintaxis básica de un lenguaje de guiones concreto. |
| 5d | Se han utilizado estructuras de control del lenguaje. |
| 5e | Se han definido y utilizado funciones. |
| 5f | Se han utilizado formularios para introducir información. |
| 5g | Se han establecido y utilizado mecanismos para asegurar la persistencia de la información entre distintos documentos web relacionados. |
| 5h | Se ha identificado y asegurado a los usuarios que acceden al documento web. |
| 5i | Se ha verificado el aislamiento del entorno específico de cada usuario. |

## Contenidos de la unidad

| Tema | Qué vas a aprender | CE | Diapositivas |
|:-----|:-------------------|:--:|:------------:|
| [1. Introducción a PHP](./contenidos/1-introduccion-php) | Estructura de un script, variables, operadores, cadenas, constantes, funciones y ámbito de las variables. | 5b, 5c | [Ver](./diapositivas/1-introduccion-php) |
| [2. Expresiones y control de flujo](./contenidos/2-control-flujo) | Condicionales `if` y `switch`, y bucles `while`, `do…while` y `for`. | 5d | [Ver](./diapositivas/2-control-flujo) |
| [3. Funciones](./contenidos/3-funciones) | Funciones de usuario y funciones integradas de cadenas, matemáticas y de fecha. | 5e | [Ver](./diapositivas/3-funciones) |
| [4. Matrices (arrays)](./contenidos/4-matrices) | Arrays numéricos, asociativos y multidimensionales, y sus funciones. | 5c, 5d | [Ver](./diapositivas/4-matrices) |
| [5. Formularios](./contenidos/5-formularios) | Envío de datos con GET y POST, validación en el servidor y subida de archivos. | 5f | [Ver](./diapositivas/5-formularios) |
| [6. Cookies, sesiones y autenticación](./contenidos/6-cookies-sesiones) | Persistencia entre páginas, zonas privadas y almacenamiento seguro de contraseñas. | 5g, 5h, 5i | [Ver](./diapositivas/6-cookies-sesiones) |

## Prácticas

| Práctica | Qué se hace | CE |
|:---------|:------------|:--:|
| [P5.1 Ejercicios básicos de PHP](./ejercicios/1-ejercicios-basicos) | Siete programas cortos con variables, condicionales, bucles y arrays. | 5a, 5b, 5c, 5d |
| [P5.2 Bucles, arrays y funciones](./ejercicios/2-bucles-arrays-funciones) | Batería de ejercicios en tres bloques de dificultad creciente. | 5d, 5e |
| [P5.3 Envío de correos con PHP](./ejercicios/3-envio-correos) | Programa de consola que envía correos con copia, copia oculta y adjuntos a través de Gmail. | 5c, 5d, 5e, 5h |
| [P5.4 Formularios con PHP](./ejercicios/4-formularios) | Cuatro aplicaciones que validan y procesan datos de un formulario. | 5d, 5e, 5f |
| [P5.5 Monitorización de procesos](./ejercicios/5-monitorizacion-procesos) | Página web que lista los procesos del servidor y permite detenerlos, reanudarlos o matarlos. | 5b, 5d, 5e, 5f |
| [P5.6 Zona privada con sesiones y cookies](./ejercicios/6-zona-privada) | Acceso con usuario y contraseña a la página de procesos, con idioma elegido por el usuario. | 5f, 5g, 5h, 5i |

---

[Empezar por la introducción a PHP →](./contenidos/1-introduccion-php)
