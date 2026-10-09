---
layout: doc
title: P1.5 — Entorno integrado con Docker Compose
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P1.5 — Entorno integrado de pruebas con Docker Compose

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP1 · RA1.
- **Criterios de evaluación:** 1d, 1h, 1i.
- **Contenidos de apoyo:** [Instalación de un servidor de aplicaciones web](../contenidos/5-instalacion-servidores), apartado 7, y [Tecnologías y entorno de desarrollo](../contenidos/3-tecnologias-desarrollo), apartado de lenguajes.
- **Entrega:** repositorio en GitHub y memoria en PDF.
:::

## Descripción

Instalar un servidor a mano, como en las prácticas anteriores, enseña cómo funciona cada pieza, pero cuesta repetirlo. En esta práctica levantarás el mismo entorno (servidor web, PHP y base de datos) con Docker Compose y lo usarás para comprobar qué se procesa en el servidor y qué en el navegador.

## Objetivos

- Utilizar una plataforma integrada para probar y desarrollar aplicaciones web.
- Reconocer las posibilidades de procesamiento en el cliente y en el servidor.
- Documentar un entorno de forma que cualquiera pueda reproducirlo.

## Requisitos

### Parte 1. El entorno

1. Instala Docker y Docker Compose en tu equipo o en la máquina virtual.
2. Crea una carpeta `entorno-iaw` con un archivo `docker-compose.yml` que defina:
   - Un servicio `web` con la imagen oficial `php:8.3-apache`, que publique el puerto 8080 y monte la carpeta `./src` como raíz web.
   - Un servicio `db` con la imagen oficial de MariaDB, con una base de datos y un usuario propios y un volumen para los datos.
   - Un servicio `adminer` o `phpmyadmin` para administrar la base de datos desde el navegador.
3. La imagen `php:8.3-apache` no trae la extensión `pdo_mysql`. Crea un `Dockerfile` que parta de ella y la instale con `docker-php-ext-install pdo_mysql`, y úsalo en el servicio `web`.
4. Las contraseñas no van en `docker-compose.yml`: guárdalas en un archivo `.env` que no se suba al repositorio.
5. Levanta el entorno, comprueba que los tres contenedores están en marcha y muestra sus registros.

### Parte 2. Cliente y servidor

6. Crea en `src` una página `hora.php` que muestre dos horas: la del **servidor**, generada con PHP, y la del **navegador**, generada con JavaScript.
7. Cambia la zona horaria del contenedor web (variable de entorno `TZ`) y la del equipo cliente, y explica qué hora cambia en cada caso.
8. Abre el código fuente de la página en el navegador y explica por qué se ve el JavaScript pero no el PHP.
9. Añade a la página una consulta a la base de datos con PDO que muestre la versión de MariaDB.

### Parte 3. Reproducibilidad

10. Sube la carpeta a un repositorio de GitHub con un `README.md` que explique cómo levantar el entorno en otro equipo, y un `.env.example` con los nombres de las variables sin sus valores.
11. Comprueba que un compañero o compañera puede levantar tu entorno siguiendo solo el `README.md`.

## Entregable

1. **Enlace** al repositorio.
2. **Memoria en PDF** con capturas y explicación de cada paso, y la respuesta a las preguntas de la parte 2.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Procesamiento en cliente y servidor**<br>CE 1d | La página no muestra las dos horas o no se responde a las preguntas. | Página con hora del servidor y del navegador, consulta a la base de datos y respuestas a las preguntas 7 y 8. | Explica con el ejemplo qué se ejecuta en cada lado y qué recibe el navegador. | Relaciona el ejemplo con las ventajas e inconvenientes de procesar en cada lado. |
| **Plataforma integrada**<br>CE 1h | El entorno no arranca o falta algún servicio. | Los tres servicios en marcha, con el `Dockerfile`, el volumen y las credenciales en `.env`. | Explica cada línea de `docker-compose.yml` y del `Dockerfile`. | Compara este entorno con la instalación manual de las prácticas anteriores y con XAMPP. |
| **Documentación**<br>CE 1i | No hay `README.md` o no permite levantar el entorno. | `README.md` y `.env.example` en el repositorio, y la prueba con otra persona documentada. | El `README.md` explica también cómo parar, borrar y reiniciar el entorno. | Otra persona levanta el entorno sin preguntar nada. |
