---
layout: doc
title: "Solución P2.5 — Instalación de Moodle"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P2.5 — Instalación de Moodle

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P2.5 Moodle](../ejercicios/5-moodle).
:::

- **Unidad:** UP2 · RA2 · CE 2b, 2c, 2e, 2g.
- **Punto de partida:** el servidor Ubuntu 24.04 de la UP1 (Apache 2.4, PHP 8.3, MariaDB 10.11).
- **Archivos de la solución** (todo probado con **Moodle 5.2.4+** en Ubuntu 24.04):
  - <a :href="withBase('/soluciones/up2/p2.5-moodle/archivos/moodle.conf')" download><code>archivos/moodle.conf</code></a>: *virtual host* con la carpeta `public` y el enrutador.
  - <a :href="withBase('/soluciones/up2/p2.5-moodle/archivos/config.php')" download><code>archivos/config.php</code></a>: `config.php` de referencia.
  - <a :href="withBase('/soluciones/up2/p2.5-moodle/archivos/moodle-cron')" download><code>archivos/moodle-cron</code></a>: tarea programada (para `/etc/cron.d/`).
  - <a :href="withBase('/soluciones/up2/p2.5-moodle/archivos/curso-modelo.php')" download><code>archivos/curso-modelo.php</code></a>: crea con la API de Moodle la categoría, el curso, el recurso, la actividad y el estudiante de referencia.

::: danger Tres cambios de Moodle que el enunciado no recoge
1. **«Última versión estable» no es instalable en el servidor de la UP1.** Moodle 5.3 (5/10/2026) exige **MariaDB 11.4**; Ubuntu 24.04 trae la 10.11. Opciones: instalar **Moodle 5.2** (exige PHP 8.3 y MariaDB 10.11: encaja) —la de esta solución— o añadir el repositorio oficial de MariaDB 11.4. Conviene decirlo en el enunciado.
2. **Desde Moodle 5.1 el código tiene una carpeta `public`** y el `DocumentRoot` debe apuntar a **`/var/www/moodle/public`**, no a `/var/www/moodle`. Con la configuración de siempre, el sitio no funciona bien.
3. **El enrutador de Moodle** necesita que las URL que no son archivos lleguen a `r.php`. La configuración que propone la documentación (`FallbackResource /r.php`) **no basta con `mod_php`**: comprobado, las rutas que terminan en `.php` siguen dando 404 y la comprobación de Moodle marca *Router configuration* como **ERROR**. Funciona con la variante de `mod_rewrite` (apartado 5).
:::

---

## 1. Requisitos y `max_input_vars`

Fuente: [notas de la versión 5.2](https://moodledev.io/general/releases/5.2) (y [5.3](https://moodledev.io/general/releases/5.3)).

| Requisito | Moodle 5.2 | Moodle 5.3 | Servidor UP1 |
|:----------|:-----------|:-----------|:-------------|
| PHP | 8.3 mínimo, 8.4 admitido, solo 64 bits | 8.3 mínimo | 8.3 ✅ |
| MariaDB | **10.11** | **11.4** | 10.11 → ✅ 5.2 / ❌ 5.3 |
| MySQL / PostgreSQL | 8.4 / 16 | 8.4 / 17 | — |
| `max_input_vars` | ≥ 5000 | ≥ 5000 | 1000 por defecto ❌ |
| Extensiones | `sodium` obligatoria; además `iconv`, `mbstring`, `curl`, `openssl`, `ctype`, `zip`, `zlib`, `gd`, `simplexml`, `spl`, `pcre`, `dom`, `xml`, `xmlreader`, `intl`, `json`, `hash`, `fileinfo` | Igual | Faltan normalmente `zip`, `intl`, `gd`, `soap` |

```bash
sudo apt install -y php-intl php-zip php-gd php-soap php-xml php-mbstring php-curl php-mysql
php -m | grep -iE "sodium|intl|zip|gd|soap"
```

`max_input_vars` **en los dos** `php.ini` (web y CLI, porque el *cron* y las herramientas de Moodle usan la CLI):

```bash
for ini in /etc/php/8.3/apache2/php.ini /etc/php/8.3/cli/php.ini; do
  sudo sed -i 's/^;\?\s*max_input_vars\s*=.*/max_input_vars = 5000/' "$ini"
  grep -n "^max_input_vars" "$ini"
done
sudo systemctl restart apache2
```

Por qué (nivel 3): `max_input_vars` limita el número de campos que PHP acepta en un formulario. Algunas pantallas de Moodle (permisos de un rol, ajustes de un curso con muchas actividades, calificador) envían miles de campos; con 1000, PHP descarta el resto **sin avisar** y se guardan datos incompletos.

## 2. Base de datos

```sql
CREATE DATABASE moodle CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'moodle_user'@'localhost' IDENTIFIED BY '********';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, CREATE TEMPORARY TABLES, DROP, INDEX, ALTER
  ON moodle.* TO 'moodle_user'@'localhost';
```

Lista de permisos de la documentación de Moodle (más restrictiva que `ALL`); también se acepta `ALL PRIVILEGES ON moodle.*`. Moodle exige `utf8mb4`.

## 3. Descarga

**Desde [download.moodle.org](https://download.moodle.org)** (recomendado): el paquete `.tgz` de la rama 5.2 **ya incluye las dependencias** (carpeta `vendor`).

```bash
cd /tmp
wget https://download.moodle.org/download.php/direct/stable502/moodle-latest-502.tgz
tar -xzf moodle-latest-502.tgz
sudo mv moodle /var/www/moodle
sudo chown -R root:root /var/www/moodle
sudo chmod -R a+rX /var/www/moodle
```

**Desde Git** (también válido): `git clone -b MOODLE_502_STABLE https://github.com/moodle/moodle.git`. Desde la 5.1, el repositorio **no** incluye `vendor`: hay que ejecutar `composer install --no-dev --classmap-authoritative` o la instalación falla. Comprobado al preparar la solución.

Propietario del código: `root` (o el administrador) y **sin escritura para `www-data`**, como recomienda Moodle. Consecuencia: el instalador web no podrá crear `config.php` y mostrará su contenido para copiarlo a mano (apartado 6). Si el alumnado hace `chown -R www-data` sobre el código, funciona, pero una vulnerabilidad permitiría modificarlo: comentarlo.

## 4. Directorio de datos

```bash
sudo mkdir /var/moodledata
sudo chown -R www-data:www-data /var/moodledata
sudo chmod 770 /var/moodledata
```

Fuera de `/var/www`: así **ninguna URL** llega a él. Moodle sirve los archivos de `moodledata` a través de `pluginfile.php`, que comprueba antes los permisos del usuario. Si estuviera en la carpeta pública, cualquiera podría descargar entregas o materiales escribiendo la ruta (lo que explica el enunciado). El instalador comprueba además que `dataroot` no sea accesible por web.

## 5. *Virtual host*

`archivos/moodle.conf`:

```apache
<VirtualHost *:80>
    ServerName moodle.empresa.local
    DocumentRoot /var/www/moodle/public

    <Directory /var/www/moodle/public>
        Options -Indexes +FollowSymLinks
        AllowOverride None
        Require all granted
        DirectoryIndex index.php

        # Enrutador de Moodle: lo que no sea un archivo o carpeta real va a r.php.
        # (Con mod_php, FallbackResource no atiende rutas que acaban en .php.)
        RewriteEngine On
        RewriteBase /
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteCond %{REQUEST_URI} !^/r\.php
        RewriteRule ^(.*)$ r.php/$1 [L,QSA]
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/moodle_error.log
    CustomLog ${APACHE_LOG_DIR}/moodle_access.log combined
</VirtualHost>
```

```bash
sudo a2enmod rewrite
sudo a2ensite moodle
sudo apache2ctl configtest && sudo systemctl restart apache2
echo "127.0.0.1 moodle.empresa.local" | sudo tee -a /etc/hosts   # el servidor también debe resolver su nombre
```

Y en el cliente Windows, `10.0.2.100 moodle.empresa.local` en `hosts`.

Ventaja de la carpeta `public` (para explicarla): `config.php` (con la contraseña de la base de datos), `vendor`, `composer.json` y los scripts de `admin/cli` quedan **fuera** del alcance del navegador. Comprobado: `/composer.json`, `/vendor/autoload.php`, `/config-dist.php` → 404.

La línea de `/etc/hosts` del servidor sirve para que Moodle pueda hacer peticiones a su propia URL (comprobaciones del enrutador, tareas). Sin ella, algunas comprobaciones de la página de notificaciones fallan.

## 6. Instalación desde el navegador

`http://moodle.empresa.local` → `install.php`:

| Pantalla | Valor |
|:---------|:------|
| Idioma | Español - Internacional (es) |
| Rutas | Dirección web `http://moodle.empresa.local`; directorio de Moodle `/var/www/moodle`; directorio de datos `/var/moodledata` |
| Controlador de BD | MariaDB («native/mariadb») |
| Ajustes de BD | `localhost`, `moodle`, `moodle_user`, contraseña, prefijo `mdl_` |
| `config.php` | Si no puede escribirlo, **Moodle muestra el contenido**: crear `/var/www/moodle/config.php` con él (`archivos/config.php`) y continuar |
| Licencia | Aceptar (GPLv3) |
| Comprobación del servidor | Todo «OK»; si algo es «Debe estar instalado y activado», volver al paso 1 |
| Instalación de módulos | Varios minutos; no recargar |
| Administrador | Usuario distinto de `admin`, contraseña que cumpla la política (8+ caracteres, mayúscula, número, símbolo), correo |
| Página principal | Nombre completo y corto del sitio, zona horaria |

Añadir a `config.php`, antes del `require_once`, **`$CFG->routerconfigured = true;`** cuando el enrutador esté configurado.

## 7. Nombre, idioma y zona horaria

- **Administración del sitio → Página principal → Ajustes de la página principal**: nombre completo «Centro de formación de la empresa», nombre corto «Formación».
- **Administración del sitio → Idioma → Paquetes de idioma**: instalar **Español - Internacional (es)** (si no se eligió en el instalador, Moodle lo descarga). Después **Ajustes de idioma → Idioma por defecto: es**.
- **Administración del sitio → Ubicación → Ajustes de ubicación**: **Zona horaria por defecto: Europe/Madrid**; opcional **Forzar zona horaria** si toda la plantilla está en España.

## 8. *Cron*

`/etc/cron.d/moodle` (`archivos/moodle-cron`):

```
* * * * * www-data /usr/bin/php /var/www/moodle/admin/cli/cron.php >/dev/null 2>&1
```

Equivalente: `sudo crontab -u www-data -e` con la línea sin el campo de usuario.

```bash
sudo -u www-data php /var/www/moodle/admin/cli/cron.php | tail -3   # prueba manual: «Cron run completed correctly»
```

Se ejecuta como **`www-data`** para que los archivos que cree en `moodledata` tengan el propietario correcto. Si se ejecuta como `root`, después Apache no podrá leerlos o modificarlos.

Qué hace el *cron* (nivel 3): envía correos y notificaciones, procesa las copias de seguridad automáticas, limpia temporales y sesiones, calcula calificaciones e informes, y ejecuta las tareas «ad hoc» de los plugins. Sin él, Moodle parece funcionar pero los foros no envían correo, las copias no se hacen y la página de notificaciones avisa en rojo.

Comprobación: **Administración del sitio → Notificaciones** deja de mostrar «El script cron.php no se ha ejecutado…», y **Servidor → Tareas → Tareas programadas** muestra «Última ejecución» de hace segundos.

## 9. Curso de prueba

Desde el navegador:

1. **Administración del sitio → Cursos → Gestionar cursos y categorías → Crear nueva categoría**: «Formación interna».
2. **Crear nuevo curso** en esa categoría: nombre completo, nombre corto, **Formato: Temas**, **Número de secciones: 2**. Renombrar las secciones (Tema 1, Tema 2).
3. **Modo de edición** → en el tema 1, **Añadir una actividad o recurso → Página** (recurso); en el tema 2, **Tarea** (actividad).
4. **Administración del sitio → Usuarios → Añadir usuario**: `estudiante1`.
5. En el curso: **Participantes → Matricular usuarios** → `estudiante1` con rol **Estudiante**.

`archivos/curso-modelo.php` hace lo mismo por API (comprobado: crea el curso `PRL-OFI`, la página, la tarea y la matrícula):

```bash
sudo -u www-data php curso-modelo.php /var/www/moodle
```

Diferencia que debe quedar clara: **recurso** = material que el estudiante consulta (página, archivo, URL, carpeta); **actividad** = algo que hace y se puede calificar o seguir (tarea, cuestionario, foro).

### Estructura de categorías y secciones (nivel 3 y 4 de CE 2e)

Respuesta de referencia: categorías por **área o departamento** del centro de formación (Formación interna, Prevención, Informática…), porque a cada categoría se le pueden asignar gestores y permisos propios; dentro del curso, una sección por **tema o semana** con la misma estructura (presentación, material, actividad, evaluación). Si el curso de prueba se presenta como **plantilla** que se copiará (*Restaurar* o *Importar*) para los demás cursos, es nivel 4.

## 10. Acceso como estudiante

Ventana privada → `estudiante1`. Comprobado al preparar la solución con los dos perfiles:

| | Administrador | Estudiante |
|:--|:--------------|:-----------|
| Interruptor **Modo de edición** | Sí | No |
| Menú **Configuración** del curso, *Informes*, *Banco de preguntas* | Sí | No |
| **Participantes** | Sí, con *Matricular usuarios* | Sí, solo para ver la lista (permiso por defecto del rol) |
| **Calificaciones** | Calificador de todos | Solo las suyas |
| Tarea | Ver entregas y calificar | **Añadir entrega** |
| Administración del sitio | Sí | No existe |

Por qué (nivel 3): Moodle asigna **roles por contexto**. `estudiante1` es «Estudiante» solo en ese curso; fuera no tiene ningún rol y no ve otros cursos ni la administración. El administrador tiene permisos en el contexto del sitio, que se heredan hacia abajo.

## 11. Página de notificaciones (nivel 4 de CE 2g)

**Administración del sitio → Notificaciones** y **Informes → Comprobaciones del sistema** (o `sudo -u www-data php admin/cli/checks.php`). En la instalación de prueba aparecieron:

| Aviso | Causa | ¿Se resuelve en el servidor? |
|:------|:------|:-----------------------------|
| *Router configuration* — **ERROR** | `FallbackResource` no basta con `mod_php` | **Sí**: reglas `mod_rewrite` del apartado 5 + `$CFG->routerconfigured = true;`. |
| *Cron running* — **CRÍTICO** | Sin tarea programada | **Sí**: apartado 8. |
| *Secure cookies* — aviso | El sitio funciona por HTTP | **Sí**, con HTTPS (certificado autofirmado en el laboratorio). |
| *Executable paths* — aviso | Rutas a programas externos editables desde la web | Sí: `$CFG->preventexecpath = true;` en `config.php`. |
| *Backup of user data* — aviso | Roles que pueden copiar datos de usuarios | No es del servidor: decisión de configuración de roles. |
| Paquete de idioma / registro del sitio | — | Decisión de la plataforma, no del servidor. |

---

## Comparación con WordPress (CE 2b)

| Aspecto | Moodle | WordPress |
|:--------|:-------|:----------|
| **Finalidad** | Plataforma de aprendizaje (LMS): cursos, actividades evaluables, calificaciones, seguimiento del progreso. | CMS generalista: publicar páginas y entradas para visitantes; blogs, webs corporativas, tiendas con WooCommerce. |
| **Organización de los contenidos** | Categorías → cursos → secciones → recursos y actividades. El contenido vive **dentro de un curso**. | Páginas jerárquicas y entradas con categorías y etiquetas; menús que enlazan. El contenido es **público** por defecto. |
| **Usuarios** | Muchos usuarios que **trabajan** en la plataforma; matrícula por curso; **roles por contexto** (sitio, categoría, curso, actividad) muy detallados; grupos. | Pocos usuarios que **publican** y muchos visitantes anónimos; roles globales fijos (administrador, editor, autor, colaborador, suscriptor). |
| **Interacción** | Entregas, cuestionarios, foros, calificaciones, finalización, insignias. | Comentarios; lo demás, con plugins. |
| **Requisitos** | Más exigente: `max_input_vars`, *cron* obligatorio, directorio de datos aparte, más memoria. | Ligero; funciona en casi cualquier alojamiento compartido. |
| **Licencia** | GPLv3 | GPLv2 o posterior |

**Cuándo usar cada uno (nivel 3):** Moodle cuando hay que **formar y evaluar** a personas identificadas y seguir su progreso; WordPress cuando hay que **comunicar** contenidos. Un LMS hecho con WordPress (plugins como LearnDash o Tutor LMS) sirve para cursos sencillos o de pago; uno con Moodle para formación reglada o corporativa con evaluación.

**Aplicado al encargo (nivel 4):** el centro de formación necesita cursos con matrícula, actividades evaluables y seguimiento de cada empleado → **Moodle**. El portal interno de la UP2 (avisos, incidencias, documentos) seguiría en **WordPress**; se pueden enlazar entre sí (enlace en el menú del portal, o autenticación común con LDAP en una fase posterior).
