---
layout: doc
title: "Solución P2.3 — WordPress en un alojamiento remoto"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P2.3 — WordPress en un alojamiento remoto

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P2.3 WordPress en remoto](../ejercicios/3-wordpress-remoto).
:::

- **Unidad:** UP2 · RA2 · CE 2c, 2f, 2g, 2h.
- **Archivos de la solución:**
  - <a :href="withBase('/soluciones/up2/p2.3-wordpress-remoto/archivos/wp-config-remoto.php')" download><code>archivos/wp-config-remoto.php</code></a>: fragmento de `wp-config.php` con las constantes de seguridad.

::: warning Los alojamientos gratuitos cambian a menudo
No se ha podido crear una cuenta real al preparar esta solución: los datos de los alojamientos proceden de sus condiciones publicadas (consultadas el 09/11/2026) y pueden cambiar. Lo importante es **leer y anotar** las condiciones vigentes del alojamiento elegido, no que coincidan con esta tabla. 000webhost, que aparece en muchos tutoriales, **cerró en 2024**.
:::

---

## 1. Elección del alojamiento

Alojamientos compartidos gratuitos con PHP y MySQL habituales en 2026 (según [DeployHQ, 2026](https://deployhq.com/blog/how-to-deploy-a-php-website-for-free)):

| Alojamiento | Espacio | Tráfico | BD | PHP | HTTPS | Instalador | Limitaciones destacadas |
|:------------|:--------|:--------|:---|:----|:------|:-----------|:------------------------|
| **InfinityFree** | 5 GB | Sin medir; ≈ 50 000 visitas/día | 400 | 8.3 | Gratis | Softaculous | 10 s de ejecución PHP, sin SSH ni *cron*, posible suspensión temporal con picos. |
| **Byet.host** | 5 GB | Sin límite declarado | Ilimitadas (MariaDB 11.4) | 8.3 | Let's Encrypt | Softaculous | Subida máxima 10 MB, IP compartida, sin SSH ni *cron*. |
| **TinkerHost** | 1 GB | 5 GB/mes | 1 | 8.x | Gratis | Softaculous | Subida máxima 10 MB, sin SSH, *cron* ni correo. |
| **AwardSpace** | 1 GB | 5 GB | 1 | **7** | Gratis | — | PHP sin soporte: **no válido** para WordPress actual (pide PHP 7.4 como mínimo y recomienda 8.3). |

La elección de referencia es **InfinityFree** (o Byet.host, de la misma familia): PHP 8.3, base de datos MySQL/MariaDB, HTTPS gratuito y subdominio. Lo que se valora (nivel 3 de CE 2h) es que la elección se razone con estas condiciones frente a los requisitos de WordPress: PHP ≥ 7.4 (recomendado 8.3), MySQL/MariaDB, HTTPS, espacio para medios.

Limitaciones que deberían aparecer en la memoria y su efecto:

| Limitación | Efecto en WordPress |
|:-----------|:--------------------|
| Tiempo de ejecución corto (≈ 10 s) | Actualizaciones grandes o importaciones pueden cortarse a medias. |
| Sin *cron* del sistema | WP-Cron depende de las visitas; las tareas programadas se retrasan. |
| Subida máxima de 10 MB | Medios grandes o plugins en ZIP grandes no se pueden subir desde el panel. |
| Protección anti-bots del alojamiento | Puede hacer fallar las peticiones internas (*loopback*, API REST) que comprueba *Salud del sitio*. |
| Subdominio del proveedor, sin correo | Imagen poco profesional; los correos de WordPress pueden no llegar. |
| Publicidad o avisos del proveedor, suspensión por inactividad | Revisar en las condiciones. |

## 2. Cuenta y subdominio

Registro con un correo creado para la práctica (aviso del enunciado). En el panel: **Create Account** → elegir subdominio gratuito (`iaw-ana.<dominio-del-proveedor>`). La propagación del DNS puede tardar desde unos minutos hasta varias horas: si el navegador dice que el dominio no existe, esperar.

## 3. Instalación manual

### 3.1. Base de datos

Panel → **MySQL Databases** → crear. En los alojamientos compartidos el proveedor **añade un prefijo** y fija el usuario:

| Dato | Ejemplo | Dónde se ve |
|:-----|:--------|:------------|
| Nombre de la BD | `if0_37xxxxxx_wp` | Tras crearla |
| Usuario | `if0_37xxxxxx` | Datos de la cuenta |
| Contraseña | La de la cuenta de hosting (no la del panel del cliente) | *Account details* |
| **Servidor** | `sql123.infinityfree.com` — **no** `localhost` | *MySQL Databases* |

Que el servidor de base de datos sea **otra máquina** es la principal diferencia con la instalación local (nivel 4).

### 3.2. Archivos

1. Descargar WordPress en español de `es.wordpress.org` y descomprimirlo **en el equipo**.
2. Subir el **contenido** de la carpeta `wordpress` (no la carpeta) a la carpeta pública del alojamiento (`htdocs` en InfinityFree; `public_html` en otros):
   - Por **FTP** con FileZilla: servidor, usuario y contraseña FTP que da el panel, puerto 21 (SFTP si lo ofrece). Son unos 3 500 archivos: tarda varios minutos y conviene revisar la pestaña *Transferencias fallidas* al terminar.
   - Con el **gestor de archivos** del panel: subir el ZIP y descomprimir, si el gestor lo permite y el ZIP no supera el límite de subida.
3. Borrar el `index2.html` u otra página por defecto que haya dejado el proveedor en la carpeta.

### 3.3. Asistente web

Abrir `https://iaw-ana.<dominio>` → idioma → datos de la base de datos de 3.1 (servidor incluido) → prefijo de tablas propio (`iaw_`) → título, usuario administrador y correo.

Si el asistente **no puede escribir** `wp-config.php` (permisos del alojamiento), muestra su contenido para crearlo a mano: copiar el texto, guardarlo como `wp-config.php` y subirlo por FTP. Hay que saberlo hacer.

### Qué guarda `wp-config.php` (nivel 3)

| Constante o variable | Contenido |
|:---------------------|:----------|
| `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST` | Conexión con la base de datos del alojamiento. |
| `DB_CHARSET`, `DB_COLLATE` | Juego de caracteres (`utf8mb4`). |
| `AUTH_KEY` … `NONCE_SALT` | Ocho claves aleatorias que firman las cookies de sesión. Si se cambian, se cierran todas las sesiones. |
| `$table_prefix` | Prefijo de las tablas (`iaw_`). |
| `WP_DEBUG` | Modo de depuración (desactivado). |
| `ABSPATH` y `require_once … wp-settings.php` | Ruta de WordPress y arranque. |

### Comparación con la instalación local (nivel 4 de CE 2c)

| Aspecto | Local (P2.1, AMPPS) | Remota (P2.3) |
|:--------|:--------------------|:--------------|
| Servidor de BD | `localhost` | Otra máquina del proveedor (`sqlXXX…`) |
| Nombres | Los elige el alumno | El proveedor impone prefijos y usuario |
| Copia de archivos | Descomprimir en una carpeta | FTP o gestor web, lento y con límites |
| Permisos | Sin restricciones | Pueden impedir escribir `wp-config.php` o instalar plugins |
| Acceso | Solo el propio equipo | Cualquiera en Internet: la seguridad importa desde el primer minuto |
| HTTPS | No hace falta | Imprescindible (contraseñas por la red) |
| Control del servidor | Total (`php.ini`, módulos) | Ninguno: solo lo que deje el panel |

## 4. Ajustes

**Ajustes → Generales**: título, descripción, **Idioma del sitio: Español**, **Zona horaria: Madrid**. Si se instaló en inglés, el idioma se descarga desde ahí mismo.

## 5. Seguridad

### 5.1. Administrador que no se llama `admin`

Se elige en el asistente. Si ya se creó `admin`: crear otro usuario administrador, entrar con él y borrar `admin` **atribuyendo su contenido** al nuevo. El nombre de usuario no se puede cambiar desde el panel.

Comprobación: **Usuarios** muestra solo el administrador con nombre propio; contraseña de 16+ caracteres generada por WordPress.

### 5.2. HTTPS

1. Panel del alojamiento → **SSL/TLS** → emitir el certificado gratuito para el subdominio (en InfinityFree, validación por registro DNS y después instalación; tarda unos minutos).
2. Comprobar `https://iaw-ana.<dominio>` con el candado.
3. **Ajustes → Generales**: cambiar **Dirección de WordPress** y **Dirección del sitio** a `https://`. Volverá a pedir el acceso.
4. Opcional, añadir a `wp-config.php` `define( 'FORCE_SSL_ADMIN', true );` para que el panel solo funcione cifrado, y redirigir HTTP a HTTPS en `.htaccess` si el alojamiento no lo hace.

Si el alojamiento no ofrece HTTPS, se acepta documentarlo como limitación (el enunciado dice «si el alojamiento lo ofrece»), pero entonces la elección del alojamiento es discutible.

### 5.3. Editor de archivos desactivado

En `wp-config.php` (por FTP o gestor de archivos), **antes** de `/* That's all, stop editing! */`:

```php
define( 'DISALLOW_FILE_EDIT', true );
```

Comprobación: desaparecen **Apariencia → Editor de archivos de temas** y **Plugins → Editor de archivos de plugins**. En un tema de bloques, *Apariencia → Editor* (el editor del sitio) **sigue**: no es un editor de código, edita plantillas guardadas en la base de datos. Confundirlo es habitual.

### 5.4. Plugins y temas sin usar

- **Plugins**: borrar los que vienen de serie (Akismet, Hello Dolly) si no se usan, y los que haya añadido el proveedor.
- **Temas**: borrar los inactivos **excepto uno por defecto** de reserva (por ejemplo Twenty Twenty-Four). *Salud del sitio* lo recomienda así: si el tema activo falla, WordPress tiene a cuál volver.

### De qué protege cada medida (nivel 3)

| Medida | Ataque del que protege |
|:-------|:-----------------------|
| Usuario distinto de `admin` y contraseña fuerte | **Fuerza bruta** y relleno de credenciales contra `wp-login.php` y `xmlrpc.php`: los robots prueban `admin` con listas de contraseñas. |
| HTTPS | **Interceptación** de la contraseña y de la cookie de sesión en redes públicas (*sniffing*, *man-in-the-middle*). |
| `DISALLOW_FILE_EDIT` | Que quien robe una cuenta de administrador **escriba código PHP** en un tema o plugin desde el panel y tome el control del servidor (*web shell*). |
| Borrar plugins y temas sin usar | **Vulnerabilidades** en código que nadie actualiza: un plugin desactivado sigue en el servidor y sus archivos pueden ser accesibles. Reduce la superficie de ataque. |

Nivel 4 de CE 2f: relacionar con las limitaciones del alojamiento: sin acceso a `php.ini` ni al servidor, las únicas medidas posibles son las de WordPress y `wp-config.php`; sin SSH, las copias de seguridad dependen de plugins; con IP compartida, un plugin de seguridad que limite intentos de acceso tiene más sentido.

## 6. Contenido

- **Página** «Presentación» (o «Quiénes somos») y fijarla como portada si se quiere.
- **Entrada** con categoría y fecha.
- Sin datos personales reales (aviso del enunciado). Revisar también el texto de ejemplo de la página de privacidad y el «Hola, mundo».

## 7. Pruebas

| Prueba | Cómo | Resultado |
|:-------|:-----|:----------|
| Otro dispositivo y otra red | Móvil con **datos** (no la wifi del aula) | Carga la URL, el candado aparece, la página y la entrada se ven. |
| Parte pública | Ventana privada en el ordenador | Menú, portada, entrada, buscador. |
| Panel | `…/wp-admin` | Acceso por HTTPS; sin editor de archivos. |
| Móvil | El mismo móvil | Diseño adaptado, menú de hamburguesa. |
| **Herramientas → Salud del sitio** | Pestañas *Estado* e *Información* | Ver tabla siguiente. |

### Avisos habituales de Salud del sitio (nivel 3)

| Aviso | ¿Se resuelve aquí? |
|:------|:-------------------|
| Tienes plugins o temas inactivos | **Sí**: borrarlos (dejar un tema por defecto). |
| Tu sitio no usa HTTPS / las direcciones no son HTTPS | **Sí**: apartado 5.2. |
| Hay actualizaciones disponibles | **Sí**: actualizar. |
| Una petición de bucle (*loopback*) ha fallado / la API REST encontró un error | **Normalmente no**: suele deberse a la protección anti-bots o a los límites del alojamiento. Documentarlo. |
| Las tareas programadas fallan o se retrasan | **No**: sin *cron* del sistema. |
| Falta un módulo opcional (`imagick`, `intl`…) | **No**: depende de la configuración de PHP del proveedor. |
| No se usa caché de objetos persistente | **No** en un plan gratuito (requiere Redis/Memcached). |
| La versión de PHP / MySQL es antigua | Depende de si el panel permite cambiar la versión. |

## 8. Publicación profesional (nivel 4 de CE 2h)

Qué haría falta para pasar a un alojamiento profesional:

- **Dominio propio** (`asociacion.es`) y su DNS.
- Alojamiento de pago con **PHP actualizado**, SSH, *cron*, correo, copias automáticas y soporte; o VPS si se necesita control total.
- **Migración**: copia de archivos y base de datos (plugin de migración o FTP + `mariadb-dump`) y cambio de las URL guardadas (`wp search-replace` o el propio plugin).
- **Correo saliente** fiable (SMTP) para formularios y avisos.
- **Copias de seguridad** programadas fuera del servidor, y entorno de pruebas para actualizaciones.
- Cumplimiento legal: aviso legal, política de privacidad y de cookies (RGPD/LSSI).
- Rendimiento: caché de páginas, imágenes optimizadas y CDN si hay tráfico.
