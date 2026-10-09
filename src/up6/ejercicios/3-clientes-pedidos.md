---
layout: doc
title: P6.3 — Clientes y pedidos
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P6.3 — Clientes y pedidos: tablas relacionadas

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP6 · RA6.
- **Criterios de evaluación:** 6d, 6e, 6f.
- **Contenidos de apoyo:** [Crear, consultar, modificar y borrar datos](../contenidos/2-crud-pdo), apartados de tablas relacionadas y seguridad.
- **Entrega:** un único `.zip` con los archivos PHP y la exportación SQL de la base de datos.
:::

## Descripción

Una tienda en línea necesita registrar a sus clientes y los pedidos de cada uno. Un cliente puede tener muchos pedidos, y cada pedido pertenece a un solo cliente. Programarás la creación de las tablas, el alta de datos y dos informes.

## Objetivos

- Crear desde PHP tablas relacionadas con su clave ajena.
- Insertar datos respetando la integridad referencial.
- Obtener información combinando tablas.
- Aplicar criterios de seguridad en todo el acceso a los datos.

## Requisitos

### Ejercicio 0. Estructura

Crea la base de datos `tienda_iaw` y una página `index.html` con tres enlaces: **Crear tablas**, **Insertar datos** y **Consultas**, que lleven a las páginas de los ejercicios siguientes.

### Ejercicio 1. Crear las tablas

`crear_tablas.php` tiene un formulario con el botón **Crear tablas**. Al pulsarlo, la misma página crea estas tablas y muestra «Las tablas se han creado correctamente»:

- **clientes**: `id` (clave primaria), `nombre`, `email` (único), `ciudad`.
- **pedidos**: `id` (clave primaria), `producto`, `precio`, `fecha`, `id_cliente` (clave ajena hacia `clientes`).

### Ejercicio 2. Insertar datos

`insertar.php` tiene dos formularios: uno para dar de alta un cliente y otro para registrar un pedido. En el del pedido, el cliente se elige en una lista desplegable cargada desde la base de datos, para que no se pueda escribir un identificador que no existe.

Da de alta, al menos, estos datos (algunos con los formularios y el resto con SQL desde phpMyAdmin):

| Cliente | Ciudad | Pedidos |
|:--------|:-------|:--------|
| Lucía Ferrer | Valencia | Portátil 899,00 €; funda 19,90 € |
| Marcos Gil | Alicante | Monitor 27" 249,99 €; teclado 59,00 € |
| Elena Ruiz | Castellón | Impresora láser 179,00 € |
| Pau Serra | Valencia | Tableta 329,50 €; auriculares 39,90 €; cargador 24,00 € |
| Sara Molina | Alicante | Ninguno |

### Ejercicio 3. Consultas

`consultas.php` muestra, una debajo de otra y con su título, tres tablas HTML:

1. Nombre del cliente, producto y precio de los pedidos de más de 200 €, de mayor a menor precio.
2. Cada cliente con su número de pedidos y el importe total, **incluidos** los clientes sin pedidos.
3. El importe total de pedidos por ciudad.

Añade además un buscador que, a partir de una parte del nombre escrita por el usuario, muestre los pedidos de los clientes que coincidan.

## Entregable

Un único `.zip` con `index.html`, los archivos PHP y la base de datos exportada en SQL.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Tablas relacionadas**<br>CE 6d | Las tablas no se crean desde PHP o falta la clave ajena. | Las dos tablas creadas desde PHP con sus claves primarias, el correo único y la clave ajena. | Justifica los tipos de datos y qué ocurre con los pedidos si se borra un cliente. | La estructura permite responder a las tres consultas sin cambios. |
| **Inserción y consulta de datos**<br>CE 6e | Faltan datos, o alguna consulta no da el resultado correcto. | Datos insertados, lista desplegable de clientes, y las tres consultas y el buscador con el resultado correcto. | Explica cada consulta: tablas que combina, tipo de `JOIN` y agrupación. | Los resultados se presentan en tablas HTML claras, con los importes en formato de moneda. |
| **Seguridad en el acceso**<br>CE 6f | Alguna consulta concatena datos del usuario o se muestran datos sin escapar. | Todas las consultas con datos del usuario son preparadas y toda la salida se escapa. | Explica de qué ataque protege cada medida, con un ejemplo de entrada maliciosa en el buscador. | Usuario de base de datos propio con permisos mínimos y errores sin detalles técnicos para el usuario. |

---

**Siguiente práctica:** [P6.4 Proyecto integrador: gestor de tareas colaborativo →](./4-proyecto-gestor-tareas)
