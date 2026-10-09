---
layout: doc
title: P5.3 — Envío de correos con PHP
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P5.3 — Manejo de correos electrónicos con PHP

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidad:** UP5 · RA5.
- **Criterios de evaluación:** 5c, 5d, 5e, 5h.
- **Agrupamiento:** parejas.
- **Entrega:** programa PHP comentado, documento explicativo y exposición.
- **Fecha de entrega:** la indicada en Aules.
:::

## Objetivos

1. Investigar y entender los mecanismos que PHP proporciona para enviar correos electrónicos de manera automatizada utilizando una cuenta de Gmail.
2. Aprender a enviar correos electrónicos a varios destinatarios, tanto en el campo «Para» como en los campos «CC» (con copia) y «CCO» (con copia oculta).
3. Incluir adjuntos en los correos electrónicos enviados mediante PHP.
4. Desarrollar un programa en PHP que envíe correos electrónicos.

## Descripción

Desarrollaréis un programa en PHP que utilizará una cuenta de Gmail gratuita para enviar correos electrónicos. El correo debe permitir varios destinatarios, tanto visibles (Para, CC) como ocultos (CCO), y debe poder llevar archivos adjuntos.

Tendréis que investigar y usar la biblioteca que permita realizar estas tareas en PHP, y configurar correctamente el acceso a una cuenta de Gmail para habilitar el envío de correos desde el script.

El programa será **de consola**. El usuario introducirá los datos necesarios, de forma que se evidencie su funcionamiento:

- Dirección de correo del destinatario principal (Para).
- Direcciones de los destinatarios en CC y CCO.
- Asunto del correo.
- Cuerpo del mensaje.
- Fichero adjunto, si procede.

## Tareas

### 1. Configuración de la cuenta de Gmail para el envío de correos

- Investigar y configurar los ajustes de seguridad necesarios en una cuenta de Gmail para permitir el acceso desde aplicaciones externas.
- Asegurarse de que el programa PHP esté configurado correctamente para acceder a Gmail y enviar correos de manera segura.

::: warning-box Contraseña de aplicación
Google ha retirado la opción de «acceso de aplicaciones menos seguras». El método vigente es generar una **contraseña de aplicación**, para lo que la cuenta debe tener activada la verificación en dos pasos. Usad una cuenta creada para la práctica, no vuestra cuenta personal.
:::

### 2. Instalación de las librerías necesarias

- Investigar e instalar las librerías disponibles, de PHP o externas. Explicar cómo se instalan en el entorno de desarrollo.
- Verificar si es necesario configurar algún componente adicional de PHP para habilitar el envío de correos mediante Gmail, como habilitar `openssl` o modificar `php.ini`.

### 3. Desarrollo del programa PHP

- Crear un script en PHP que solicite por consola los campos mencionados: destinatario, CC, CCO, asunto, cuerpo y adjunto.
- Utilizar la librería elegida para enviar el correo electrónico con los datos proporcionados por el usuario.
- Asegurarse de que el programa maneje correctamente los errores: que el archivo adjunto no exista, que las direcciones de correo no sean válidas, etc.

::: danger-box No subáis la contraseña con el código
La contraseña de aplicación no debe quedar escrita en el código que entreguéis ni en un repositorio. Leedla de un archivo aparte o de una variable de entorno.
:::

## Entregables

1. **Programa en PHP.** Debe incluir comentarios explicativos que faciliten la comprensión del código.
2. **Documento con la explicación de la práctica**, con estos puntos: configuración previa en Gmail, instalación o configuración previa de librerías y explicación breve del programa.
3. **Exposición de la práctica**, en la que se explicará el trabajo realizado y se hará la prueba de envío de correos desde la aplicación desarrollada.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado. El documento y la exposición son la evidencia con la que se valoran los niveles 3 y 4.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Programa de consola**<br>CE 5c | El script no se ejecuta, o no pide o no usa alguno de los datos: Para, CC, CCO, asunto, cuerpo o adjunto. | El script pide todos los datos por consola y envía el correo con varios destinatarios, CC, CCO y adjunto. | Explica cómo lee la entrada, cómo compone el mensaje y por qué organiza así el código. | El código está comentado y estructurado de modo que la pareja lo explica con soltura en la exposición. |
| **Validación y control de errores**<br>CE 5d | Un dato incorrecto hace que el programa termine con un error de PHP sin tratar. | Detecta direcciones no válidas y adjuntos inexistentes, e informa del fallo de envío. | Justifica qué se valida, en qué momento y qué ocurre en cada caso de error. | Los mensajes orientan al usuario sobre cómo corregir el dato, y la demostración incluye casos de error. |
| **Uso de la librería y de funciones**<br>CE 5e | La librería no está instalada o se usa copiando un ejemplo que no se adapta a lo pedido. | La librería está instalada y sus funciones se usan correctamente para destinatarios, copias y adjuntos. | Explica cómo se instala, por qué se elige y qué hace cada llamada utilizada. | El código propio se organiza en funciones reutilizables y el documento permite repetir la instalación desde cero. |
| **Acceso seguro a la cuenta**<br>CE 5h | No se consigue autenticar contra Gmail, o se usa la contraseña principal de la cuenta. | El envío se autentica con una contraseña de aplicación y la conexión va cifrada. | Explica el mecanismo de autenticación y de cifrado, y los ajustes de PHP que requiere. | Las credenciales quedan fuera del código entregado y el documento describe los problemas encontrados y su solución. |

---

**Siguiente práctica:** [P5.4 Formularios con PHP →](./4-formularios)
