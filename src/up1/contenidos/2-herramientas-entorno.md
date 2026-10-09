---
layout: doc
title: Herramientas y puesta en marcha
sidebar: true
outline: [2, 3]
aside: true
---

# 🧰 Herramientas y puesta en marcha

<ExportPDF />

## Servidor web

Un servidor web es el software que recibe peticiones HTTP (GET, POST, DELETE…) y devuelve el recurso solicitado: HTML, CSS, JavaScript, JSON, imágenes, etc.

El producto más implantado es [Apache HTTP Server](https://httpd.apache.org/), creado en 1995:

- Es software libre y multiplataforma.
- Tiene un sistema de módulos dinámicos, con los que se añaden lenguajes como PHP, Python o Perl.
- Utiliza el archivo `.htaccess` para su configuración por directorio.

En la actualidad, Apache está perdiendo mercado respecto a [Nginx](https://nginx.org/). Se trata de un producto más moderno (2004) y que en determinados escenarios tiene mejor rendimiento que Apache.

::: info-box Comparativa de servidores web
W3Techs publica la evolución de la cuota de mercado de cada servidor web: [historial de uso de servidores web](https://w3techs.com/technologies/history_overview/web_server/ms/q).
:::

## Servidor de aplicaciones

Un servidor de aplicaciones es un software que ofrece servicios adicionales a los de un servidor web:

- *Clustering*
- Balanceo de carga
- Tolerancia a fallos

[Tomcat](https://tomcat.apache.org/) es el servidor de aplicaciones de código abierto y multiplataforma de referencia para una arquitectura Java. Contiene un contenedor web Java que interpreta *Servlets* y JSP.

## Lenguajes en el servidor

Las aplicaciones que generan las páginas web se programan en alguno de los siguientes lenguajes:

- PHP
- Java EE: Servlets / JSP
- Python
- ASP.NET: Visual Basic .NET / C#
- Ruby

### PHP

- Lenguaje de propósito general diseñado para el desarrollo de páginas web dinámicas.
- En un principio, lenguaje no tipado.
- Actualmente en la versión 8. A lo largo del curso se utiliza PHP 8.
- El código va embebido en el HTML.
- Las instrucciones se escriben entre las etiquetas `<?php` y `?>`.
- Para generar salida desde PHP se usa la instrucción `echo`.
- Cuenta con multitud de librerías y *frameworks*: Laravel, Symfony, CodeIgniter, Laminas (antes Zend).

```php
<!DOCTYPE html>
<html lang="es">
<body>
    <h1>Mi primera página dinámica</h1>
    <p>Hoy es <?php echo date("d/m/Y"); ?></p>
</body>
</html>
```

PHP se estudia en profundidad en la [UP5](/up5/).

## Puesta en marcha

Para trabajar con un entorno de desarrollo local hay que preparar el equipo con las herramientas comentadas.

### Stack local: XAMPP o AMPPS

[XAMPP](https://www.apachefriends.org/es/index.html) es una distribución compuesta por el software necesario para desarrollar en entorno servidor. Su nombre indica lo que incluye:

| Sigla | Componente |
|:-----:|:-----------|
| **X** | El sistema operativo. De ahí que este tipo de distribución se conozca también como LAMP (Linux) o WAMP (Windows). |
| **A** | Apache. |
| **M** | MySQL / MariaDB. Incluye también phpMyAdmin para administrar la base de datos desde una interfaz web. |
| **P** | PHP. |
| **P** | Perl. |

Desde su página se descarga el instalador para el sistema operativo del equipo. Conviene leer la FAQ de cada sistema operativo, que trae instrucciones para la puesta en marcha.

[AMPPS](https://ampps.com/) es una distribución equivalente (Apache, MySQL, PHP, Perl, Python) que añade un instalador automático de aplicaciones como WordPress. Es la que se usa en las [prácticas de WordPress](/up2/ejercicios/).

::: tip-box Comprueba la instalación
Con los servicios Apache y MySQL arrancados, abre `http://localhost` en el navegador. Si ves la página de bienvenida del stack, el servidor web responde.
:::

### Entorno de desarrollo

En este curso se emplea [Visual Studio Code](https://code.visualstudio.com/) como entorno de desarrollo. Existen otras alternativas: PhpStorm es la más conocida, pero es de pago; Eclipse es otra posibilidad, aunque es un entorno bastante pesado.

VS Code es un editor de código fuente que se complementa mediante extensiones. Para PHP se recomienda:

- **PHP Intelephense**: autocompletado, ayuda sobre funciones y detección de errores.

::: note-box Fuente
Adaptado de los apuntes de Aitor Medrano y Luis Alemañ, *Desarrollo Web en Entorno Servidor*, licencia CC BY-NC-SA. Ver [Créditos y fuentes](/general/contenidos/4-creditos).
:::

---

**Siguiente paso:** [Tecnologías y entorno de desarrollo →](./3-tecnologias-desarrollo)
