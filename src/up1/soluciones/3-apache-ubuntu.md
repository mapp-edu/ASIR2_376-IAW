---
layout: doc
title: "Solución P1.3 — Instalación de Apache y PHP en Ubuntu"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P1.3 — Instalación de Apache y PHP en Ubuntu

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P1.3 Apache y PHP en Ubuntu](../ejercicios/3-apache-ubuntu).
:::

- **Unidad:** UP1 · RA1 · CE 1c, 1e, 1g, 1i.
- **Archivos de la solución** (probados en Ubuntu 24.04 con Apache 2.4.58 y PHP 8.3):
  - <a :href="withBase('/soluciones/up1/p1.3-apache-ubuntu/archivos/intranet.conf')" download><code>archivos/intranet.conf</code></a>: *virtual host* del sitio.
  - <a :href="withBase('/soluciones/up1/p1.3-apache-ubuntu/archivos/index.html')" download><code>archivos/index.html</code></a>: página del sitio.
  - <a :href="withBase('/soluciones/up1/p1.3-apache-ubuntu/archivos/99-intranet.ini')" download><code>archivos/99-intranet.ini</code></a>: alternativa a editar `php.ini` (ver paso 8).

Se parte del servidor de la P1.2: `servidor-tienda`, IP `192.168.1.50`, usuario con `sudo`, `ufw` activo solo con SSH.

::: tip Versión de PHP
Ubuntu 24.04 instala PHP 8.3 (`/etc/php/8.3/`); Ubuntu 26.04, PHP 8.5 (`/etc/php/8.5/`). Las rutas de esta solución usan 8.3; se acepta cualquiera si coincide con `php -v`.
:::

---

## 1. Instalar Apache

```bash
sudo apt update
sudo apt install -y apache2
apache2 -v                               # Server version: Apache/2.4.58 (Ubuntu)
systemctl status apache2 --no-pager      # Active: active (running)
systemctl is-enabled apache2             # enabled
```

`is-enabled` es la prueba de que «arranca con el sistema». Si dijera `disabled`: `sudo systemctl enable apache2`. Prueba más convincente: `sudo reboot` y repetir `systemctl status`.

## 2. Cortafuegos

```bash
sudo ufw app list                 # Apache, Apache Full, Apache Secure, OpenSSH
sudo ufw app info "Apache Full"   # Ports: 80,443/tcp
sudo ufw allow "Apache Full"
sudo ufw status numbered
```

Salida esperada: OpenSSH (22) y Apache Full (80, 443), en IPv4 e IPv6. Nada más.

Se acepta abrir solo `Apache` (80) si se justifica que todavía no hay HTTPS; el enunciado pide los dos.

## 3. Página de bienvenida desde otro equipo

En el navegador del anfitrión: `http://192.168.1.50` → «Apache2 Default Page — It works!».

Si no carga, por orden: ¿la VM está en adaptador puente o tiene reenvío de puertos? (`ping 192.168.1.50` desde el anfitrión) → ¿está abierto el 80? (`sudo ufw status`) → ¿escucha Apache? (`ss -tlnp | grep :80`).

## 4. Sitio `intranet`

```bash
sudo mkdir -p /var/www/intranet
sudo chown -R $USER:$USER /var/www/intranet      # el administrador puede editar sin sudo
nano /var/www/intranet/index.html                # archivos/index.html
sudo nano /etc/apache2/sites-available/intranet.conf
```

*Virtual host* (`archivos/intranet.conf`):

```apache
<VirtualHost *:80>
    ServerName intranet.empresa.local
    ServerAdmin admin@empresa.local
    DocumentRoot /var/www/intranet

    <Directory /var/www/intranet>
        Options -Indexes +FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/intranet_error.log
    CustomLog ${APACHE_LOG_DIR}/intranet_access.log combined
</VirtualHost>
```

En el equipo cliente, archivo `hosts` (Windows: `C:\Windows\System32\drivers\etc\hosts` abriendo el Bloc de notas como administrador; Linux/macOS: `/etc/hosts`):

```text
192.168.1.50   intranet.empresa.local
```

Comprobación del nombre en Windows: `ping intranet.empresa.local` debe responder desde `192.168.1.50`. Si el navegador sigue mostrando la página por defecto, probar en una ventana privada o vaciar la caché DNS (`ipconfig /flushdns`).

### Explicación de cada directiva (nivel 3)

| Directiva | Qué hace |
|:----------|:---------|
| `<VirtualHost *:80>` | Bloque que se aplica a las peticiones que llegan al puerto 80 por cualquier IP del servidor. |
| `ServerName` | Nombre por el que se identifica el sitio. Apache compara la cabecera `Host` de la petición con este valor para elegir el *virtual host*: así varios sitios comparten IP y puerto. |
| `ServerAdmin` | Correo que aparece en algunas páginas de error. Opcional. |
| `DocumentRoot` | Carpeta cuyos archivos se sirven: `http://intranet.empresa.local/x.html` → `/var/www/intranet/x.html`. |
| `<Directory>` | Permisos sobre esa carpeta. `Require all granted` permite el acceso; `-Indexes` impide que se liste el contenido si falta `index.html`; `AllowOverride None` ignora los `.htaccess` (más rápido y predecible; WordPress necesitará `All`). |
| `ErrorLog` | Registro de errores propio del sitio. `${APACHE_LOG_DIR}` es `/var/log/apache2` (definido en `/etc/apache2/envvars`). |
| `CustomLog … combined` | Registro de accesos propio, con el formato `combined` (IP, fecha, petición, código, tamaño, procedencia y navegador). |

El `<Directory>` no es imprescindible (`apache2.conf` ya concede acceso a `/var/www/`), pero hace el sitio autocontenido.

### `sites-available` y `sites-enabled` (nivel 3)

- `sites-available/` contiene **todas** las configuraciones de sitios, activas o no.
- `sites-enabled/` contiene **enlaces simbólicos** a las que están activas. Apache solo lee esta carpeta (`IncludeOptional sites-enabled/*.conf` en `apache2.conf`).
- `a2ensite intranet` crea el enlace; `a2dissite` lo borra. Así se desactiva un sitio sin perder su configuración. Lo mismo ocurre con `mods-` y `conf-available/enabled`.

```bash
ls -l /etc/apache2/sites-enabled/
# 000-default.conf -> ../sites-available/000-default.conf
# intranet.conf -> ../sites-available/intranet.conf
```

## 5. Comprobar y recargar

```bash
sudo a2ensite intranet
sudo apache2ctl configtest        # Syntax OK
sudo systemctl reload apache2
sudo apache2ctl -S                # lista de virtual hosts
```

Salida de `apache2ctl -S` (fragmento):

```
*:80                   is a NameVirtualHost
         default server 127.0.1.1 (/etc/apache2/sites-enabled/000-default.conf:1)
         port 80 namevhost 127.0.1.1 (/etc/apache2/sites-enabled/000-default.conf:1)
         port 80 namevhost intranet.empresa.local (/etc/apache2/sites-enabled/intranet.conf:1)
```

Muestra el detalle importante: el primer sitio (`000-default`) es el **sitio por defecto**, el que responde cuando se accede por IP o por un nombre que no coincide con ningún `ServerName`. Por eso `http://192.168.1.50` sigue dando la página de Ubuntu y `http://intranet.empresa.local` la de la intranet.

`reload` frente a `restart`: `reload` relee la configuración sin cortar las conexiones en curso; `restart` para y arranca el servicio. Si la configuración tiene errores, `reload` falla y Apache sigue funcionando con la anterior; con `restart` el servidor se quedaría caído. De ahí `configtest` antes.

::: tip Aviso AH00558
`configtest` puede mostrar «Could not reliably determine the server's fully qualified domain name». No es un error. Se elimina con un `ServerName` global:
`echo "ServerName servidor-tienda" | sudo tee /etc/apache2/conf-available/servername.conf && sudo a2enconf servername`.
:::

## 6. PHP y extensiones

```bash
sudo apt install -y php libapache2-mod-php php-mysql php-mbstring php-xml php-curl
php -v
apache2ctl -M | grep php            # php_module (shared)
php -m | grep -E "mysqli|pdo_mysql|mbstring|xml|curl"
sudo systemctl restart apache2
```

`libapache2-mod-php` instala y activa `mod_php`. Con `apt` se instala **y activa** cada extensión (crea el enlace en `/etc/php/8.3/*/conf.d/`); en Ubuntu no hace falta tocar `php.ini` para activarlas.

### Cómo se conecta Apache con PHP (nivel 3)

1. `mod_php` (`/etc/apache2/mods-enabled/php8.3.load`) carga el intérprete de PHP **dentro** de los procesos de Apache.
2. `php8.3.conf` asocia los archivos `*.php` al manejador `application/x-httpd-php`.
3. `dir.conf` incluye `index.php` en `DirectoryIndex`.
4. Al pedir `x.php`, Apache no envía el archivo: se lo pasa a PHP, que lo ejecuta, y envía al navegador la salida (HTML). Se comprueba en la P1.5 con el código fuente de la página.

`mod_php` exige el MPM `prefork` (un proceso por petición). La alternativa es PHP-FPM (servicio aparte, comunicación por FastCGI, compatible con `mpm_event`), que se trata en los contenidos. Mencionarlo es un plus.

### Qué aporta cada extensión (nivel 3) y relación con la P1.2 (nivel 4)

| Paquete | Extensiones | Para qué | Requisito de la P1.2 |
|:--------|:------------|:---------|:---------------------|
| `php-mysql` | `mysqli`, `pdo_mysql`, `mysqlnd` | Conectar con MariaDB/MySQL. WordPress usa `mysqli`. | Base de datos MariaDB 10.11 |
| `php-mbstring` | `mbstring` | Cadenas multibyte (UTF-8): acentos, «ñ», emojis. | WooCommerce la exige en tiendas que no están en inglés |
| `php-xml` | `dom`, `simplexml`, `xml`, `xmlreader`, `xmlwriter` | Leer y generar XML: importar productos, *feeds* RSS, API. | Recomendada por WordPress |
| `php-curl` | `curl` | Peticiones HTTP a otros servidores: actualizaciones, pasarela de pago, API de transporte. | WooCommerce (cURL), pago con tarjeta (RF4) |

Faltan respecto a la tabla de la P1.2: `php-zip`, `php-intl`, `php-imagick` (o `php-gd`), `php-soap`. Señalarlo es indicador de nivel 4.

## 7. `info.php`

```bash
echo '<?php phpinfo();' | sudo tee /var/www/intranet/info.php
```

En `http://intranet.empresa.local/info.php` comprobar:

| Dato | Valor esperado |
|:-----|:---------------|
| *Server API* | `Apache 2.0 Handler` |
| *Loaded Configuration File* | `/etc/php/8.3/apache2/php.ini` |
| *Scan this dir for additional .ini files* | `/etc/php/8.3/apache2/conf.d` |
| Secciones | `curl`, `dom`, `mbstring`, `mysqli`, `pdo_mysql`, `xml`… |

```bash
sudo rm /var/www/intranet/info.php
curl -I http://intranet.empresa.local/info.php     # HTTP/1.1 404 Not Found
```

Idea clave para el nivel 3: **PHP tiene un `php.ini` para cada forma de ejecutarse.** Apache usa `/etc/php/8.3/apache2/php.ini` y la terminal `/etc/php/8.3/cli/php.ini`. `php -i` o `php --ini` en la terminal muestran el de la CLI, no el de la web. Es el error más frecuente en los pasos 7 y 8.

### Por qué retirar `info.php` (nivel 3 de CE 1g)

`phpinfo()` publica la versión exacta de PHP y de Apache, el sistema operativo, las rutas del servidor, los módulos, las variables de entorno y la configuración. Con eso un atacante busca vulnerabilidades conocidas de esas versiones y sabe dónde están los archivos. No aporta nada al usuario: es una página de diagnóstico.

## 8. `php.ini`: subida de 32 MB y zona horaria

```bash
sudo cp /etc/php/8.3/apache2/php.ini /etc/php/8.3/apache2/php.ini.orig   # copia antes de tocar
sudo nano /etc/php/8.3/apache2/php.ini
```

```ini
upload_max_filesize = 32M
post_max_size = 33M
date.timezone = Europe/Madrid      ; quitar el «;» del principio
```

```bash
grep -nE "^(upload_max_filesize|post_max_size|date.timezone)" /etc/php/8.3/apache2/php.ini
sudo systemctl reload apache2
```

**Detalle técnico importante:** `post_max_size` vale `8M` por defecto y limita todo el envío del formulario, archivo incluido. Si solo se cambia `upload_max_filesize` a 32M, en la práctica no se pueden subir más de 8 MB. Debe ser **mayor** que `upload_max_filesize`.

Demostración, sin dejar `info.php` publicado:

```bash
# Opción 1: phpinfo temporal y borrarlo
echo '<?php phpinfo();' | sudo tee /var/www/intranet/info.php
curl -s http://intranet.empresa.local/info.php | grep -E "upload_max_filesize|post_max_size|date.timezone" | sed 's/<[^>]*>/ /g'
sudo rm /var/www/intranet/info.php

# Opción 2: leer la configuración de Apache desde la CLI
php -c /etc/php/8.3/apache2/php.ini -r 'echo ini_get("upload_max_filesize"), " ", ini_get("date.timezone"), PHP_EOL;'
```

Resultado de la prueba de esta solución: `32M 33M Europe/Madrid` en la web; en la CLI sigue `2M` porque es otro `php.ini`.

**Alternativa mejor (indicador de nivel 4):** en lugar de editar `php.ini`, crear `/etc/php/8.3/apache2/conf.d/99-intranet.ini` (`archivos/99-intranet.ini`). Se lee después de `php.ini`, deja claro qué se ha cambiado y no provoca conflictos cuando una actualización del paquete trae un `php.ini` nuevo. Probada: da el mismo resultado.

Relación con la P1.2 (nivel 4): 32 MB para las fotografías del catálogo; zona horaria para que los pedidos y los correos lleven la hora de España; en la P1.2 también se pedía `memory_limit = 256M` para WooCommerce (por defecto 128M).

## 9. Registro de accesos

```bash
curl -s http://intranet.empresa.local/ > /dev/null      # o visitarlo desde el navegador del cliente
sudo tail -n 5 /var/log/apache2/intranet_access.log
```

Salida de ejemplo y lectura del formato `combined`:

```
192.168.1.10 - - [28/Oct/2026:11:35:01 +0100] "GET / HTTP/1.1" 200 412 "-" "Mozilla/5.0 (Windows NT 10.0; …) Firefox/…"
192.168.1.10 - - [28/Oct/2026:11:35:02 +0100] "GET /favicon.ico HTTP/1.1" 404 455 "http://intranet.empresa.local/" "Mozilla/5.0 …"
192.168.1.10 - - [28/Oct/2026:11:36:40 +0100] "GET /info.php HTTP/1.1" 404 455 "-" "Mozilla/5.0 …"
```

| Campo | Significado |
|:------|:------------|
| `192.168.1.10` | IP del cliente (el anfitrión). |
| `- -` | Identidad y usuario autenticado (vacíos). |
| `[28/Oct/2026:…]` | Fecha y hora. |
| `"GET / HTTP/1.1"` | Petición. |
| `200`, `404` | Código de respuesta. |
| `412` | Bytes enviados. |
| `"-"` / URL | Página de procedencia (*Referer*). |
| `"Mozilla/…"` | Navegador (*User-Agent*). |

Debe verse la IP del **cliente**, no `127.0.0.1` (eso indicaría que la prueba se hizo desde el propio servidor). La línea de `info.php` con `404` demuestra que se retiró.

## Comprobación final (nivel 4 de CE 1g)

```bash
sudo ufw status verbose
sudo ss -tlnp
```

Esperado:

```
State   Local Address:Port   Process
LISTEN  0.0.0.0:22           sshd
LISTEN  127.0.0.53%lo:53     systemd-resolved
LISTEN  *:80                 apache2
```

El 443 está abierto en el cortafuegos pero nada escucha todavía (no se ha activado SSL): conviene que el alumnado lo explique. Activarlo con el certificado autofirmado (`sudo a2enmod ssl && sudo a2ensite default-ssl && sudo systemctl reload apache2`) es un extra.
