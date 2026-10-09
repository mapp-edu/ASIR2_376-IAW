---
layout: doc
title: P7.1 — Instalación de Nextcloud con edición de documentos
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P7.1 — Instalación de Nextcloud con edición de documentos

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP7 · RA4.
- **Criterios de evaluación:** 4a, 4c, 4d.
- **Contenidos de apoyo:** [Aplicaciones de ofimática web](../contenidos/1-ofimatica-web).
- **Punto de partida:** el servidor Ubuntu con Apache, PHP y MariaDB de la [UP1](/up1/ejercicios/).
- **Entrega:** memoria en PDF.
:::

## Descripción

La empresa quiere dejar de enviar documentos por correo y tenerlos en un servidor propio, donde se puedan editar entre varias personas. Instalarás Nextcloud en el servidor de la intranet y le añadirás un editor de documentos en línea.

## Objetivos

- Reconocer la utilidad de las aplicaciones de ofimática web para la empresa.
- Instalar una aplicación de ofimática web autoalojada.
- Configurarla para integrarla en la intranet.

## Requisitos

1. Escribe una introducción breve, dirigida a la dirección de la empresa, que explique qué ventajas tendría Nextcloud frente al envío de documentos por correo y frente a un servicio en la nube como Google Workspace.
2. Comprueba los requisitos de la versión actual de Nextcloud e instala las extensiones de PHP que falten.
3. Crea la base de datos y su usuario.
4. Instala Nextcloud en `/var/www/nextcloud` con el directorio de datos fuera de la carpeta pública, y publícalo como `nube.empresa.local`.
5. Completa la instalación con el asistente web o con `occ`.
6. Configura las tareas en segundo plano con *cron* y añade el dominio a los dominios de confianza.
7. Revisa la vista general de la administración y resuelve al menos tres de los avisos que muestre.
8. Instala una aplicación de edición de documentos (Nextcloud Office u ONLYOFFICE) y comprueba que se puede crear y editar un documento de texto y una hoja de cálculo en el navegador.
9. Personaliza el nombre, el logotipo y el color de Nextcloud con la imagen de la empresa.
10. Instala el cliente de escritorio en otro equipo y comprueba la sincronización de una carpeta.

::: tip-box Servidor de documentos
Si tu máquina virtual va justa de memoria, usa la opción integrada de Nextcloud Office (*Built-in CODE server*) para las pruebas. En producción, el servidor de documentos va en una máquina o contenedor aparte.
:::

## Entregable

Un PDF con tu nombre y el de la práctica, con la introducción del punto 1 y las órdenes, capturas y explicación de cada paso.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Utilidad para la empresa**<br>CE 4a | No se explica la utilidad o se limita a una definición. | La introducción explica las ventajas frente al correo y frente a la nube. | Relaciona las ventajas con necesidades concretas de la empresa. | El texto está escrito para la dirección: claro, breve y sin jerga técnica. |
| **Instalación**<br>CE 4c | Nextcloud no funciona o el directorio de datos es público. | Nextcloud instalado con su base de datos, directorio de datos fuera de la carpeta pública, *cron* y editor de documentos funcionando. | Explica cada requisito y cada paso, y los avisos resueltos. | La instalación se documenta como procedimiento reutilizable. |
| **Integración en la intranet**<br>CE 4d | Nextcloud no es accesible por su nombre o no hay sincronización. | Acceso por `nube.empresa.local`, imagen corporativa aplicada y sincronización desde otro equipo comprobada. | Explica qué hace falta para que funcione con el resto de servicios de la intranet (nombres, certificados, usuarios). | Propone cómo integrar los usuarios de la intranet (LDAP) o el calendario con otras aplicaciones. |

---

**Siguiente práctica:** [P7.2 Usuarios, grupos y control de accesos →](./2-usuarios-accesos)
