---
layout: doc
title: P1.2 — Análisis de requerimientos y preparación del sistema
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P1.2 — Análisis de requerimientos y preparación del sistema

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP1 · RA1.
- **Criterios de evaluación:** 1a, 1b, 1g, 1i.
- **Contenidos de apoyo:** [Instalación de un servidor de aplicaciones web](../contenidos/5-instalacion-servidores), apartados 1 y 2.
- **Entrega:** documento de requerimientos y memoria de preparación en un único PDF.
:::

## Descripción

Una pequeña tienda de material deportivo quiere vender en línea. Calcula que tendrá unos 40 clientes conectados a la vez, que llegarán a 200 durante las rebajas, y un catálogo de unos 500 productos con fotografías. Quiere usar WordPress con WooCommerce.

Tu trabajo tiene dos partes: analizar qué necesita el servidor y dejar preparado el sistema operativo para instalarlo.

## Objetivos

- Identificar el software necesario y las tecnologías que intervienen.
- Traducir las necesidades del cliente en requisitos técnicos.
- Preparar un sistema operativo de servidor de forma segura.

## Requisitos

### Parte 1. Documento de requerimientos

1. Consulta los requisitos que publican WordPress y WooCommerce e indica la fuente (URL y fecha de consulta).
2. Elabora una tabla con los componentes necesarios (sistema operativo, servidor web, base de datos, lenguaje y extensiones) y la versión mínima y recomendada de cada uno.
3. Escribe al menos cinco requisitos funcionales y cinco no funcionales, clasificados como esenciales, deseables u opcionales.
4. Estima los recursos del servidor (CPU, memoria, almacenamiento) y justifica la estimación con los datos del enunciado.
5. Indica qué modalidad de alojamiento recomendarías (compartido, VPS, dedicado o IaaS) y por qué.
6. Enumera los requisitos de seguridad: cifrado, datos personales, copias de seguridad y accesos de administración.

### Parte 2. Preparación del sistema operativo

Sobre una máquina virtual con Ubuntu Server LTS:

1. Actualiza el sistema.
2. Asigna un nombre al servidor y una dirección IP fija.
3. Crea un usuario administrador distinto de `root` con permisos de `sudo`.
4. Activa el cortafuegos permitiendo solo SSH.
5. Configura SSH para que `root` no pueda iniciar sesión directamente.
6. Activa las actualizaciones de seguridad automáticas.
7. Comprueba cada paso: nombre, IP, cortafuegos, configuración de SSH.

## Entregable

Un PDF con tu nombre y el de la práctica, con dos apartados: el documento de requerimientos de la parte 1 y la memoria de la parte 2, con las órdenes, capturas y explicación de cada paso.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Software necesario**<br>CE 1a | Faltan componentes o no se indican versiones ni fuente. | Tabla completa de componentes y extensiones con versiones mínimas y recomendadas, y su fuente. | Justifica la elección de cada componente frente a alternativas. | La tabla es coherente con los requisitos y con la preparación del sistema realizada. |
| **Requerimientos y tecnologías**<br>CE 1b | Los requisitos son vagos, están mezclados o no se clasifican. | Al menos cinco requisitos funcionales y cinco no funcionales, clasificados, y una estimación de recursos. | La estimación de recursos y la modalidad de alojamiento se justifican con los datos del enunciado. | El documento podría presentarse al cliente: es claro, priorizado y sin contradicciones. |
| **Seguridad del sistema**<br>CE 1g | El cortafuegos o la configuración de SSH no están activos o no se comprueban. | Usuario administrador, cortafuegos, SSH sin `root` y actualizaciones automáticas configurados y comprobados. | Explica de qué protege cada medida. | Las medidas responden a los requisitos de seguridad recogidos en la parte 1. |
| **Documentación**<br>CE 1i | Faltan órdenes o capturas, o no se explica lo que se hace. | Cada paso tiene su orden, su captura y una explicación. | Las explicaciones dicen para qué sirve cada paso. | La memoria permitiría a otra persona preparar un servidor igual. |

---

**Siguiente práctica:** [P1.3 Instalación de Apache en Ubuntu →](./3-apache-ubuntu)
