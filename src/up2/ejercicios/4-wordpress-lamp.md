---
layout: doc
title: P2.4 — WordPress en un servidor LAMP
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P2.4 — Instalación manual de WordPress en un servidor LAMP

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP2 · RA2.
- **Criterios de evaluación:** 2c, 2e, 2f, 2g.
- **Contenidos de apoyo:** [Instalación manual de WordPress en un servidor LAMP](../contenidos/1-gestores-contenidos#instalacion-manual-de-wordpress-en-un-servidor-lamp).
- **Punto de partida:** el servidor Ubuntu con Apache, PHP y MariaDB de la [UP1](/up1/ejercicios/).
- **Entrega:** memoria en PDF.
:::

## Descripción

AMPPS y XAMPP lo resuelven casi todo con un clic. En esta práctica instalarás WordPress a mano sobre tu servidor Ubuntu, sin paquetes «todo en uno», para entender qué hace cada pieza.

## Objetivos

- Instalar un CMS paso a paso sobre una pila LAMP.
- Configurar el servidor web y la base de datos para el CMS.
- Personalizar la configuración de WordPress desde `wp-config.php`.
- Comprobar el funcionamiento del sitio y de sus enlaces permanentes.

## Requisitos

1. Comprueba que el servidor cumple los requisitos de WordPress: versiones de PHP y MariaDB, y extensiones de PHP.
2. Crea desde la línea de órdenes la base de datos `wp_intranet` y un usuario con permisos solo sobre ella.
3. Descarga la última versión de WordPress en español, descomprímela en `/var/www/wp-intranet` y asigna los propietarios y permisos adecuados.
4. Crea un *virtual host* `wp.empresa.local` con `AllowOverride All` y activa el módulo `rewrite`.
5. Ejecuta el asistente web usando el prefijo de tablas `intra_`.
6. Edita `wp-config.php` para:
   - Desactivar el editor de archivos del panel.
   - Limitar a 5 las revisiones que se guardan de cada contenido.
   - Activar el modo de depuración con registro en archivo, sin mostrar los errores en pantalla.
7. Activa los enlaces permanentes con el nombre de la entrada y comprueba que funcionan.
8. Comprueba en la base de datos que las tablas tienen el prefijo elegido y que `intra_options` guarda la URL del sitio.
9. Provoca un error de PHP en un plugin de prueba y localízalo en el registro de depuración. Después, desactiva el modo de depuración.

## Entregable

Un PDF con tu nombre y el de la práctica, con las órdenes, capturas y explicación de cada paso.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Instalación manual**<br>CE 2c | Falta algún paso o WordPress no funciona en su dirección. | Base de datos, archivos, *virtual host* y asistente completados, con el prefijo pedido. | Explica la función de los propietarios y permisos, de la directiva `AllowOverride` y del módulo de reescritura. | Contrasta los requisitos de WordPress con el servidor y los cumple todos. |
| **Configuración del CMS**<br>CE 2e | Faltan cambios en el archivo de configuración o no se demuestra que se aplican. | Los tres cambios de configuración y los enlaces permanentes configurados y demostrados. | Explica qué constante controla cada cambio y su efecto. | Los cambios se justifican pensando en un sitio en producción. |
| **Mecanismos de seguridad**<br>CE 2f | El editor de archivos sigue activo o los errores se muestran en pantalla. | Editor desactivado y errores enviados al registro en lugar de a la pantalla. | Explica qué riesgo supone cada uno si se deja activo. | La depuración se desactiva al terminar y la memoria lo comprueba. |
| **Pruebas de funcionamiento**<br>CE 2g | No se comprueban los enlaces permanentes ni la base de datos. | Enlaces permanentes, tablas con prefijo y error localizado en el registro. | Explica qué demuestra cada comprobación. | Las comprobaciones quedan como lista de verificación reutilizable. |

---

**Siguiente práctica:** [P2.5 Instalación de Moodle →](./5-moodle)
