---
layout: doc
title: P3.2 — Usuarios, roles y registro de actividad
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P3.2 — Usuarios, roles y registro de actividad

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP3 · RA3.
- **Criterios de evaluación:** 3b, 3i.
- **Contenidos de apoyo:** [Administración de gestores de contenidos](../contenidos/1-administracion-cms), apartados de usuarios, control de accesos y registro de actividad.
- **Punto de partida:** cualquier instalación de WordPress de la UP2.
- **Entrega:** memoria en PDF.
:::

## Descripción

La redacción de una revista digital trabaja con WordPress. Hay una directora, dos editores, un autor de plantilla y varias personas colaboradoras externas cuyos artículos deben revisarse antes de publicarse. Vas a configurar las cuentas y permisos de todo el equipo y a comprobar que cada cual puede hacer solo lo que le corresponde.

## Objetivos

- Crear y gestionar usuarios con distintos perfiles.
- Comprobar en la práctica los permisos de cada rol.
- Crear un rol a medida.
- Obtener informes de acceso y de actividad.

## Requisitos

1. Crea los usuarios del equipo con el rol adecuado: una administradora, dos editores, un autor y dos colaboradores. Ninguno debe llamarse `admin` y todos deben tener contraseñas fuertes.
2. Inicia sesión con un colaborador, escribe un artículo y envíalo a revisión. Comprueba que no puede publicarlo ni subir imágenes.
3. Inicia sesión con un editor, revisa ese artículo y publícalo.
4. Comprueba que el autor puede publicar sus artículos pero no editar los de otros.
5. Instala un plugin de gestión de roles y crea el rol **Corrector**: puede editar y publicar entradas de cualquier autor, pero no borrarlas ni gestionar páginas. Asígnalo a un usuario nuevo y comprueba sus permisos.
6. Instala un plugin de registro de actividad. Haz varias acciones con distintos usuarios (inicios de sesión, publicaciones, un intento de acceso con contraseña incorrecta) y obtén el informe.
7. Localiza en el registro de accesos de Apache (o en el del alojamiento) las peticiones a `wp-login.php` de la prueba anterior.
8. Da de baja a uno de los colaboradores sin perder sus artículos.

## Entregable

Un PDF con tu nombre y el de la práctica, con una tabla resumen de usuarios y roles, y capturas y explicación de cada comprobación.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Usuarios y roles predefinidos**<br>CE 3b | Faltan usuarios o los roles no corresponden a las funciones del equipo. | Todos los usuarios creados con su rol, y comprobados los permisos de colaborador, editor y autor. | Justifica el rol asignado a cada persona con el principio de mínimo privilegio. | La baja del colaborador conserva sus artículos y la memoria explica cómo. |
| **Rol a medida**<br>CE 3b | El rol Corrector no existe o tiene permisos que no se piden. | Rol Corrector creado con los permisos pedidos, asignado y comprobado. | Explica qué capacidades se han marcado y por qué. | Compara el rol creado con los predefinidos y explica cuándo conviene crear uno nuevo. |
| **Informes de acceso y actividad**<br>CE 3i | No se obtiene el informe de actividad o no refleja las acciones hechas. | Informe del plugin con las acciones realizadas, y peticiones a `wp-login.php` localizadas en el registro del servidor. | Explica qué información aporta cada registro y en qué se diferencian. | Propone qué revisar periódicamente en estos registros para detectar problemas. |
