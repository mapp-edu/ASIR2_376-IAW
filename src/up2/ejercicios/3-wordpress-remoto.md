---
layout: doc
title: P2.3 — WordPress en un alojamiento remoto
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P2.3 — Publicar WordPress en un alojamiento remoto

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP2 · RA2.
- **Criterios de evaluación:** 2c, 2f, 2g, 2h.
- **Contenidos de apoyo:** [Gestores de contenidos](../contenidos/1-gestores-contenidos), apartados de instalación y publicación.
- **Entrega:** memoria en PDF y URL del sitio publicado.
:::

## Descripción

Hasta ahora WordPress solo funcionaba en tu equipo. En esta práctica lo publicarás en Internet usando un servicio de alojamiento gratuito, de forma que cualquiera pueda visitarlo.

## Objetivos

- Instalar un gestor de contenidos en un servidor remoto.
- Conocer las herramientas de un panel de alojamiento: dominio, base de datos, archivos e instalador.
- Activar las medidas de seguridad básicas de un sitio público.
- Publicar el sitio y comprobar su funcionamiento.

## Requisitos

1. Elige un servicio de alojamiento gratuito que admita PHP y MySQL. Antes de registrarte, lee sus condiciones y anota en la memoria las limitaciones del plan gratuito (espacio, tráfico, publicidad, HTTPS, dominio).
2. Crea la cuenta y un subdominio para tu sitio.
3. Instala WordPress **sin usar el instalador automático** del panel:
   - Crea la base de datos y su usuario desde el panel.
   - Sube los archivos de WordPress con el gestor de archivos del panel o por FTP/SFTP.
   - Ejecuta el asistente web de WordPress.
4. Configura el título, la descripción, el idioma y la zona horaria.
5. Aplica estas medidas de seguridad:
   - Un usuario administrador que no se llame `admin` y con contraseña fuerte.
   - HTTPS activado, si el alojamiento lo ofrece.
   - El editor de archivos del panel desactivado en `wp-config.php`.
   - Los plugins y temas que no se usen, eliminados.
6. Publica una página de presentación y una entrada.
7. Comprueba el sitio desde otro dispositivo, por ejemplo un móvil con datos, y revisa **Herramientas → Salud del sitio**.

::: warning-box Datos personales
Es un sitio público: no publiques datos personales tuyos ni de otras personas. Usa una dirección de correo creada para la práctica.
:::

## Entregable

1. **Memoria en PDF** con capturas y explicación de cada paso, incluyendo las limitaciones del alojamiento elegido.
2. **URL** del sitio publicado.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Instalación en el servidor remoto**<br>CE 2c | La instalación no termina o se ha hecho con el instalador automático. | Base de datos creada, archivos subidos y WordPress instalado con el asistente web. | Explica qué hace cada paso de la instalación manual y qué datos acaba guardando `wp-config.php`. | Compara este proceso con la instalación local y señala qué cambia al trabajar en remoto. |
| **Seguridad del sitio**<br>CE 2f | Falta alguna de las medidas pedidas. | Las cuatro medidas aplicadas y comprobadas. | Explica de qué ataque protege cada medida. | Las medidas se apoyan en el análisis de las limitaciones del alojamiento. |
| **Pruebas de funcionamiento**<br>CE 2g | No se comprueba el sitio fuera del propio equipo. | Sitio comprobado desde otro dispositivo y revisión de Salud del sitio incluida. | Explica los avisos de Salud del sitio y cuáles se pueden resolver en este alojamiento. | Las pruebas cubren parte pública, panel y versión móvil. |
| **Publicación**<br>CE 2h | El sitio no es accesible en la URL entregada. | El sitio está publicado con la página y la entrada pedidas. | Justifica la elección del alojamiento a partir de sus condiciones. | La memoria explica qué haría falta para pasar este sitio a un alojamiento profesional. |

---

**Siguiente práctica:** [P2.4 WordPress en un servidor LAMP →](./4-wordpress-lamp)
