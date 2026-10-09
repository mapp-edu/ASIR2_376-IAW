---
layout: doc
title: P5.5 — Monitorización de procesos
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P5.5 — Monitorización de sistemas: control de procesos

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP5 · RA5.
- **Criterios de evaluación:** 5b, 5d, 5e, 5f.
- **Proyecto:** primera aproximación del [panel de control de procesos](./).
- **Entrega:** código PHP comentado y demostración de su funcionamiento.
:::

## Objetivos

1. Investigar y entender los mecanismos que PHP proporciona para llamar a comandos del sistema operativo anfitrión.
2. Realizar formularios o páginas web que permitan monitorizar un sistema determinado de forma remota.

## Descripción

Un **proceso** o **servicio** es un programa en ejecución en un sistema. Los procesos se pueden ejecutar, detener o reanudar. Una de las tareas de un administrador es controlar o monitorizar los procesos que hay en una máquina.

El objetivo de este trabajo es permitir al administrador de una empresa controlar «a distancia» los procesos que se ejecutan en el servidor y mandarles una señal: parada, arranque o muerte.

## Requisitos

En esta primera aproximación:

1. Obtener los procesos que se están ejecutando en el sistema haciendo uso de `tasklist` y volcar el resultado en un fichero. Debes averiguar cómo se lanzan comandos a la terminal desde PHP.
2. Leer desde PHP el fichero obtenido y mostrar en un formulario los procesos, cada uno junto a una casilla de verificación (*checkbox*) que permita seleccionarlos de forma individual.
3. Desde el formulario, el administrador podrá **detener**, **reanudar** o **matar** el proceso seleccionado.

::: tip-box Cómo probarlo
Abre el Bloc de notas y mátalo desde tu página, o ábrelo y detenlo para ver que se queda bloqueado.
:::

::: danger-box Ejecutar comandos desde una web es delicado
Lo que llega del formulario acaba formando parte de un comando del sistema. Nunca insertes en el comando un dato del usuario sin comprobarlo antes: valida que el identificador de proceso es un número y limita las acciones a las tres previstas.
:::

## Entregable

- Código PHP de la página, comentado.
- Demostración del funcionamiento: listado de procesos y las tres acciones sobre un proceso de prueba.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Ejecución de comandos del sistema**<br>CE 5e | No se ejecuta `tasklist` desde PHP o su salida no llega al fichero. | Ejecuta `tasklist` desde PHP y vuelca el resultado en un fichero. | Justifica la función de PHP elegida frente a las alternativas y cómo gestiona la salida. | El acceso al sistema está encapsulado en funciones propias, fáciles de reutilizar en las siguientes aproximaciones. |
| **Lectura y tratamiento del listado**<br>CE 5d | El fichero no se lee, o los procesos se muestran como texto sin separar. | Recorre el fichero y obtiene, para cada proceso, sus datos por separado. | Explica cómo trata las líneas de cabecera y los casos que no siguen el formato esperado. | El tratamiento es robusto ante cambios en la salida del comando y está comentado. |
| **Página generada desde PHP**<br>CE 5b | El HTML generado no es válido o no muestra los procesos. | PHP genera una página HTML correcta con la lista de procesos. | Explica qué parte se resuelve en el servidor y qué recibe el navegador. | La página es clara de leer y separa de forma ordenada el código PHP del marcado HTML. |
| **Formulario y acciones**<br>CE 5f | No se puede seleccionar un proceso, o las acciones no llegan al servidor. | Cada proceso tiene su casilla y funcionan las tres acciones: detener, reanudar y matar. | Justifica el método de envío y valida en el servidor lo recibido antes de ejecutar nada. | El formulario informa del resultado de cada acción y se comporta bien si no se selecciona nada. |

---

**Siguiente práctica:** [P5.6 Zona privada con sesiones y cookies →](./6-zona-privada)
