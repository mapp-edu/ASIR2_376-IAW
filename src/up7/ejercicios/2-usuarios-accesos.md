---
layout: doc
title: P7.2 — Usuarios, grupos y control de accesos
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P7.2 — Usuarios, grupos y control de accesos

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP7 · RA4.
- **Criterios de evaluación:** 4e, 4f.
- **Contenidos de apoyo:** [Aplicaciones de ofimática web](../contenidos/1-ofimatica-web), apartados de gestión de usuarios y control de accesos.
- **Punto de partida:** el Nextcloud de la [P7.1](./1-instalacion-nextcloud).
- **Entrega:** memoria en PDF.
:::

## Descripción

Con Nextcloud en marcha, hay que dar de alta al personal y decidir quién ve y quién modifica cada documento. La empresa tiene tres departamentos: Dirección, Comercial y Sistemas.

## Objetivos

- Gestionar las cuentas de usuario y los grupos.
- Aplicar criterios de seguridad en el acceso de los usuarios.

## Requisitos

### Cuentas

1. Crea los grupos *Dirección*, *Comercial* y *Sistemas*, y al menos dos usuarios en cada uno.
2. Asigna una cuota de 1 GB a los usuarios de Comercial y de 5 GB a los de Sistemas.
3. Nombra a un usuario de Sistemas administrador del grupo *Sistemas* (no de todo Nextcloud) y comprueba qué puede hacer.
4. Da de baja a un usuario de Comercial transfiriendo antes sus archivos a un compañero.

### Accesos

5. Crea una carpeta *Comercial* compartida con su grupo, en la que todos puedan editar.
6. Comparte con Comercial un documento *Tarifas* en el que puedan **ver** pero **no modificar**. Compruébalo iniciando sesión con un usuario del grupo.
7. Comparte con una persona externa un documento mediante un enlace público con contraseña y fecha de caducidad. Comprueba que pide la contraseña y que, después de la caducidad, ya no funciona (puedes poner una fecha cercana o adelantar la fecha del servidor en una prueba).
8. Configura una política de contraseñas (longitud mínima y comprobación contra contraseñas filtradas) y activa la autenticación en dos pasos obligatoria para el grupo *Dirección*. Compruébalo con un usuario del grupo.
9. Consulta el registro de actividad y localiza las acciones de las pruebas anteriores.

::: tip-box Compara con Google Drive
Si quieres comparar, repite los puntos 6 y 7 con un documento de Google Drive y explica qué opciones de control ofrece cada plataforma.
:::

## Entregable

Un PDF con tu nombre y el de la práctica, con una tabla resumen de grupos, usuarios y permisos, y capturas y explicación de cada comprobación.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Gestión de cuentas**<br>CE 4e | Faltan grupos, usuarios o cuotas, o la baja pierde los archivos. | Grupos, usuarios, cuotas, administrador de grupo y baja con transferencia, como se pide. | Explica por qué se gestionan los permisos por grupos y qué puede hacer un administrador de grupo. | La tabla resumen permite ver de un vistazo quién es quién y qué puede hacer. |
| **Seguridad en el acceso**<br>CE 4f | Algún permiso no funciona como se pide o no se comprueba. | Solo lectura, enlace con contraseña y caducidad, política de contraseñas y doble factor configurados y comprobados. | Explica de qué riesgo protege cada medida. | Relaciona las medidas con la protección de datos de la empresa y con el registro de actividad. |

---

**Siguiente práctica:** [P7.3 Trabajo cooperativo con documentos y presentaciones →](./3-trabajo-cooperativo)
