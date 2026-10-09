---
layout: doc
title: P6.2 — Gestión de una tabla desde PHP
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P6.2 — Gestión completa de una tabla desde PHP

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP6 · RA6.
- **Criterios de evaluación:** 6a, 6c, 6d, 6e, 6g.
- **Contenidos de apoyo:** temas [1. Acceso a datos con PDO](../contenidos/1-acceso-datos-pdo) y [2. Crear, consultar, modificar y borrar datos](../contenidos/2-crud-pdo).
- **Entrega:** código PHP en `.zip`, exportación SQL de la base de datos y memoria en PDF.
:::

## Descripción

El departamento de sistemas quiere llevar el inventario de sus equipos en una pequeña aplicación web. Programarás en PHP todas las operaciones sobre la tabla, desde su creación hasta el borrado de registros.

## Objetivos

- Configurar en PHP la conexión con el sistema gestor de bases de datos.
- Crear la base de datos y las tablas desde PHP.
- Obtener y actualizar la información almacenada.
- Comprobar el funcionamiento ante errores.

## Requisitos

0. Antes de empezar, elabora en la memoria una tabla con los sistemas gestores de bases de datos más utilizados en entornos web (al menos MySQL, MariaDB, PostgreSQL, SQLite y uno no relacional como MongoDB): licencia, tipo, extensión de PHP con la que se conecta y un caso de uso típico. Justifica cuál elegirías para el inventario.
1. Crea en MariaDB o MySQL un usuario `inventario_user` con permisos solo sobre la base de datos `inventario`.
2. Escribe `conexion.php` con una función que devuelva la conexión PDO configurada para lanzar excepciones.
3. Escribe `instalar.php`, que cree la base de datos (si el usuario tiene permiso) y la tabla `equipos` con: identificador, nombre del equipo, tipo (*portátil*, *sobremesa*, *servidor*, *impresora*), número de serie único, fecha de compra y ubicación. Debe poder ejecutarse varias veces sin error.
4. Escribe `index.php`, que muestre todos los equipos en una tabla HTML ordenada por fecha de compra, con un filtro por tipo enviado por GET.
5. Escribe `nuevo.php`, con un formulario que valide los datos e inserte un equipo nuevo. Si el número de serie ya existe, debe mostrar un mensaje claro.
6. Escribe `editar.php`, que cargue los datos de un equipo en un formulario y guarde los cambios.
7. Añade a cada fila de `index.php` un botón **Borrar** que envíe el identificador por POST a `borrar.php` y pida confirmación antes.
8. Captura todas las excepciones: el usuario ve un mensaje comprensible y el detalle queda en el registro de errores de PHP.
9. Prueba y documenta: inserción correcta, número de serie repetido, campos vacíos, edición de un equipo que no existe, borrado y caída de la base de datos (detén el servicio y recarga `index.php`).

## Entregable

1. Los archivos PHP en un `.zip`.
2. La base de datos exportada en SQL, con al menos ocho equipos.
3. Una memoria en PDF con capturas de las pruebas del punto 9.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Sistemas gestores en entornos web**<br>CE 6a | La tabla está incompleta o no incluye el gestor no relacional. | Tabla con los cinco gestores y todos los datos pedidos. | Justifica el gestor elegido para el inventario con los datos de la tabla. | Explica qué cambiaría en el código PHP si se usara otro de los gestores de la tabla. |
| **Conexión con el SGBD**<br>CE 6c | La conexión falla o se usa `root`. | Conexión con PDO en un archivo propio, con el usuario de la aplicación y excepciones activadas. | Justifica el DSN, el juego de caracteres y cada opción de PDO. | Las credenciales no aparecen en ningún otro archivo y la memoria explica dónde guardarlas en producción. |
| **Creación de la base de datos y la tabla**<br>CE 6d | `instalar.php` falla o la tabla no tiene los campos y restricciones pedidos. | Tabla creada desde PHP con todos los campos, la clave primaria y el número de serie único, ejecutable varias veces. | Justifica el tipo de dato de cada campo. | La estructura tiene en cuenta las consultas que hará la aplicación, por ejemplo con un índice para el filtro por tipo. |
| **Consulta y actualización de datos**<br>CE 6e | Alguna de las operaciones (listar, filtrar, insertar, editar, borrar) no funciona. | Las cinco operaciones funcionan con sentencias preparadas, y el borrado se hace por POST con confirmación. | Explica cómo se pasan los datos entre las páginas y por qué cada operación usa GET o POST. | La aplicación es coherente: tras cada operación se vuelve al listado con un mensaje del resultado. |
| **Verificación del funcionamiento**<br>CE 6g | No se documentan pruebas o la aplicación muestra errores de PHP al usuario. | Las pruebas del punto 9 realizadas y documentadas, con mensajes comprensibles en todos los casos. | Explica qué demuestra cada prueba y dónde queda registrado el detalle del error. | Las pruebas se pueden repetir siguiendo la memoria e incluyen una comprobación de rendimiento con `EXPLAIN`. |

---

**Siguiente práctica:** [P6.3 Clientes y pedidos →](./3-clientes-pedidos)
