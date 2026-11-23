---
layout: doc
title: "Solución P2.6 — Joomla en un servidor remoto e informe comparativo"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P2.6 — Joomla en un servidor remoto e informe comparativo

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P2.6 Joomla y comparativa](../ejercicios/6-joomla-remoto).
:::

- **Unidad:** UP2 · RA2 · CE 2a, 2c, 2d, 2h.
- **Archivos de la solución:**
  - Esta página: instalación y comparativa.
  - [Informe modelo](./6-joomla-remoto-informe): informe comparativo de referencia dirigido a la asociación, con el nivel de redacción que corresponde al nivel 4.

::: warning Versiones y datos
Datos consultados el 09/11/2026: Joomla **6.2** (publicada en octubre de 2026; la rama 5.x solo recibe parches de seguridad desde el 13 de octubre de 2026), WordPress **7.1.4**. No se ha podido hacer una instalación real en un alojamiento gratuito al preparar la solución; los pasos de Joomla siguen su instalador y su documentación oficial.
:::

---

## Parte 1. Instalación

### Requisitos que debe cumplir el alojamiento

Fuente: [Joomla, requisitos técnicos](https://manual.joomla.org/docs/get-started/technical-requirements/).

| Componente | Joomla 6.x mínimo | Recomendado |
|:-----------|:------------------|:------------|
| PHP | **8.3** | 8.4 |
| MySQL / MariaDB | 8.0.13 / 10.4 | 8.4 / 12.0 |
| PostgreSQL | 12 | 17 |
| Extensiones de PHP | `json`, `simplexml`, `dom`, `zlib`, `gd`, `mysqlnd` o `pdo_mysql` | `mbstring` |
| `memory_limit` | — | 256 MB |

Un alojamiento con PHP 8.2 o anterior **no sirve** para Joomla 6 (sí para Joomla 5.4, que ya solo recibe parches de seguridad). InfinityFree o Byet.host (PHP 8.3, ver la P2.3) cumplen.

### 1. Instalación con base de datos creada a mano

1. Panel del alojamiento → **MySQL Databases** → crear la base de datos. Anotar nombre, usuario, contraseña y **servidor** (normalmente no es `localhost`).
2. Descargar el **Full Package** en ZIP de [downloads.joomla.org](https://downloads.joomla.org) y subirlo:
   - con el gestor de archivos, subir el ZIP a `htdocs`/`public_html` y **extraerlo** allí, si el gestor lo permite y el ZIP cabe en el límite de subida; o
   - descomprimir en el equipo y subir el contenido por FTP (miles de archivos: tarda).
3. Abrir la URL del sitio → instalador web de Joomla:

| Pantalla | Datos |
|:---------|:------|
| Idioma de la instalación y **nombre del sitio** | Español; «Asociación Cultural …» |
| **Datos de acceso** del superusuario | Nombre real, **usuario distinto de `admin`**, contraseña (Joomla exige una larga), correo |
| **Conexión a la base de datos** | Tipo MySQLi (o MySQL PDO), servidor, usuario, contraseña, nombre; **prefijo** aleatorio que propone (`abc12_`); cifrado: predeterminado |

4. **Comprobación de seguridad de la base de datos remota.** Como el servidor de base de datos **no es `localhost`**, el instalador pide demostrar que se controla el sitio: muestra el nombre de un archivo (único para cada sesión) de la carpeta `installation` que hay que **borrar** con el gestor de archivos o FTP antes de continuar. Si el instalador no puede crear archivos, pide **crearlo** en lugar de borrarlo. Es el punto donde más alumnos se quedan atascados.
5. Al terminar: **Instalar idiomas adicionales** → Español si no estaba, o **Abrir el sitio / el administrador**. Joomla borra la carpeta `installation`; si no puede, hay que borrarla a mano (lo pide).

### 2. Nombre, idioma y zona horaria

- **Sistema → Configuración global → Sitio**: nombre del sitio, descripción (metadatos).
- **Sistema → Configuración global → Servidor → Zona horaria del sitio**: **Madrid**.
- **Sistema → Gestionar → Idiomas**: Español como **predeterminado** para el **sitio** y para el **administrador** (son dos listas distintas).
- Opcional: **Sistema → Configuración global → Servidor → Forzar HTTPS: Todo el sitio**, si el certificado está activo.

### 3. Categorías, artículos y menú

1. **Contenido → Categorías → Nuevo**: «Actividades» y «Noticias».
2. **Contenido → Artículos → Nuevo**: un artículo en cada categoría, **Publicado**.
3. **Menús → Main Menu → Nuevo** elemento:
   - Título «Actividades» · **Tipo de elemento de menú: Artículos → Blog de categoría** · Categoría: Actividades.
   - Lo mismo para «Noticias».
4. Comprobar en **Contenido → Módulos del sitio** que el módulo **Main Menu** está **publicado** y en una **posición** de la plantilla (en Cassiopeia, `menu`) y asignado a **Todas las páginas**.

Lo característico de Joomla: un **menú no se ve por sí solo**; se muestra a través de un **módulo** de tipo menú colocado en una posición de la plantilla. Y cada elemento de menú **define la página** (qué se muestra y cómo: blog, lista, artículo único), no solo un enlace.

### 4. Plantilla nueva

1. Buscar una plantilla gratuita **compatible con Joomla 6** en el [JED (Joomla Extensions Directory)](https://extensions.joomla.org) o en la web de un desarrollador conocido. Comprobar la compatibilidad declarada y la fecha de la última versión.
2. **Sistema → Instalar → Extensiones** → **Subir paquete** (ZIP) o **Instalar desde la web**.
3. **Sistema → Plantillas → Estilos de plantilla del sitio** → estrella en el estilo nuevo (**Predeterminado**).
4. Revisar en **Módulos** que el menú y el resto de módulos están en posiciones que **existen** en la nueva plantilla: cada plantilla tiene sus propias posiciones y, al cambiar, los módulos pueden dejar de verse. Error frecuente y buena pregunta para el nivel 3.

Si la plantilla falla por incompatibilidad, se acepta documentarlo y crear una **plantilla hija** de Cassiopeia con cambios visibles, siempre que se explique.

### 5. Comprobación desde otro dispositivo

Móvil con datos: portada, los dos elementos de menú, un artículo, vista adaptada, candado HTTPS. Capturas en la memoria.

### Joomla frente a WordPress: organización (nivel 3 de CE 2c)

| Concepto | Joomla | WordPress |
|:---------|:-------|:----------|
| Contenido | **Artículos**, siempre dentro de una **categoría** (jerárquica). No hay «páginas» como tipo aparte. | **Entradas** (fechadas, con categorías y etiquetas) y **páginas** (jerárquicas, sin categoría). |
| Menú | Cada **elemento de menú** crea una página del sitio con un tipo de vista (artículo, blog de categoría, lista, formulario de contacto…). | Lista de enlaces a contenidos que ya existen. |
| Bloques de la página | **Módulos** en **posiciones** de la plantilla; cada módulo se asigna a unos elementos de menú. | **Bloques** y **widgets** en las plantillas o zonas del tema. |
| Extensiones | Componentes, módulos, plugins, plantillas, idiomas: cada tipo con su gestor. | Plugins y temas. |
| Usuarios | Grupos y **niveles de acceso** configurables; permisos por categoría y artículo. | Roles fijos ampliables con plugins. |
| Idiomas | **Multidioma integrado** (asociaciones de contenido entre idiomas). | Con plugins (Polylang, WPML). |

Nivel 4: lo aprendido de un CMS al instalar el otro. Ejemplos: la instalación tiene las mismas piezas (base de datos, archivos, asistente, archivo de configuración `configuration.php` frente a `wp-config.php`); el prefijo aleatorio que Joomla propone es la buena práctica que en WordPress había que elegir a mano (P2.4); la comprobación del archivo con base de datos remota muestra un control de seguridad que WordPress no tiene.

---

## Parte 2. Informe comparativo

El [informe modelo](./6-joomla-remoto-informe) es un informe completo de referencia. Puntos clave:

### 1. Qué aporta un CMS (CE 2a)

| Aporta | Inconvenientes |
|:-------|:---------------|
| Publicar sin saber HTML: editor visual, varias personas con permisos distintos. | Hay que mantenerlo: actualizaciones del núcleo, extensiones y PHP. |
| Separar contenido y diseño: cambiar la plantilla no obliga a rehacer los textos. | Más superficie de ataque que una web estática; necesita copias de seguridad. |
| Funciones listas: menús, buscador, formularios, calendario de eventos, galería, boletín. | Rendimiento peor que HTML estático si no se usa caché. |
| Gratuito (CMS libres) y con comunidad. | Dependencia de extensiones de terceros. |
| Web hecha a mano: control total y muy rápida, pero cada cambio requiere a alguien que sepa programar. | |

Nivel 3: ligado a la asociación (voluntarios que cambian cada año, agenda de actividades, noticias, socios). Nivel 4: escrito sin jerga.

### 2–3. Comparación (CE 2d)

Debe cubrir **licencia, facilidad, extensiones, usuarios, multidioma, requisitos y comunidad** para WordPress, Joomla y un tercero, **al menos uno propietario o en la nube** (Wix, Squarespace, WordPress.com como servicio…). La tabla de referencia está en el informe modelo.

Qué cambia con la licencia (nivel 3), aplicado a la asociación:

| Licencia | Permite | Exige | En la asociación |
|:---------|:--------|:------|:-----------------|
| **GPLv2 o posterior** (WordPress, Joomla, Drupal) | Usar para cualquier fin, estudiar, modificar, redistribuir; sin pago. | Si se **distribuye** una versión modificada, con la misma licencia y su código. Usar o modificar para la propia web **no obliga a nada**. | Pueden usarlo gratis, contratar a cualquiera para adaptarlo, cambiar de alojamiento cuando quieran y llevarse su web. |
| **Propietaria / SaaS** (Wix, Squarespace) | Usar el servicio mientras se paga, según las condiciones del proveedor. | Suscripción; aceptar sus condiciones; sin acceso al código ni al servidor. | Cómodo y sin mantenimiento técnico, pero **dependencia**: si suben precios o cierran, no pueden llevarse la web tal cual (la exportación es limitada); los datos los guarda el proveedor (revisar RGPD). |
| **MIT** (Ghost) | Casi todo, incluso integrarlo en software cerrado. | Mantener el aviso de copyright. | Igual de libre en la práctica. |

Datos de uso como argumento (W3Techs, 09/11/2026): WordPress 39,4 % de todas las webs (58,1 % de las que usan CMS), Wix 4,2 %, Squarespace 2,4 %, Joomla 1,1 %, Drupal 0,6 %. Más uso significa más plantillas, más extensiones, más ayuda y más profesionales disponibles, pero también ser el objetivo preferido de los ataques automatizados.

### 4. Recomendación

Se acepta cualquier recomendación **que se deduzca de la comparación** (nivel 4). Referencia:

- **WordPress** si lo que pesa es la facilidad para voluntarios sin formación técnica, el coste y la cantidad de plugins para agenda, socios y donaciones.
- **Joomla** si la web debe ser **bilingüe castellano–valenciano** con todas las páginas traducidas (multidioma integrado sin plugins de pago) y con permisos finos por sección.
- **Wix/Squarespace** solo si nadie puede ocuparse del mantenimiento y se acepta pagar una cuota y la dependencia del proveedor.
