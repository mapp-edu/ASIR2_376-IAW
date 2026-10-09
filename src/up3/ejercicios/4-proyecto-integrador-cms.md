---
layout: doc
title: P3.4 — Proyecto integrador. Un CMS de principio a fin
sidebar: true
outline: [2, 3]
aside: true
---

# 📋 P3.4 — Proyecto integrador: un CMS de principio a fin

<ExportPDF />

::: info-box Ficha de la práctica
- **Unidades:** UP1, UP2 y UP3 · RA1, RA2 y RA3.
- **Criterios de evaluación:** 1a, 1c, 1i, 2c, 2e, 3b, 3c, 3d.
- **Entrega:** memoria en PDF y vídeo explicativo.
:::

## Descripción

Este proyecto reúne lo trabajado en el primer bloque del módulo. Montarás desde cero el sitio web de una tienda de electrónica y hogar sobre XAMPP: prepararás el entorno, instalarás WordPress, crearás los contenidos y la navegación, organizarás a los usuarios y dejarás programadas las copias de seguridad.

Lee el enunciado hasta el final: una parte se documenta en la memoria y otra se demuestra en el vídeo.

## Objetivos

- Preparar un entorno de servidor web y base de datos a partir de un análisis de requisitos.
- Instalar y configurar un gestor de contenidos.
- Organizar contenidos, navegación y usuarios.
- Garantizar la integridad de la información con copias de seguridad.

## Requisitos

### Parte 1. Entorno

1. **Requisitos.** Investiga los requisitos mínimos y recomendados de XAMPP y de WordPress, y cita las fuentes.
2. **Instalación de XAMPP** en el sistema operativo que prefieras, en una máquina virtual si quieres. Si usas Linux, documenta las órdenes empleadas.
3. **Servicios.** Arranca Apache y MySQL, desde el panel o por órdenes, y ajusta su configuración si hace falta para WordPress.

### Parte 2. Instalación de WordPress

4. **Base de datos.** Crea con phpMyAdmin la base de datos y un usuario propio para WordPress.
5. **Instalación.** Instala WordPress, toma nota de cada paso y de los errores que aparezcan y explica cómo los resolviste.
6. **Configuración inicial.** Nombre, descripción, idioma y zona horaria. Ajusta los permisos de la carpeta para que WordPress pueda instalar plugins.

### Parte 3. Contenidos y navegación

7. **Páginas.** Crea dos páginas con texto, imágenes y enlaces (*Sobre nosotros* y *Contacto*) y cuatro páginas más con solo un título (*Móviles*, *Ordenadores*, *Cocina* y *Decoración*).
8. **Categorías.** Crea la categoría *Electrónica* con las subcategorías *Móviles* y *Ordenadores*, y la categoría *Hogar* con *Cocina* y *Decoración*. Asigna al menos una categoría a cada contenido. Las páginas no admiten categorías de serie en WordPress: busca cómo resolverlo y justifica la solución.
9. **Tema y menú.** Aplica un tema distinto del predeterminado y crea un menú de tres niveles:
   - **Nivel 1:** Inicio, Productos, Sobre nosotros, Contacto.
   - **Nivel 2**, dentro de Productos: Electrónica, Hogar.
   - **Nivel 3:** Electrónica → Móviles, Ordenadores; Hogar → Cocina, Decoración.

### Parte 4. Usuarios y grupos

10. Crea al menos cinco usuarios con distintos roles.
11. Instala el plugin **Groups** y crea al menos dos grupos con más de un usuario cada uno.

### Parte 5. Copias de seguridad

12. Instala **UpdraftPlus** y haz una copia completa cuando hayas terminado los contenidos y los usuarios.
13. Programa copias automáticas diarias.

## Entregable

### 1. Memoria en PDF

Con capturas y explicaciones de:

1. El análisis de requisitos y sus fuentes.
2. El sistema operativo usado, indicando si es una máquina virtual (no hace falta documentar su instalación).
3. La instalación de XAMPP: las órdenes o pasos más relevantes.
4. La preparación para WordPress: base de datos, archivo de configuración y permisos.
5. La pantalla final del asistente de WordPress.

Se valora que se explique **para qué sirve** cada orden y cada paso.

### 2. Vídeo

Un vídeo en el que se oiga tu voz (no hace falta que se te vea) mostrando:

1. Los usuarios, sus roles y sus grupos, en el panel.
2. Las páginas, sus categorías y quién creó cada una, y cómo se añadiría una subcategoría nueva.
3. La copia de seguridad configurada y cómo la cambiarías para que fuera semanal.
4. La parte pública: el menú, la navegación por todas sus opciones y las páginas con contenido.
5. Lo que hayas añadido por tu cuenta y las dificultades que encontraste.

## Rúbrica

Escala común del módulo: [niveles 0–4](/general/contenidos/3-evaluacion). El nivel 0 corresponde a no entregado o sin relación con lo solicitado.

| Elemento evaluable | Nivel 1 | Nivel 2 | Nivel 3 | Nivel 4 |
|:-------------------|:--------|:--------|:--------|:--------|
| **Análisis de requisitos**<br>CE 1a | Faltan requisitos o no se citan las fuentes. | Requisitos mínimos y recomendados de XAMPP y WordPress con sus fuentes. | Comprueba que el equipo usado cumple los requisitos y lo justifica. | Los requisitos se tienen en cuenta en la configuración posterior. |
| **Entorno de servidor**<br>CE 1c | XAMPP no funciona o no se documenta su instalación. | XAMPP instalado, servicios en marcha y configuración ajustada. | Explica qué componente de XAMPP cumple cada función. | La instalación se documenta como procedimiento reutilizable. |
| **Instalación de WordPress**<br>CE 2c | La instalación no termina, o no hay base de datos ni usuario propios. | Base de datos y usuario propios, WordPress instalado y errores documentados. | Explica la solución de cada error encontrado. | Relaciona cada paso con su efecto en `wp-config.php` y en la base de datos. |
| **Configuración, contenidos y navegación**<br>CE 2e | Faltan páginas, categorías o niveles del menú, o no se cambia el tema. | Páginas, categorías, tema y menú de tres niveles como se piden, y la solución a las categorías en páginas. | Justifica la solución elegida para categorizar páginas y la elección del tema. | La navegación del vídeo funciona sin enlaces rotos y el sitio es coherente. |
| **Usuarios y grupos**<br>CE 3b | Hay menos de cinco usuarios o no hay grupos. | Cinco usuarios con distintos roles y dos grupos con varios miembros. | Explica en el vídeo qué puede hacer cada rol y para qué sirven los grupos. | La organización de usuarios responde a un equipo de trabajo verosímil. |
| **Integración de plugins**<br>CE 3c | Falta alguno de los plugins o no está configurado. | Groups, UpdraftPlus y el plugin para categorizar páginas instalados y configurados. | Justifica la elección de cada plugin frente a alternativas. | Comprueba la compatibilidad de los plugins y no instala ninguno innecesario. |
| **Copias de seguridad**<br>CE 3d | No hay copia o no está programada. | Copia completa hecha y copias diarias programadas. | Explica qué incluye la copia y muestra cómo pasarla a semanal. | Propone dónde guardar las copias y cómo comprobarlas. |
| **Documentación y comunicación**<br>CE 1i | Falta la memoria o el vídeo, o no explican lo que se hace. | Memoria y vídeo con todos los puntos pedidos. | Las explicaciones dicen para qué sirve cada paso. | Memoria y vídeo están bien ordenados y se entienden sin conocer el enunciado. |
