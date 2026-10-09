---
layout: doc
title: UP1 — Servidores de aplicaciones web
sidebar: true
outline: [2, 3]
aside: true
---

# 🖥️ UP1 — Conceptos sobre aplicaciones web e instalación de servidores de aplicaciones web

Antes de implantar una aplicación web hay que entender cómo se reparte el trabajo entre el navegador y el servidor, qué piezas de software intervienen y cómo se montan en un entorno de pruebas. Esta unidad presenta las arquitecturas web y deja preparado el entorno local con el que se trabajará el resto del curso.

::: info-box Ficha de la unidad
- **Resultado de aprendizaje:** RA1 — 10 % de la nota del módulo.
- **Duración prevista:** 20 horas.
:::

## Resultado de aprendizaje

**RA1.** Preparar el entorno de desarrollo y los servicios de aplicaciones web instalando e integrando las funcionalidades necesarias.

## Criterios de evaluación

| CE | Criterio de evaluación |
|:--:|:-----------------------|
| 1a | Se ha identificado el software necesario para su funcionamiento. |
| 1b | Se han identificado las diferentes tecnologías empleadas. |
| 1c | Se han instalado y configurado servidores web y de bases de datos. |
| 1d | Se han reconocido las posibilidades de procesamiento en los entornos cliente y servidor. |
| 1e | Se han añadido y configurado los componentes y módulos necesarios para el procesamiento de código en el servidor. |
| 1f | Se ha instalado y configurado el acceso a bases de datos. |
| 1g | Se ha establecido y verificado la seguridad en los accesos al servidor. |
| 1h | Se han utilizado plataformas integradas orientadas a la prueba y desarrollo de aplicaciones web. |
| 1i | Se han documentado los procedimientos realizados. |

## Contenidos de la unidad

| Tema | Qué vas a aprender |
|:-----|:-------------------|
| [1. Arquitecturas web](./contenidos/1-arquitecturas-web) | Modelo cliente/servidor, páginas estáticas y dinámicas, SPA, arquitectura de tres capas y patrón MVC. |
| [2. Herramientas y puesta en marcha](./contenidos/2-herramientas-entorno) | Servidor web, servidor de aplicaciones, lenguajes de servidor y preparación del entorno local. |
| [3. Tecnologías y entorno de desarrollo](./contenidos/3-tecnologias-desarrollo) | URL, métodos y códigos HTTP, modalidades de alojamiento, software servidor, lenguajes de cliente y servidor, y herramientas de desarrollo. |
| [4. Control de versiones con Git y GitHub](./contenidos/4-control-versiones-git) | Repositorios, confirmaciones, ramas, conflictos, repositorios remotos y *pull requests*. |
| [5. Instalación de un servidor de aplicaciones web](./contenidos/5-instalacion-servidores) | Análisis de requerimientos, preparación de Ubuntu Server, Apache, Nginx, MariaDB, PHP, pruebas, Docker y documentación. |

## Prácticas

| Práctica | Qué se hace | CE |
|:---------|:------------|:--:|
| [P1.1 Control de versiones con Git y GitHub](./ejercicios/1-git-github) | Llevar con Git la documentación de un servidor y colaborar en GitHub. | 1b, 1i |
| [P1.2 Análisis de requerimientos y preparación del sistema](./ejercicios/2-requerimientos-sistema) | Analizar lo que necesita una tienda en línea y preparar Ubuntu Server. | 1a, 1b, 1g, 1i |
| [P1.3 Instalación de Apache y PHP en Ubuntu](./ejercicios/3-apache-ubuntu) | Instalar el servidor web, publicar un sitio y añadir PHP. | 1c, 1e, 1g, 1i |
| [P1.4 Instalación de MariaDB en Ubuntu](./ejercicios/4-mariadb-ubuntu) | Completar el servidor LAMP con la base de datos y conectarla con PHP. | 1c, 1f, 1g, 1i |
| [P1.5 Entorno integrado con Docker Compose](./ejercicios/5-docker-compose) | Levantar el mismo entorno con contenedores y comparar el procesamiento en cliente y servidor. | 1d, 1h, 1i |

---

[Empezar por las arquitecturas web →](./contenidos/1-arquitecturas-web)
