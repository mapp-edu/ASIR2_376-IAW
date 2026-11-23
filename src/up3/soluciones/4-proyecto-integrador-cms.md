---
layout: doc
title: "Solución P3.4 — Proyecto integrador: tienda con WordPress sobre XAMPP"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P3.4 — Proyecto integrador: tienda con WordPress sobre XAMPP

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P3.4 Proyecto integrador](../ejercicios/4-proyecto-integrador-cms).
:::

- **Unidades:** UP1, UP2, UP3 · CE 1a, 1c, 1i, 2c, 2e, 3b, 3c, 3d.
- **Archivos de la solución:**
  - [Guion del vídeo](./4-proyecto-integrador-video): guion del vídeo de referencia, con tiempos.
  - <a :href="withBase('/soluciones/up3/p3.4-proyecto-integrador/archivos/categorias-en-paginas.zip')" download><code>archivos/categorias-en-paginas.zip</code></a> (código en <a :href="withBase('/soluciones/up3/p3.4-proyecto-integrador/archivos/categorias-en-paginas/categorias-en-paginas.php')" download><code>categorias-en-paginas.php</code></a>): plugin mínimo (dos funciones) que añade categorías a las páginas **y** las muestra en los archivos de categoría.
  - <a :href="withBase('/soluciones/up3/p3.4-proyecto-integrador/tienda-referencia.sh')" download><code>tienda-referencia.sh</code></a>: monta con WP-CLI las partes 2 a 4 (ajustes, categorías, páginas, menú de tres niveles, usuarios y grupos) para una demostración o para comparar.
- **Probado** con WordPress 7.1.4, el tema Twenty Twenty-Four, Groups 4.9.0 y el plugin de `archivos/`: las nueve opciones del menú responden 200, los archivos de categoría muestran las páginas, y los grupos tienen sus miembros. **No probado:** XAMPP (no hay Windows en el entorno de preparación) y UpdraftPlus (sin acceso al repositorio de plugins); esos pasos siguen su documentación.

::: warning Lo que suele fallar en este proyecto
1. **Las páginas con categoría no aparecen en los archivos de categoría.** Asignar categorías a páginas (con cualquier plugin) solo guarda la relación; WordPress sigue listando únicamente **entradas** en `/category/electronica/`. Comprobado: sin el segundo bloque del plugin de `archivos/`, el archivo de Electrónica sale vacío. Si el menú enlaza Electrónica y Hogar a sus categorías, el vídeo mostrará páginas vacías (nivel 1–2 en «navegación sin enlaces rotos»).
2. **El nivel 1 «Productos» no es ninguna página.** Se resuelve con un elemento de menú sin destino (submenú que solo se despliega) o con una página «Productos». Las dos valen si se explican.
3. **El pie del tema trae enlaces de demostración** (Twenty Twenty-Four: *Team, History, Careers…*, todos a `#`). Hay que editarlo o quitarlo.
4. **Los autores no pueden crear páginas.** Si alguien dice que «Diego (autor) creó la página Móviles», no es posible sin cambiar su rol.
:::

---

## Parte 1. Entorno

### 1. Requisitos (memoria, CE 1a)

| Componente | Mínimo | Recomendado | Fuente |
|:-----------|:-------|:------------|:-------|
| **WordPress 7.1** | PHP 7.4, MySQL 5.5.5 / MariaDB 10.x | **PHP 8.3+**, **MySQL 8.0+ o MariaDB 10.11+**, HTTPS, Apache o Nginx con `mod_rewrite` | [wordpress.org/about/requirements](https://wordpress.org/about/requirements/) |
| Extensiones de PHP | `json`, `mysqli` | `curl`, `dom`, `exif`, `fileinfo`, `gd` o `imagick`, `intl`, `mbstring`, `openssl`, `xml`, `zip` | Salud del sitio de WordPress |
| **XAMPP** | Windows 64 bits (7 o posterior), Linux x64 o macOS; ~1 GB de disco instalado | La última versión de la rama de PHP que se quiera | [apachefriends.org](https://www.apachefriends.org/download.html) |
| Versiones de XAMPP (23/10/2026) | 8.3.36, 8.4.27 y 8.5.12 para Windows | **8.4.x**: PHP soportado y probado por los plugins habituales | [Forgekit, oct. 2026](https://forgekit.tools/guides/xampp-php-8-5-windows) |

XAMPP 8.5.12 incluye PHP 8.5.12, Apache 2.4.65, **MariaDB 10.11.16** y phpMyAdmin 5.2.3. La versión anterior que siguen enlazando muchos tutoriales (8.2.12, de 2023) trae **MariaDB 10.4**, por debajo de lo recomendado por WordPress: funciona, pero *Salud del sitio* avisa. Cualquier versión es válida si el alumnado indica cuál ha usado y lo contrasta con la tabla.

**Nivel 3 de 1a:** comprobar que el equipo cumple (sistema de 64 bits, memoria, disco libre, puertos 80 y 3306 libres) y decirlo. **Nivel 4:** que se note después, por ejemplo, ajustando `php.ini` o activando extensiones porque la tabla lo pedía.

### 2. Instalación de XAMPP (CE 1c)

**Windows:**

1. Descargar el instalador de [apachefriends.org](https://www.apachefriends.org/download.html).
2. Ejecutarlo; si avisa del Control de cuentas de usuario, **instalar en `C:\xampp`** (no en *Archivos de programa*, donde Windows protege la escritura).
3. Componentes: basta con **Apache, MySQL, PHP y phpMyAdmin**. Lo demás (FileZilla, Mercury, Tomcat, Perl) no hace falta: instalar menos es también reducir superficie de ataque.
4. Abrir el **XAMPP Control Panel**.

**Linux** (órdenes que deben aparecer documentadas):

```bash
chmod +x xampp-linux-x64-*-installer.run
sudo ./xampp-linux-x64-*-installer.run      # instala en /opt/lampp
sudo /opt/lampp/lampp start                 # arranca Apache y MySQL
sudo /opt/lampp/lampp status
sudo /opt/lampp/manager-linux-x64.run       # panel gráfico, opcional
```

**Qué componente cumple cada función (nivel 3 de 1c):**

| Componente | Función en el proyecto |
|:-----------|:-----------------------|
| Apache | Servidor web: recibe las peticiones del navegador y entrega las páginas. |
| PHP (módulo de Apache) | Ejecuta el código de WordPress y genera el HTML. |
| MariaDB («MySQL» en el panel) | Guarda contenidos, usuarios y ajustes. |
| phpMyAdmin | Administrar MariaDB desde el navegador (crear base de datos y usuario). |
| Panel de control | Arrancar y parar servicios, ver puertos, abrir configuración y registros. |

### 3. Servicios y configuración

**Start** en Apache y MySQL (verde, con PID y puertos 80/443 y 3306). Comprobación: `http://localhost` → página de XAMPP; `http://localhost/phpmyadmin`.

Ajustes para WordPress en `php.ini` (**Config → PHP (php.ini)** en el panel; `/opt/lampp/etc/php.ini` en Linux), y **Stop/Start** de Apache:

| Directiva | Valor | Por qué |
|:----------|:------|:--------|
| `extension=intl`, `extension=zip`, `extension=gd` | sin `;` delante | Extensiones recomendadas por WordPress; suelen venir comentadas en Windows. *Salud del sitio* lo confirma. |
| `upload_max_filesize` / `post_max_size` | `64M` / `64M` | Subir imágenes de producto y plugins en ZIP. |
| `memory_limit` | `256M` | Margen para plugins como UpdraftPlus. |
| `max_execution_time` | `120` | Copias de seguridad y actualizaciones largas. |

Problemas típicos y solución (los que hay que documentar si aparecen):

| Error | Causa | Solución |
|:------|:------|:---------|
| Apache no arranca: *Port 80 in use* | IIS, Skype, otro servidor | **Netstat** del panel para ver quién lo usa; pararlo, o cambiar `Listen 80` a `8080` en `httpd.conf`. |
| *MySQL shutdown unexpectedly* | Puerto 3306 ocupado por otro MySQL, o tablas de sistema dañadas | Parar el otro servicio; en el segundo caso, copiar los archivos de `mysql\backup` sobre `mysql\data` (salvo las carpetas de bases de datos propias). |
| Aviso de UAC al instalar | Carpeta protegida | Instalar en `C:\xampp`. |

## Parte 2. WordPress

### 4. Base de datos y usuario con phpMyAdmin

**Cuentas de usuario → Agregar cuenta de usuario**:

| Campo | Valor |
|:------|:------|
| Nombre de usuario | `wp_tienda` |
| Nombre del host | **Local** (`localhost`) |
| Contraseña | Generada o robusta |
| Base de datos para la cuenta de usuario | ☑ **Crear base de datos con el mismo nombre y otorgar todos los privilegios** |
| Privilegios globales | Ninguno |

Resultado: base de datos `wp_tienda` y usuario `wp_tienda@localhost` con todos los permisos **solo** sobre ella. También vale crear la base de datos (cotejamiento `utf8mb4_unicode_ci`) y el usuario por separado y darle los privilegios después.

Nota de seguridad (para el nivel 4): en XAMPP `root` no tiene contraseña. No es un problema en local, pero hay que saberlo y no reutilizar esa configuración en un servidor accesible desde la red.

### 5. Instalación

1. Descargar WordPress en español (`es.wordpress.org`) y descomprimir en `C:\xampp\htdocs\tienda` (`/opt/lampp/htdocs/tienda`).
2. `http://localhost/tienda` → idioma → datos de la base de datos → **Ejecutar la instalación** → título, administrador (no `admin`), contraseña, correo, «Pedir a los motores de búsqueda que no indexen este sitio» → **Instalar WordPress** → **captura de la pantalla final** («¡Lo lograste!»), que pide la memoria.

**Cada paso y su efecto (nivel 4 de 2c):**

| Paso del asistente | Efecto |
|:-------------------|:-------|
| Nombre de la BD, usuario, contraseña, servidor | Se escriben `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST` en `wp-config.php` (que el asistente crea a partir de `wp-config-sample.php`). |
| Prefijo de tabla | Variable `$table_prefix` en `wp-config.php` y nombre de las 12 tablas que se crean (`wp_posts`, `wp_users`…). |
| (automático) | Ocho claves aleatorias `AUTH_KEY`… en `wp-config.php`. |
| Título del sitio | Opción `blogname` en la tabla `wp_options`. |
| Usuario, contraseña (cifrada) y correo | Fila en `wp_users` y su rol en `wp_usermeta` (`wp_capabilities`). |
| Visibilidad en buscadores | Opción `blog_public = 0` en `wp_options`. |
| Dirección del sitio | Opciones `siteurl` y `home` en `wp_options`: por eso no se debe cambiar luego la carpeta sin actualizarlas. |

Errores habituales en XAMPP:

| Error | Causa | Solución |
|:------|:------|:---------|
| «Error al establecer una conexión con la base de datos» | Usuario o contraseña distintos; usuario creado con host `%` cuando hay un usuario anónimo en `localhost` | Revisar `wp-config.php`; crear el usuario con host **localhost**. |
| «No se puede escribir en el archivo wp-config.php» (Linux) | La carpeta es de `root` y Apache de XAMPP se ejecuta como `daemon` | Paso 6, o copiar a mano el texto que muestra el asistente. |
| Página en blanco o error de PHP | Versión de PHP incompatible con un plugin | `Salud del sitio`, `wp-content/debug.log` con `WP_DEBUG_LOG`. |

### 6. Configuración inicial y permisos

- **Ajustes → Generales**: título «ElectroHogar», descripción, **Idioma del sitio** Español, **Zona horaria** Madrid.
- **Ajustes → Enlaces permanentes → Nombre de la entrada** (XAMPP trae `mod_rewrite` activo y `AllowOverride All`).
- **Permisos para instalar plugins:**
  - **Windows:** no hace falta tocar nada si XAMPP está en `C:\xampp`; Apache escribe en `htdocs`. Comprobación: instalar un plugin no pide datos FTP.
  - **Linux:** `sudo chown -R daemon:daemon /opt/lampp/htdocs/tienda` (Apache de XAMPP se ejecuta como `daemon`; se comprueba con `grep ^User /opt/lampp/etc/httpd.conf`), carpetas 755 y archivos 644. Si WordPress pide **«credenciales de conexión FTP»** al instalar un plugin, es este problema. `define('FS_METHOD','direct')` en `wp-config.php` **no** lo arregla si Apache no puede escribir; y `chmod -R 777` funciona pero es el error que hay que señalar.

## Parte 3. Contenidos y navegación

### 7. Páginas

| Página | Contenido | Autor de referencia |
|:-------|:----------|:--------------------|
| Sobre nosotros | Texto, una imagen (bloque Imagen con texto alternativo) y enlaces a las secciones | Administradora |
| Contacto | Texto, imagen (mapa o fachada) y enlace `mailto:` o a redes | Administradora |
| Móviles, Ordenadores, Cocina, Decoración | Solo título | Editora |

Borrar o pasar a borrador la «Página de ejemplo» y la entrada «Hola, mundo», o asignarles categoría: el requisito dice «al menos una categoría a **cada** contenido».

### 8. Categorías, también en páginas

**Entradas → Categorías**: *Electrónica* (con *Móviles* y *Ordenadores*), *Hogar* (con *Cocina* y *Decoración*) y una categoría para las páginas informativas (*Información*). Renombrar «Sin categoría».

**El problema:** las páginas no tienen categorías en WordPress. Opciones:

| Solución | Valoración |
|:---------|:-----------|
| Plugin del repositorio, p. ej. **Pages with category and tag** (50 000+ instalaciones, probado hasta WordPress 7.1.4) | Fácil de instalar y explicar. Pero su código no cambia desde 2018 y su ficha dice que no tiene funciones de visualización: hay que **comprobar** si los archivos de categoría muestran las páginas; si no, completar con la opción siguiente o enlazar el menú a páginas. |
| **Plugin propio mínimo** (`archivos/categorias-en-paginas`, dos funciones: `register_taxonomy_for_object_type('category','page')` y añadir `page` a la consulta de los archivos de categoría) | Lo hace todo, sin dependencias de terceros, y se entiende leyéndolo. Es la solución de referencia. Se instala subiendo el ZIP en **Plugins → Añadir nuevo plugin → Subir plugin**. |
| Fragmento de código con **Code Snippets** | Equivalente al anterior, pero añade otro plugin (se ve en la UP4). |
| Usar **páginas superiores** (Móviles como hija de una página Electrónica) | No son categorías: no cumple el requisito, aunque organiza las URL. |

Comprobado con el plugin propio: el panel **Categorías** aparece al editar páginas; `/category/electronica/` lista *Móviles* y *Ordenadores*; al desactivarlo, el archivo sale vacío y los datos se conservan (se recuperan al reactivarlo).

Cómo añadir una subcategoría nueva (lo pide el vídeo): **Entradas → Categorías** → nombre (*Televisores*), **Categoría superior: Electrónica** → **Añadir nueva categoría**; después, crear la página, marcarle la categoría y añadirla al menú.

### 9. Tema y menú de tres niveles

**Tema:** cualquiera distinto del activo por defecto (en WordPress 7.1, Twenty Twenty-Five), por ejemplo **Twenty Twenty-Four** (de bloques, sin plugins) o **Astra / Kadence** (populares, con menú clásico). Justificación esperable: adaptable a móviles, mantenido, gratuito, que admita menús de varios niveles y un diseño adecuado a una tienda.

**Menú** (tema de bloques: **Apariencia → Editor → Navegación**; clásico: **Apariencia → Menús**):

```
Inicio                       → portada
Productos                    → sin destino (solo despliega)  ·  o página «Productos»
├── Electrónica              → archivo de la categoría Electrónica
│   ├── Móviles              → página Móviles
│   └── Ordenadores          → página Ordenadores
└── Hogar                    → archivo de la categoría Hogar
    ├── Cocina               → página Cocina
    └── Decoración           → página Decoración
Sobre nosotros               → página
Contacto                     → página
```

En el editor de bloques, cada nivel se crea con **Añadir submenú** sobre el elemento padre; en el menú clásico, arrastrando cada elemento un paso más a la derecha. Comprobado en Twenty Twenty-Four: los nueve enlaces responden 200 y el tercer nivel se despliega.

**Nivel 4 de 2e:** el recorrido del vídeo pasa por todas las opciones sin 404 ni páginas vacías, el pie no tiene enlaces de demostración, y logo, colores y textos encajan con una tienda.

## Parte 4. Usuarios y grupos

### 10. Usuarios

Equipo verosímil (nivel 4 de 3b):

| Usuario | Rol | Quién es | Qué puede hacer |
|:--------|:----|:---------|:----------------|
| `gerente` | Administrador | Dueña de la tienda | Todo: plugins, tema, ajustes, usuarios. |
| `lsanz` | Editor | Responsable de contenidos | Crear y editar páginas y entradas de todos, categorías, comentarios. |
| `dperez` | Autor | Dependiente de electrónica | Publicar sus entradas (ofertas, novedades) y subir imágenes; no crea páginas. |
| `mgil` | Autor | Dependienta de hogar | Ídem. |
| `ajimenez` | Colaborador | Alumno en prácticas | Escribir entradas que revisa la editora; no publica ni sube archivos. |
| `cliente1` | Suscriptor | Cliente registrado | Solo su perfil. |

### 11. Grupos (plugin Groups)

**Plugins → Añadir nuevo plugin → «Groups» (itthinx) → Instalar → Activar**. Menú **Groups → Groups → Add / Nuevo grupo**:

| Grupo | Miembros | Para qué |
|:------|:---------|:---------|
| Equipo de tienda | `dperez`, `mgil`, `ajimenez` | Personal del local: restringir a ellos una página interna (turnos, procedimientos). |
| Contenidos web | `lsanz`, `dperez`, `mgil` | Quienes publican en la web: avisos y documentación para redactar. |

Añadir usuarios: **Usuarios → marcar → Acciones de grupo → Añadir al grupo** (o en el perfil de cada usuario). Comprobado: grupos con 3 miembros cada uno; un usuario puede estar en varios.

**Roles frente a grupos (para el vídeo, nivel 3):** el **rol** dice **qué puede hacer** una persona (publicar, editar de otros…); el **grupo** dice **a qué pertenece**, y con Groups sirve para **restringir el acceso** a contenidos (caja *Groups* al editar una página → solo miembros del grupo) o asignar capacidades a todos sus miembros a la vez.

## Parte 5. Copias de seguridad

### 12. Copia completa

**Plugins → Añadir nuevo plugin → UpdraftPlus → Instalar → Activar** → **Ajustes → Copias de seguridad de UpdraftPlus → Copia de seguridad ahora** → marcar **base de datos** y **archivos** → **Copia de seguridad ahora**.

Qué incluye (nivel 3 de 3d): cinco archivos en `wp-content/updraft`:

| Archivo | Contenido |
|:--------|:----------|
| `backup_<fecha>_<sitio>_<id>-db.gz` | Base de datos completa: páginas, categorías, menús, usuarios, grupos, ajustes. |
| `…-plugins.zip` | Carpeta `wp-content/plugins`. |
| `…-themes.zip` | Carpeta `wp-content/themes`. |
| `…-uploads.zip` | Imágenes y archivos subidos. |
| `…-others.zip` | El resto de `wp-content`. |

**No incluye** el núcleo de WordPress ni `wp-config.php` (en la versión gratuita): se reinstalan.

### 13. Copias diarias, y cómo pasarlas a semanales

**Ajustes** → *Programación de la copia de archivos*: **Diaria**, conservar 7 · *Programación de la copia de la base de datos*: **Diaria**, conservar 14 → **Guardar cambios**. En la pestaña principal aparece «Próximas copias programadas».

Para el vídeo: cambiar *Diaria* por **Semanal** en archivos (y si se quiere en base de datos) → **Guardar cambios** → la próxima fecha cambia.

En XAMPP las copias programadas dependen de WP-Cron: solo se ejecutan cuando alguien visita el sitio con XAMPP encendido.

**Dónde guardarlas y cómo comprobarlas (nivel 4):** destino remoto en **Ajustes → Elige tu almacenamiento remoto** (Google Drive o Dropbox en la versión gratuita; un solo destino por copia), porque `wp-content/updraft` está en el mismo disco; regla 3-2-1; comprobar cada mes **restaurando** en otra instalación de XAMPP (o, como mínimo, descargando la copia y abriendo los ZIP y el `.gz`).
