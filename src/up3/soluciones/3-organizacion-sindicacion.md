---
layout: doc
title: "Solución P3.3 — Organización, plantillas y sindicación"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P3.3 — Organización, plantillas y sindicación

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P3.3 Organización y sindicación](../ejercicios/3-organizacion-sindicacion).
:::

- **Unidad:** UP3 · RA3 · CE 3a, 3f, 3g.
- **Punto de partida:** la revista de la P3.2, con el tema Twenty Twenty-Five (tema de bloques, el que trae WordPress).
- **Archivos de la solución:**
  - <a :href="withBase('/soluciones/up3/p3.3-organizacion-sindicacion/estructura-revista.sh')" download><code>estructura-revista.sh</code></a>: crea con WP-CLI categorías, artículos con etiquetas, enlaces permanentes, menú de secciones, la plantilla de categoría y la plantilla «Sin barra lateral» con la página «Sobre la revista».
- **Probado** con WordPress 7.1.4: URL con categoría, archivos de categoría y etiqueta, menú de dos niveles, las dos plantillas, *feeds* general y de categoría, y el bloque RSS.

::: warning Dos requisitos que el tema por defecto ya cumple
- **Requisito 5:** la plantilla *Archivos* de Twenty Twenty-Five **ya muestra** el título y la descripción de la categoría (bloques *Título de la consulta* y *Descripción del término*). Comprobado. Si alguien dice «ya salía» sin haber hecho nada, no ha hecho la práctica: hay que crear una plantilla **específica de categoría** y modificarla de forma visible (apartado 5).
- **Requisito 6:** Twenty Twenty-Five **no tiene barra lateral** en las páginas. La plantilla nueva se distingue por otros rasgos (ancho completo, sin cabecera de imagen…), y conviene que la memoria diga qué la diferencia de *Páginas*.

Además, el requisito 9 habla de «barra lateral o pie»: con este tema, el bloque RSS va en el **pie** o en una plantilla.
:::

---

## Organización

### 1. Categorías

**Entradas → Categorías**. Para cada una: nombre, *slug* sin tildes, **Categoría superior** y **descripción** (la necesita el requisito 5).

| Categoría | Superior | *Slug* | Descripción |
|:----------|:---------|:-------|:------------|
| Tecnología | — | `tecnologia` | Informática, ciencia aplicada e Internet. |
| Salud | — | `salud` | Hábitos saludables, prevención y avances médicos. |
| Cultura | — | `cultura` | Agenda y crítica cultural. |
| Cine | Cultura | `cine` | Estrenos, festivales y clásicos. |
| Música | Cultura | `musica` | Conciertos, discos y festivales. |

Recomendable: renombrar «Sin categoría» (por ejemplo, a «General») o hacer que la categoría por defecto sea otra en **Ajustes → Escritura**.

### 2. Artículos y etiquetas

Un artículo **por categoría y por subcategoría** (cinco), con tres etiquetas cada uno y al menos dos etiquetas compartidas entre secciones distintas. Referencia del script:

| Artículo | Categoría | Etiquetas |
|:---------|:----------|:----------|
| La inteligencia artificial llega a las aulas | Tecnología | inteligencia artificial, educación, **jóvenes** |
| Dormir bien mejora la memoria | Salud | **jóvenes**, hábitos, educación |
| Museos gratis el primer domingo de mes | Cultura | **Valencia**, museos, ocio |
| Festival de cortometrajes en Valencia | Cine | **Valencia**, **jóvenes**, **festivales** |
| Gira de otoño de la orquesta | Música | **Valencia**, conciertos, **festivales** |

Cada artículo en **una** categoría: el de Cine solo en Cine (no también en Cultura), porque el archivo de Cultura ya muestra los de sus subcategorías (comprobado: `/category/cultura/` lista los tres de Cultura, Cine y Música).

### Categorías frente a etiquetas, con los artículos creados (nivel 3)

- **Categoría** = la **sección** de la revista: jerárquica, obligatoria, una por artículo, va en el menú y en la URL. «Festival de cortometrajes» **es** de Cine (y por tanto de Cultura).
- **Etiqueta** = un **tema transversal**, sin jerarquía, varias por artículo. «jóvenes» une un artículo de Tecnología, uno de Salud y uno de Cine: `/tag/jovenes/` muestra los tres, cosa que ninguna categoría haría.
- Regla práctica: si el lector buscaría la sección en el menú → categoría; si es un tema que cruza secciones → etiqueta.

### 3. Enlaces permanentes con la categoría

**Ajustes → Enlaces permanentes → Estructura personalizada** → `/%category%/%postname%/` → **Guardar cambios**.

| URL | Responde |
|:----|:---------|
| `/cultura/cine/festival-de-cortometrajes-en-valencia/` | 200: la URL incluye la ruta completa de la categoría (padre/hija) |
| `/category/cultura/cine/` | 200: archivo de la subcategoría |
| `/tag/festivales/` | 200 |

Opcional: en la misma pantalla, **Base de las categorías** `seccion` → `/seccion/cultura/` en lugar de `/category/cultura/`.

### 4. Menú de secciones

Con un **tema de bloques**: **Apariencia → Editor → Navegación** (o la cabecera → bloque Navegación) → **Añadir enlace** → buscar la **categoría** (no una página) → para Cultura, **Añadir submenú** con Cine y Música → **Guardar**.

Con un **tema clásico**: **Apariencia → Menús** → caja **Categorías** → marcar → **Añadir al menú** → arrastrar Cine y Música a la derecha bajo Cultura → ubicación *Principal*.

Comprobado: menú con Tecnología, Salud y Cultura (con submenú Cine y Música), cinco enlaces a los archivos de categoría.

Nivel 4 de CE 3a: el lector navega por secciones desde el menú, las etiquetas permiten saltos temáticos (bloque *Nube de etiquetas* en el pie) y la URL de cada artículo dice en qué sección está.

## Plantillas

### Qué plantilla usa WordPress para cada página (nivel 3 de CE 3f)

WordPress sigue la **jerarquía de plantillas**: busca de la más específica a la más general y usa la primera que existe en el tema (o creada en el editor).

| Página | Orden de búsqueda | En Twenty Twenty-Five se usa |
|:-------|:------------------|:-----------------------------|
| `/category/salud/` | `category-salud` → `category-3` → **`category`** → `archive` → `index` | `archive` (o `category` tras el paso 5) |
| `/tag/jovenes/` | `tag-jovenes` → `tag` → `archive` → `index` | `archive` |
| Un artículo | `single-post-<slug>` → `single-post` → `single` → `singular` → `index` | `single` |
| Una página | **plantilla elegida en la página** → `page-<slug>` → `page-<id>` → `page` → `singular` → `index` | `page` (o la personalizada del paso 6) |
| Portada de entradas | `home` → `index` | `home` |

En un tema de bloques, estas plantillas son archivos `.html` en `templates/` del tema o, si se modifican en el editor, entradas de tipo `wp_template` en la base de datos (las modificaciones del editor **no** tocan el archivo del tema y sobreviven a sus actualizaciones).

### 5. Plantilla de archivo de categoría

**Apariencia → Editor → Plantillas → Añadir nueva plantilla → Archivo de categoría → Para todos los elementos** (o solo para «Salud» si se quiere una plantilla de una sola sección).

Modificación de referencia (la que crea el script):

- Un **Grupo** con color de fondo encima de la lista, que contiene:
  - **Título de la consulta** con «Mostrar prefijo» **desactivado** («Salud» en vez de «Categoría: Salud»),
  - **Descripción del término** en tamaño grande.
- Debajo, la lista de entradas (patrón de bucle de consulta del tema).

Comprobado: `/category/salud/` muestra «Salud» y la descripción sobre fondo de color; `/tag/jovenes/` sigue con la plantilla *Archivos* («Etiqueta: jóvenes»), lo que demuestra que la nueva solo afecta a categorías.

Con un **tema clásico** el requisito se hace en el Personalizador solo si el tema lo ofrece; si no, con una plantilla `category.php` en un tema hijo (UP4).

### 6. Plantilla «Sin barra lateral» para «Sobre la revista»

**Apariencia → Editor → Plantillas → Añadir nueva plantilla → Plantilla personalizada** → nombre «Sin barra lateral» → construirla con *Cabecera*, *Título*, *Contenido* (ancho amplio, por ejemplo 1100 px) y *Pie*, **sin** la parte de plantilla *Sidebar* → **Guardar**.

Después: **Páginas → Sobre la revista → panel Página → Plantilla → Sin barra lateral** → **Actualizar**.

Comprobado: la plantilla aparece en el selector de plantillas de página junto a la *Page No Title* del tema, y la página «Sobre la revista» la usa.

Nivel 4: mismas cabecera y pie que el resto (partes de plantilla compartidas), mismas fuentes y colores del tema; solo cambia la composición.

## Sindicación

### 7. *Feeds* y suscripción

| *Feed* | URL | Tipo |
|:-------|:----|:-----|
| General (entradas) | `http://<sitio>/feed/` | `application/rss+xml` |
| Categoría Salud | `http://<sitio>/category/salud/feed/` | `application/rss+xml` |
| Etiqueta | `http://<sitio>/tag/jovenes/feed/` | |
| Comentarios | `http://<sitio>/comments/feed/` | |

Firefox y Chrome muestran el XML (o lo descargan). Fragmento real del *feed* de Salud:

```xml
<channel>
  <title>Salud – Revista</title>
  <link>http://revista.local</link>
  <item>
    <title>Dormir bien mejora la memoria</title>
    <link>http://revista.local/salud/dormir-bien-mejora-la-memoria/</link>
    <dc:creator><![CDATA[Javier López]]></dc:creator>
    <pubDate>Wed, 18 Nov 2026 09:53:35 +0000</pubDate>
    <category><![CDATA[Salud]]></category>
    <category><![CDATA[jóvenes]]></category>
    <description><![CDATA[Dormir bien mejora la memoria. Texto del artículo.]]></description>
  </item>
```

::: warning Lector de feeds y sitio local
Los lectores **en la nube** (Feedly, Inoreader) leen el *feed* desde sus servidores: **no llegan** a `localhost`, a una IP privada ni a un nombre del archivo `hosts`. Con un WordPress local hay que usar un lector **de escritorio** (Thunderbird: *Nueva cuenta → Feeds*; QuiteRSS; Fluent Reader) o una extensión del navegador. Con el WordPress publicado en la P2.3 sí sirve uno en la nube.
:::

### 8. Artículo nuevo

Publicar un artículo en Salud → en el lector, **Obtener mensajes / Actualizar** → aparece. Los lectores consultan cada cierto tiempo (el *feed* indica `sy:updatePeriod hourly`), así que puede tardar si no se fuerza.

Comprobación cruzada: el artículo aparece en `/category/salud/feed/` y **no** en `/category/tecnologia/feed/`.

### 9. Noticias de un medio externo

**Apariencia → Editor → Patrones → Pie** (o la plantilla donde se quiera) → bloque **RSS** → URL del *feed* del medio (por ejemplo, el RSS de portada de un periódico o de una sección) → número de elementos 5, mostrar fecha → **Guardar**.

Comprobado con un *feed* de la propia instalación: el bloque muestra títulos enlazados y fechas.

A tener en cuenta:

- WordPress **guarda en caché** los *feeds* externos **12 horas**: una noticia nueva del medio no aparece al momento. No es un fallo.
- El servidor necesita **salida a Internet** para leer el *feed* (en AMPPS, la del equipo).
- Si la URL no es un *feed* válido, el bloque muestra «Se ha producido un error» en lugar de las noticias.

### Qué es un *feed* y para qué sirve en cada sentido (nivel 3 de CE 3g)

Un *feed* es un **archivo XML** (formato **RSS 2.0** o **Atom**) que un sitio publica en una URL fija con sus últimos contenidos: título, enlace, fecha, autor, categorías y resumen o contenido. Lo generan las aplicaciones y lo leen otras aplicaciones, no personas.

- **Hacia fuera (publicar):** los lectores reciben las novedades sin visitar la web; otros sitios, boletines o redes sociales pueden reutilizarlas automáticamente.
- **Hacia dentro (consumir):** el sitio muestra contenido actualizado de otros (el bloque RSS), sin copiarlo a mano.

### Uso concreto (nivel 4)

- **Revista:** *feed* por sección para los lectores especializados (solo Salud); *feed* general para generar el boletín semanal por correo (Mailchimp, MailPoet leen RSS); publicación automática en redes con un servicio que lee el *feed*.
- **Intranet (portal de la UP2):** suscribir a los empleados al *feed* de la página o categoría **Urgentes** en Thunderbird, o mostrar ese *feed* en la pantalla de la sala de descanso; y, hacia dentro, mostrar en el portal el *feed* del BOE o del proveedor de software con avisos de seguridad.
