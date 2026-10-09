---
layout: doc
title: UP6 — Acceso a bases de datos desde PHP
sidebar: true
outline: [2, 3]
aside: true
---

# 🗄️ UP6 — Acceso a bases de datos desde lenguajes de script de servidor

Casi todas las aplicaciones web guardan su información en una base de datos. En esta unidad se conecta PHP con MySQL/MariaDB mediante PDO para consultar datos, mostrarlos en una página y comprobar usuarios y contraseñas contra una tabla.

::: info-box Ficha de la unidad
- **Resultado de aprendizaje:** RA6 — 25 % de la nota del módulo.
- **Duración prevista:** 25 horas.
- **Entorno de trabajo:** stack local (AMPPS o XAMPP) con PHP 8, MySQL/MariaDB y phpMyAdmin.
- **Punto de partida:** los contenidos de PHP de la [UP5](/up5/).
:::

## Resultado de aprendizaje

**RA6.** Generar documentos web con acceso a bases de datos utilizando lenguajes de guiones de servidor.

## Criterios de evaluación

| CE | Criterio de evaluación |
|:--:|:-----------------------|
| 6a | Se han identificado los sistemas gestores de bases de datos más utilizados en entornos web. |
| 6b | Se ha verificado la integración de los sistemas gestores de bases de datos con el lenguaje de guiones de servidor. |
| 6c | Se ha configurado en el lenguaje de guiones la conexión para el acceso al sistema gestor de base de datos. |
| 6d | Se han creado bases de datos y tablas en el gestor utilizando el lenguaje de guiones. |
| 6e | Se ha obtenido y actualizado la información almacenada en bases de datos. |
| 6f | Se han aplicado criterios de seguridad en el acceso de los usuarios. |
| 6g | Se ha verificado el funcionamiento y el rendimiento del sistema. |

## Contenidos de la unidad

| Tema | Qué vas a aprender | CE | Diapositivas |
|:-----|:-------------------|:--:|:------------:|
| [1. Acceso a datos con PDO](./contenidos/1-acceso-datos-pdo) | Activar la extensión, conectar con MySQL, ejecutar consultas, mostrar los resultados y cerrar la conexión. | 6a, 6b, 6c, 6e, 6f | [Ver](./diapositivas/1-acceso-datos) |
| [2. Crear, consultar, modificar y borrar datos](./contenidos/2-crud-pdo) | Crear tablas desde PHP, operaciones CRUD, tablas relacionadas, transacciones, mysqli y rendimiento. | 6d, 6e, 6f, 6g | — |

## Prácticas

| Práctica | Qué se hace | CE |
|:---------|:------------|:--:|
| [P6.1 Autenticación contra MySQL](./ejercicios/1-autenticacion-bd) | Comprobar el usuario y la contraseña de la zona privada en una tabla de MySQL usando PDO. | 6b, 6c, 6e, 6f, 6g |
| [P6.2 Gestión de una tabla desde PHP](./ejercicios/2-crud) | Inventario de equipos con todas las operaciones sobre una tabla. | 6a, 6c, 6d, 6e, 6g |
| [P6.3 Clientes y pedidos](./ejercicios/3-clientes-pedidos) | Tablas relacionadas, alta de datos e informes. | 6d, 6e, 6f |
| [P6.4 Proyecto integrador: gestor de tareas colaborativo](./ejercicios/4-proyecto-gestor-tareas) | Aplicación completa con usuarios, tareas, calendario y publicación en WordPress. | 4d, 5f, 5h, 5i, 6e, 6f, 6g, 7e |

---

[Empezar por el acceso a datos →](./contenidos/1-acceso-datos-pdo)
