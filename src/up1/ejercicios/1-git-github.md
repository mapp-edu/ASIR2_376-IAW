---
layout: doc
title: P1.1 — Control de versiones con Git y GitHub
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P1.1 — Control de versiones con Git y GitHub

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP1 · RA1.
- **Criterios de evaluación:** 1b, 1i.
- **Contenidos de apoyo:** [Control de versiones con Git y GitHub](../contenidos/4-control-versiones-git).
- **Entrega:** memoria en PDF y enlace a tu repositorio de GitHub.
:::

## Descripción

Vas a llevar con Git la documentación de un servidor ficticio, como haría un administrador que quiere saber en todo momento qué cambió en sus archivos de configuración y por qué. Trabajarás primero en local, después con ramas y, al final, con un repositorio remoto en GitHub en el que colaborará un compañero o compañera.

## Objetivos

- Configurar Git y crear un repositorio.
- Registrar cambios, consultar la historia y deshacer errores.
- Trabajar con ramas, fusionarlas y resolver un conflicto.
- Publicar el repositorio en GitHub y colaborar mediante una *pull request*.

## Requisitos

### Parte 1. Repositorio local

1. Instala Git, configura tu nombre, tu correo y la rama inicial `main`, y muestra la configuración resultante.
2. Crea un repositorio llamado `servidor-docs`.
3. Crea el archivo `README.md` con un título y una línea que explique el propósito del repositorio. Comprueba el estado antes y después de prepararlo y confírmalo.
4. Crea la carpeta `config` con el archivo `puertos.txt`, que contenga los puertos de HTTP, HTTPS, SSH y MySQL. Confírmalo.
5. Modifica `puertos.txt` para añadir el puerto de un servicio más. Muestra la diferencia con la última versión confirmada antes de confirmar el cambio.
6. Corrige el mensaje de la última confirmación.
7. Muestra la historia resumida y quién cambió cada línea de `puertos.txt`.

### Parte 2. Deshacer cambios

1. Borra una línea de `puertos.txt` sin prepararla y recupera la versión confirmada.
2. Borra la misma línea, prepárala, sácala del área de preparación sin perder el cambio y, después, recupera la versión confirmada.
3. Confirma un borrado «accidental» de `README.md` y deshaz esa confirmación, de forma que el archivo vuelva a estar.
4. Crea un archivo `.gitignore` que excluya los archivos `*.log` y un archivo `secretos.txt`. Comprueba que Git no los muestra.

### Parte 3. Ramas

1. Crea la rama `apache` y, en ella, el archivo `config/vhost-intranet.conf` con un *virtual host* de ejemplo. Confírmalo.
2. Vuelve a `main`, cambia el título de `README.md` y confírmalo.
3. Muestra la historia de todas las ramas en forma de árbol.
4. Fusiona `apache` en `main` y borra la rama.
5. Provoca un conflicto: crea la rama `puertos`, cambia en ella el puerto de HTTP de `puertos.txt` y confírmalo; vuelve a `main` y cambia esa misma línea de otra forma. Fusiona, resuelve el conflicto y confírmalo.

### Parte 4. GitHub

1. Crea un repositorio público `servidor-docs` en GitHub, enlázalo como `origin` y sube la rama `main`.
2. Comprueba en la web de GitHub que aparece la historia completa.
3. Haz una bifurcación del repositorio de un compañero o compañera, clónala, crea una rama `revision`, añade un archivo `revisores.txt` con tu nombre y abre una *pull request* hacia su repositorio.
4. Revisa y acepta la *pull request* que te hayan hecho a ti.

::: warning-box Autenticación
Para subir cambios por HTTPS necesitas un token de acceso personal de GitHub, no tu contraseña. No incluyas el token en la memoria ni en el repositorio.
:::

## Entregable

1. **Memoria en PDF** con, para cada paso, la orden ejecutada, una captura de la salida y una explicación breve de lo que hace.
2. **Enlace** a tu repositorio `servidor-docs` en GitHub y a la *pull request* que has abierto.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Flujo de trabajo local**<br>CE 1b | Faltan pasos de la parte 1, o la historia del repositorio no los refleja. | Repositorio configurado y creado, con todas las confirmaciones pedidas y sus mensajes. | Explica en cada paso la diferencia entre directorio de trabajo, área de preparación y repositorio. | Los mensajes de confirmación son claros y la historia se entiende sin leer la memoria. |
| **Deshacer cambios**<br>CE 1b | Alguna de las situaciones de la parte 2 no se resuelve, o se pierde trabajo. | Las cuatro situaciones se resuelven con las órdenes adecuadas y `.gitignore` funciona. | Justifica por qué cada situación necesita una orden distinta y qué riesgo tiene cada una. | Relaciona `.gitignore` y las órdenes de deshacer con la protección de credenciales en un servidor real. |
| **Ramas y conflictos**<br>CE 1b | No se crean las ramas, no se fusionan o el conflicto queda sin resolver. | Ramas creadas y fusionadas, conflicto resuelto y árbol de historia mostrado. | Explica qué ha provocado el conflicto y cómo ha decidido el contenido final. | El árbol de historia de la memoria se corresponde con lo que se ve en GitHub. |
| **Repositorio remoto y colaboración**<br>CE 1b | El repositorio no está en GitHub, o no hay *pull request*. | Repositorio publicado con su historia, *pull request* abierta y la recibida aceptada. | Explica qué hacen `push`, `pull` y `clone`, y el papel de la bifurcación en la colaboración. | La *pull request* lleva una descripción del cambio que permite revisarlo sin preguntar. |
| **Documentación**<br>CE 1i | Faltan órdenes o capturas, o no se explica lo que se hace. | Cada paso tiene su orden, su captura y una explicación. | Las explicaciones dicen para qué sirve cada orden, no solo qué se ha escrito. | La memoria está ordenada y podría usarse como guía rápida de Git. |

---

**Siguiente práctica:** [P1.2 Análisis de requerimientos y preparación del sistema →](./2-requerimientos-sistema)
