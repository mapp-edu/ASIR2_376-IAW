---
layout: doc
title: P1.3 — Instalación de Apache y PHP en Ubuntu
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P1.3 — Instalación de Apache y PHP en Ubuntu

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP1 · RA1.
- **Criterios de evaluación:** 1c, 1e, 1g, 1i.
- **Contenidos de apoyo:** [Instalación de un servidor de aplicaciones web](../contenidos/5-instalacion-servidores), apartados 3 y 5.
- **Punto de partida:** el servidor preparado en la [P1.2](./2-requerimientos-sistema).
- **Entrega:** memoria en PDF.
:::

## Descripción

Instalarás y configurarás el servidor web Apache sobre el Ubuntu Server de la práctica anterior, le añadirás el intérprete de PHP y publicarás un sitio propio con su *virtual host*.

## Objetivos

- Instalar y configurar un servidor web.
- Añadir los módulos necesarios para procesar código en el servidor.
- Publicar un sitio y comprobar su funcionamiento desde otro equipo.

## Requisitos

1. Instala Apache, comprueba que el servicio está en marcha y que arranca con el sistema.
2. Abre en el cortafuegos solo los puertos necesarios para HTTP y HTTPS.
3. Comprueba desde el navegador de otro equipo (o del anfitrión de la máquina virtual) que aparece la página de bienvenida.
4. Crea el sitio `intranet`, con su carpeta en `/var/www/intranet`, su propio `index.html` y un *virtual host* con registros de acceso y de errores propios. Para acceder por nombre, añade `intranet.empresa.local` al archivo `hosts` del equipo cliente.
5. Comprueba la configuración antes de aplicarla y recarga Apache.
6. Instala PHP con el módulo de Apache y las extensiones `php-mysql`, `php-mbstring`, `php-xml` y `php-curl`.
7. Crea una página `info.php` con `phpinfo()`, comprueba qué `php.ini` se carga y qué extensiones están activas y, después, bórrala.
8. Cambia en `php.ini` el tamaño máximo de subida a 32 MB y la zona horaria a `Europe/Madrid`, y demuestra que el cambio se ha aplicado.
9. Muestra las últimas líneas del registro de accesos del sitio `intranet` después de visitarlo.

## Entregable

Un PDF con tu nombre y el de la práctica, con las órdenes, capturas y explicación de cada paso.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Servidor web y sitio propio**<br>CE 1c | Apache no responde desde otro equipo, o el sitio `intranet` no funciona. | Apache instalado y en marcha, y el sitio `intranet` accesible por nombre con su *virtual host* y sus registros. | Explica cada directiva del *virtual host* y el papel de `sites-available` y `sites-enabled`. | La configuración se comprueba antes de aplicarse y la memoria muestra el registro de accesos como prueba. |
| **Procesamiento de código en el servidor**<br>CE 1e | PHP no se ejecuta, o faltan extensiones. | PHP y las extensiones pedidas instalados, y los cambios de `php.ini` aplicados y demostrados. | Explica cómo se conecta Apache con PHP y qué aporta cada extensión. | Relaciona las extensiones y los valores de `php.ini` con los requerimientos de la P1.2. |
| **Seguridad en el acceso al servidor**<br>CE 1g | Hay puertos abiertos de más, o `info.php` sigue publicado. | Solo están abiertos los puertos necesarios e `info.php` se ha borrado tras usarlo. | Justifica por qué hay que retirar `info.php` y cerrar puertos que no se usan. | La memoria comprueba al final el estado del cortafuegos y de los puertos a la escucha. |
| **Documentación**<br>CE 1i | Faltan órdenes o capturas, o no se explica lo que se hace. | Cada paso tiene su orden, su captura y una explicación. | Las explicaciones dicen para qué sirve cada paso. | La memoria permitiría a otra persona repetir la instalación. |

---

**Siguiente práctica:** [P1.4 Instalación de MariaDB en Ubuntu →](./4-mariadb-ubuntu)
