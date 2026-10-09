---
layout: doc
title: P1.4 — Instalación de MariaDB en Ubuntu
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P1.4 — Instalación y configuración de MariaDB en Ubuntu

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP1 · RA1.
- **Criterios de evaluación:** 1c, 1f, 1g, 1i.
- **Contenidos de apoyo:** [Instalación de un servidor de aplicaciones web](../contenidos/5-instalacion-servidores), apartado 4.
- **Punto de partida:** el servidor con Apache y PHP de la [P1.3](./3-apache-ubuntu).
- **Entrega:** memoria en PDF.
:::

## Descripción

Completarás el servidor LAMP instalando el sistema gestor de bases de datos MariaDB, asegurando su instalación y comprobando que PHP puede conectarse a él.

## Objetivos

- Instalar y asegurar un servidor de bases de datos.
- Crear una base de datos y un usuario con los permisos mínimos.
- Configurar y verificar el acceso a la base de datos desde PHP.

## Requisitos

1. Instala MariaDB y comprueba que el servicio está en marcha.
2. Ejecuta el asistente de seguridad y explica qué hace cada pregunta.
3. Crea la base de datos `intranet` con juego de caracteres `utf8mb4` y un usuario `intranet_user` que solo tenga permisos sobre ella y solo pueda conectarse desde `localhost`.
4. Conéctate con ese usuario desde la línea de órdenes. Crea una tabla `avisos` con un identificador, un título y una fecha, e inserta dos filas.
5. Comprueba que `intranet_user` **no** puede ver otras bases de datos.
6. Crea en `/var/www/intranet` un *script* `prueba-bd.php` que se conecte con PDO a la base de datos y muestre los avisos. Ábrelo en el navegador y, después, bórralo.
7. Comprueba en qué dirección y puerto escucha MariaDB y explica si es accesible desde otros equipos.
8. Haz una copia de seguridad de la base de datos con `mariadb-dump` y restáurala en una base de datos nueva `intranet_prueba`.

::: tip-box Script de prueba
El tema de [acceso a datos con PDO](/up6/contenidos/1-acceso-datos-pdo) tiene un ejemplo completo de conexión y consulta que puedes adaptar.
:::

## Entregable

Un PDF con tu nombre y el de la práctica, con las órdenes, capturas y explicación de cada paso.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Instalación del servidor de bases de datos**<br>CE 1c | MariaDB no funciona, o no se ejecuta el asistente de seguridad. | MariaDB instalado y en marcha, con el asistente de seguridad ejecutado y explicado. | Explica de qué riesgo protege cada opción del asistente. | Relaciona la instalación con la del servidor web, formando un LAMP completo y documentado. |
| **Acceso a la base de datos**<br>CE 1f | El usuario no puede conectarse, o PHP no obtiene los datos. | Base de datos, usuario, tabla y datos creados, y el *script* PHP muestra los avisos. | Justifica el juego de caracteres y la forma de conexión elegidos. | Se demuestra la restauración de la copia de seguridad y se explica cuándo se usaría. |
| **Seguridad en el acceso**<br>CE 1g | El usuario tiene permisos de más o puede conectarse desde cualquier equipo. | El usuario solo accede a su base de datos y desde `localhost`, y se comprueba que no ve otras. | Explica el principio de mínimo privilegio y qué supone la dirección en la que escucha MariaDB. | El *script* de prueba se retira al terminar y las credenciales no aparecen en la memoria. |
| **Documentación**<br>CE 1i | Faltan órdenes o capturas, o no se explica lo que se hace. | Cada paso tiene su orden, su captura y una explicación. | Las explicaciones dicen para qué sirve cada paso. | La memoria, junto con la de la P1.3, documenta el servidor completo. |

---

**Siguiente práctica:** [P1.5 Entorno integrado con Docker Compose →](./5-docker-compose)
