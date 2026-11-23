---
layout: doc
title: "Solución P2.4 — WordPress en un servidor LAMP"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P2.4 — WordPress en un servidor LAMP

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P2.4 WordPress en LAMP](../ejercicios/4-wordpress-lamp).
:::

- **Unidad:** UP2 · RA2 · CE 2c, 2e, 2f, 2g.
- **Punto de partida:** el servidor Ubuntu de la UP1 (Apache 2.4, PHP 8.3, MariaDB 10.11), en la Red NAT `10.0.2.0/24` con IP `10.0.2.100`, como en los contenidos.
- **Archivos de la solución** (todo probado con WordPress 7.1.4 en Ubuntu 24.04):
  - <a :href="withBase('/soluciones/up2/p2.4-wordpress-lamp/archivos/wp-intranet.conf')" download><code>archivos/wp-intranet.conf</code></a>: *virtual host*.
  - <a :href="withBase('/soluciones/up2/p2.4-wordpress-lamp/archivos/wp-config-cambios.php')" download><code>archivos/wp-config-cambios.php</code></a>: cambios de `wp-config.php`.
  - <a :href="withBase('/soluciones/up2/p2.4-wordpress-lamp/archivos/error-prueba/error-prueba.php')" download><code>archivos/error-prueba/error-prueba.php</code></a>: plugin que provoca un aviso de PHP.
  - <a :href="withBase('/soluciones/up2/p2.4-wordpress-lamp/archivos/verificar-wp.sh')" download><code>archivos/verificar-wp.sh</code></a>: lista de verificación automática (servidor, archivos, `wp-config.php`, web y base de datos).

---

## 1. Requisitos de WordPress frente al servidor

Fuente: [wordpress.org/about/requirements](https://wordpress.org/about/requirements/) y `wp-includes/version.php` del paquete descargado.

| Requisito | WordPress 7.1 | Servidor | ¿Cumple? |
|:----------|:--------------|:---------|:--------:|
| PHP | Recomendado 8.3+; mínimo que acepta el instalador: 7.4 | `php -v` → 8.3.6 | ✅ |
| Base de datos | Recomendado MySQL 8.0+ o MariaDB 10.11+; mínimo 5.5.5 | `mariadb --version` → 10.11 | ✅ |
| Servidor web | Apache o Nginx; `mod_rewrite` para enlaces permanentes | Apache 2.4 + `a2enmod rewrite` | ✅ (paso 4) |
| HTTPS | Recomendado | No en el laboratorio | ⚠ documentar |
| Extensiones | `mysqli`, `curl`, `dom`, `exif`, `fileinfo`, `hash`, `imagick` o `gd`, `intl`, `mbstring`, `openssl`, `xml`, `zip` | `php -m` | Instalar las que falten |

```bash
php -v
mariadb --version
php -m | grep -iE "mysqli|curl|dom|exif|fileinfo|imagick|gd|intl|mbstring|openssl|xml|zip"
sudo apt install -y php-curl php-xml php-mbstring php-zip php-intl php-gd php-imagick
sudo systemctl restart apache2
```

De la UP1 ya estaban `php-mysql`, `php-mbstring`, `php-xml`, `php-curl`; faltan normalmente `php-zip`, `php-intl`, `php-gd`/`php-imagick`. Contrastarlo con la tabla es el nivel 4 de CE 2c.

## 2. Base de datos y usuario

```bash
sudo mariadb
```

```sql
CREATE DATABASE wp_intranet CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'wp_intranet_user'@'localhost' IDENTIFIED BY '********';
GRANT ALL PRIVILEGES ON wp_intranet.* TO 'wp_intranet_user'@'localhost';
SHOW GRANTS FOR 'wp_intranet_user'@'localhost';
```

## 3. Descarga, propietarios y permisos

```bash
cd /tmp
wget https://es.wordpress.org/latest-es_ES.tar.gz
tar -xzf latest-es_ES.tar.gz
sudo mv wordpress /var/www/wp-intranet
sudo chown -R www-data:www-data /var/www/wp-intranet
sudo find /var/www/wp-intranet -type d -exec chmod 755 {} \;
sudo find /var/www/wp-intranet -type f -exec chmod 644 {} \;
ls -l /var/www/wp-intranet | head
```

### Función de propietarios y permisos (nivel 3)

- Apache se ejecuta como **`www-data`**. Si es el propietario, WordPress puede escribir: subir medios a `wp-content/uploads`, instalar plugins y temas, actualizarse y crear `.htaccess` y `wp-config.php`.
- **755** en carpetas (el propietario entra y escribe; el resto solo entra y lista) y **644** en archivos (el propietario escribe; el resto solo lee). Nunca **777**: cualquier proceso del sistema podría modificar el código.
- Alternativa más segura y también correcta: el código propiedad de un usuario administrador y solo `wp-content` de `www-data`. Así, una vulnerabilidad en PHP no puede reescribir el núcleo; a cambio, las actualizaciones se hacen por SSH o WP-CLI. Si alguien la usa y la explica, es nivel 3–4.

## 4. *Virtual host* y `rewrite`

`/etc/apache2/sites-available/wp-intranet.conf` (`archivos/wp-intranet.conf`):

```apache
<VirtualHost *:80>
    ServerName wp.empresa.local
    DocumentRoot /var/www/wp-intranet

    <Directory /var/www/wp-intranet>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/wp-intranet_error.log
    CustomLog ${APACHE_LOG_DIR}/wp-intranet_access.log combined
</VirtualHost>
```

```bash
sudo a2ensite wp-intranet
sudo a2enmod rewrite
sudo apache2ctl configtest
sudo systemctl restart apache2     # tras activar un módulo, restart (es lo que indica a2enmod)
```

En el cliente Windows, `C:\Windows\System32\drivers\etc\hosts`: `10.0.2.100   wp.empresa.local`.

### `AllowOverride` y `mod_rewrite` (nivel 3)

- **`mod_rewrite`** reescribe la URL pedida antes de buscar el archivo: `/hola-mundo/` no existe en el disco y se convierte internamente en `index.php`, que decide qué contenido mostrar.
- WordPress escribe esas reglas en **`.htaccess`**. Apache solo lee los `.htaccess` si **`AllowOverride`** lo permite; `All` deja que el archivo cambie cualquier directiva.
- Comprobado al preparar la solución: con `AllowOverride None` **o** sin `mod_rewrite`, `/hello-world/` da **404** aunque WordPress funcione con `?p=1`.

## 5. Asistente con prefijo `intra_`

`http://wp.empresa.local` → Español → base de datos `wp_intranet`, usuario `wp_intranet_user`, servidor `localhost`, **prefijo `intra_`** → título y administrador.

::: warning Permisos de wp-config.php
Comprobado: el asistente crea `wp-config.php` con permisos **666** (`-rw-rw-rw-`), legible y modificable por cualquier usuario del sistema, y contiene la contraseña de la base de datos. Corregirlo al terminar:
`sudo chmod 640 /var/www/wp-intranet/wp-config.php` (propietario `www-data` lee y escribe, grupo lee, el resto nada). Señalarlo es indicador de nivel 4 en seguridad.
:::

## 6. Cambios en `wp-config.php`

Archivo `archivos/wp-config-cambios.php`. Hay que **sustituir** la línea `define( 'WP_DEBUG', false );` que ya existe (si se añade otra, PHP avisa de «Constant WP_DEBUG already defined» y vale la primera) y añadir el resto antes de `/* That's all, stop editing! */`:

```php
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', '/var/log/wordpress/wp-intranet-debug.log' );
define( 'WP_DEBUG_DISPLAY', false );
@ini_set( 'display_errors', 0 );

/* Add any custom values between this line and the "stop editing" line. */
define( 'DISALLOW_FILE_EDIT', true );
define( 'WP_POST_REVISIONS', 5 );
```

```bash
sudo mkdir -p /var/log/wordpress
sudo chown www-data:adm /var/log/wordpress && sudo chmod 750 /var/log/wordpress
```

### Qué constante controla cada cambio (nivel 3)

| Constante | Efecto | Demostración |
|:----------|:-------|:-------------|
| `DISALLOW_FILE_EDIT` | Quita *Editor de archivos de temas* y *de plugins* y la capacidad `edit_themes`/`edit_plugins`, incluso al administrador. | Los menús desaparecen. Comprobado: `current_user_can('edit_themes')` → `false`. |
| `WP_POST_REVISIONS` | Número máximo de revisiones por entrada o página. `false` las desactiva; `true` o sin definir, ilimitadas. | Editar una entrada 8 veces → **5** revisiones en la base de datos (comprobado; consulta abajo). |
| `WP_DEBUG` | Activa los avisos de PHP y de WordPress. | |
| `WP_DEBUG_LOG` | `true` → `wp-content/debug.log`; una ruta → ese archivo. | Aparece el registro (paso 9). |
| `WP_DEBUG_DISPLAY` + `display_errors 0` | No mostrar los errores en la página. | La página no muestra el aviso (paso 9). |

```sql
SELECT COUNT(*) FROM intra_posts WHERE post_parent = <ID> AND post_type = 'revision';   -- 5
```

### Por qué así en producción (nivel 4)

- **`WP_DEBUG_LOG => true` deja `debug.log` en `wp-content`, que es público.** Comprobado: `http://wp.empresa.local/wp-content/debug.log` respondía **200** y se podía descargar, con rutas del servidor y detalles internos. Por eso la solución usa una ruta fuera de la carpeta pública (posible desde WordPress 5.1). Si el alumnado deja `true`, como mínimo debe borrar el archivo al terminar.
- Revisiones limitadas: la tabla `posts` no crece sin control en un portal con muchos avisos editados.
- Editor desactivado: ver seguridad.

## 7. Enlaces permanentes

**Ajustes → Enlaces permanentes → Nombre de la entrada** → **Guardar cambios**. WordPress escribe `.htaccess`:

```apache
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
```

Comprobación: `http://wp.empresa.local/hola-mundo/` abre la entrada; `http://wp.empresa.local/?p=1` **redirige (301)** a `/hola-mundo/`.

Si al guardar WordPress dice que no puede escribir `.htaccess`, el propietario no es `www-data` (paso 3).

## 8. Comprobación en la base de datos

```bash
sudo mariadb wp_intranet -e "SHOW TABLES;"
sudo mariadb wp_intranet -e "SELECT option_name, option_value FROM intra_options WHERE option_name IN ('siteurl','home','permalink_structure');"
```

Resultado comprobado:

```
intra_commentmeta  intra_comments  intra_links  intra_options  intra_postmeta  intra_posts
intra_term_relationships  intra_term_taxonomy  intra_termmeta  intra_terms  intra_usermeta  intra_users

home                 http://wp.empresa.local
permalink_structure  /%postname%/
siteurl              http://wp.empresa.local
```

Qué demuestra: las **12 tablas** llevan el prefijo; `siteurl` y `home` guardan la dirección con la que se ejecutó el asistente. Por eso el servidor necesita IP fija y nombre estable: si cambian, WordPress sigue redirigiendo a la dirección guardada (los contenidos lo explican con la Red NAT).

## 9. Error provocado y registro

Plugin `archivos/error-prueba/error-prueba.php`: en el pie de cada página imprime una variable que no existe.

```bash
sudo cp -r error-prueba /var/www/wp-intranet/wp-content/plugins/
sudo chown -R www-data:www-data /var/www/wp-intranet/wp-content/plugins/error-prueba
# Plugins → Activar «Error de prueba (P2.4)» → visitar la portada
sudo tail /var/log/wordpress/wp-intranet-debug.log
```

Línea obtenida en la prueba:

```
[09-Nov-2026 19:24:08 UTC] PHP Warning:  Undefined variable $mensaje in /var/www/wp-intranet/wp-content/plugins/error-prueba/error-prueba.php on line 16
```

- La página se ve normal y el aviso **no** aparece en ella (`WP_DEBUG_DISPLAY false`): eso es lo que se pide demostrar.
- La hora del registro está en **UTC** aunque el sitio esté en Madrid: WordPress fija internamente la zona de PHP a UTC.
- La línea dice qué (*Undefined variable*), dónde (archivo y línea) y cuándo: suficiente para localizarlo.

Después:

```bash
# Plugins → Desactivar y Borrar «Error de prueba»
sudo sed -i "s/define( 'WP_DEBUG', true );/define( 'WP_DEBUG', false );/" /var/www/wp-intranet/wp-config.php
grep -n "WP_DEBUG" /var/www/wp-intranet/wp-config.php
```

Con `WP_DEBUG` en `false`, `WP_DEBUG_LOG` y `WP_DEBUG_DISPLAY` dejan de tener efecto: pueden quedarse o borrarse.

## Seguridad: riesgo de cada mecanismo si se deja activo (nivel 3 de CE 2f)

| Si se deja… | Riesgo |
|:------------|:-------|
| El editor de archivos activo | Quien consiga una cuenta de administrador (contraseña débil, sesión robada) puede escribir PHP en un tema y ejecutar órdenes en el servidor como `www-data`. |
| Los errores en pantalla | Revelan rutas (`/var/www/wp-intranet/...`), versiones, consultas SQL y nombres de plugins: información para preparar un ataque. Además estropean la página. |
| `debug.log` en `wp-content` | Lo mismo, descargable por cualquiera. |
| `WP_DEBUG` activo en producción | Registro creciendo sin control y rendimiento algo peor. |

## Lista de verificación reutilizable (nivel 4 de CE 2g)

`archivos/verificar-wp.sh` comprueba de una vez el servidor (PHP, extensiones, `mod_rewrite`), los archivos (propietario, permisos de `wp-config.php`), `wp-config.php` (editor, revisiones, depuración), la web (portada, enlace permanente, `debug.log` no accesible) y la base de datos (prefijo, `siteurl`/`home`). Salida en el servidor de prueba, al terminar la práctica:

```
== Servidor
  [OK]  PHP 8.3.6 (recomendado 8.3+)
  [OK]  extensión mysqli … [OK] extensión fileinfo
  [OK]  mod_rewrite activo
== Archivos
  [OK]  wp-content es de www-data
  [OK]  wp-config.php con permisos 640
== wp-config.php
  [OK]  editor de archivos desactivado
  [OK]  revisiones limitadas a 5
  [OK]  depuración desactivada
== Web
  [OK]  portada 200
  [OK]  enlace permanente http://wp.empresa.local/hello-world/
  [OK]  debug.log no publicado
== Base de datos
  [OK]  12 tablas con prefijo intra_
  home = http://wp.empresa.local
  siteurl = http://wp.empresa.local
```

El alumnado no tiene que escribir un script: basta con una tabla de comprobaciones con orden y resultado esperado, como la del manual de la P2.1.
