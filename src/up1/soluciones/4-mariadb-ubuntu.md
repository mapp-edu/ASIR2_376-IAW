---
layout: doc
title: "Solución P1.4 — Instalación de MariaDB en Ubuntu"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P1.4 — Instalación de MariaDB en Ubuntu

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P1.4 MariaDB en Ubuntu](../ejercicios/4-mariadb-ubuntu).
:::

- **Unidad:** UP1 · RA1 · CE 1c, 1f, 1g, 1i.
- **Archivos de la solución** (probados en Ubuntu 24.04 con MariaDB 10.11, Apache 2.4 y PHP 8.3):
  - <a :href="withBase('/soluciones/up1/p1.4-mariadb-ubuntu/archivos/01-crear-bd-usuario.sql')" download><code>archivos/01-crear-bd-usuario.sql</code></a>: base de datos y usuario (como administrador).
  - <a :href="withBase('/soluciones/up1/p1.4-mariadb-ubuntu/archivos/02-avisos.sql')" download><code>archivos/02-avisos.sql</code></a>: tabla y datos (como `intranet_user`).
  - <a :href="withBase('/soluciones/up1/p1.4-mariadb-ubuntu/archivos/prueba-bd.php')" download><code>archivos/prueba-bd.php</code></a>: *script* de prueba con PDO.

Se parte del servidor de la P1.2 y la P1.3: Apache y PHP con `php-mysql`, sitio `intranet` en `/var/www/intranet`.

::: tip Versión de MariaDB
Ubuntu 24.04 instala MariaDB 10.11; Ubuntu 26.04, MariaDB 11.8. Las órdenes son las mismas. Se aceptan los nombres antiguos (`mysql`, `mysqldump`, `mysql_secure_installation`), pero en MariaDB 11 algunos ya no existen.
:::

---

## 1. Instalación

```bash
sudo apt update
sudo apt install -y mariadb-server
mariadb --version
systemctl status mariadb --no-pager     # active (running)
systemctl is-enabled mariadb            # enabled
```

## 2. Asistente de seguridad

```bash
sudo mariadb-secure-installation
```

Respuestas recomendadas en Ubuntu y qué hace cada pregunta:

| Pregunta | Respuesta | Qué hace | Riesgo del que protege (nivel 3) |
|:---------|:---------:|:---------|:---------------------------------|
| *Enter current password for root (enter for none)* | Intro | Pide la contraseña actual de `root` de MariaDB. En Ubuntu no tiene: entra por `unix_socket`. | — |
| *Switch to unix_socket authentication* | `n` | `root` ya usa `unix_socket` en Ubuntu: solo el usuario `root` del sistema (con `sudo mariadb`) puede entrar como `root` de MariaDB, sin contraseña. | Fuerza bruta contra la contraseña de `root`: no hay contraseña que adivinar. Responder `Y` no hace daño. |
| *Change the root password?* | `n` | Pondría una contraseña a `root`. Con `unix_socket` no es necesaria. | Si se responde `Y`, que sea robusta. |
| *Remove anonymous users?* | `Y` | Borra las cuentas sin nombre de usuario que trae la instalación para pruebas. | Que cualquiera se conecte sin credenciales. |
| *Disallow root login remotely?* | `Y` | Borra las cuentas `root` que no sean de `localhost`. | Ataques a la cuenta más poderosa desde la red. |
| *Remove test database and access to it?* | `Y` | Borra la base de datos `test`, a la que podía acceder cualquier usuario. | Un espacio donde cualquiera puede escribir: almacenar datos o atacar desde dentro. |
| *Reload privilege tables now?* | `Y` | Aplica los cambios de permisos inmediatamente. | Que los cambios no tengan efecto hasta reiniciar. |

En Ubuntu 24.04 la instalación ya viene sin usuarios anónimos ni base de datos `test`, así que el asistente dirá que no hay nada que borrar. Hay que ejecutarlo igualmente y explicarlo.

Comprobación:

```bash
sudo mariadb -e "SELECT user, host FROM mysql.user; SHOW DATABASES;"
sudo mariadb -e "SHOW GRANTS FOR root@localhost;"
```

No deben aparecer usuarios con `user` vacío, ni `root` con un `host` distinto de `localhost`, ni la base de datos `test`. La segunda orden muestra cómo se autentica `root`: `IDENTIFIED VIA mysql_native_password USING 'invalid' OR unix_socket` (sin contraseña válida, solo por *socket*). La columna `plugin` de `mysql.user` no sirve para esto: muestra `mysql_native_password` aunque se use `unix_socket`.

## 3. Base de datos y usuario

```bash
sudo mariadb
```

```sql
CREATE DATABASE intranet CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'intranet_user'@'localhost' IDENTIFIED BY 'CAMBIAR-por-una-clave-larga';
GRANT ALL PRIVILEGES ON intranet.* TO 'intranet_user'@'localhost';
SHOW GRANTS FOR 'intranet_user'@'localhost';
EXIT;
```

Salida de `SHOW GRANTS`:

```
GRANT USAGE ON *.* TO `intranet_user`@`localhost` IDENTIFIED BY PASSWORD '*…'
GRANT ALL PRIVILEGES ON `intranet`.* TO `intranet_user`@`localhost`
```

`USAGE ON *.*` significa «sin ningún permiso global»: solo puede conectarse. Los permisos están limitados a `intranet.*`.

`FLUSH PRIVILEGES` (que aparece en los apuntes) **no es necesario** con `CREATE USER` y `GRANT`: solo hace falta si se modifican las tablas de `mysql` directamente. No penalizar si se usa.

Variante más estricta y aceptable: `GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX, DROP ON intranet.*`. Si se justifica, es indicador de nivel 3–4.

### Justificación del juego de caracteres (nivel 3)

- **`utf8mb4`** es UTF-8 completo (hasta 4 bytes por carácter): acentos, «ñ», alfabetos no latinos y emojis. El `utf8` de MariaDB/MySQL (alias de `utf8mb3`) es una versión recortada de 3 bytes: los emojis fallan o se truncan.
- **`utf8mb4_unicode_ci`**: ordenación según las reglas de Unicode, sin distinguir mayúsculas (`ci`): «Ávila» se ordena junto a «avila». Es la que usa WordPress. `utf8mb4_general_ci` es más rápida y menos exacta.
- Debe coincidir en toda la cadena: base de datos, conexión de PHP (`charset=utf8mb4` en el DSN), cliente de la terminal y página HTML (`<meta charset="UTF-8">`).

::: warning Trampa comprobada al preparar la solución
El cliente `mariadb` elige el juego de caracteres de la conexión según la configuración regional del terminal. Con un terminal sin UTF-8 usa `latin1` y guarda «versión» **doblemente codificado**: en la terminal se ve bien, pero en la web aparece «versiÃ³n». Con UTF-8 usa `utf8mb3` (sin emojis). Se evita con `mariadb --default-character-set=utf8mb4` o `SET NAMES utf8mb4;` al principio del *script*. Si en la captura del navegador aparecen caracteres raros, esta es la causa.
:::

## 4. Tabla `avisos` con el usuario nuevo

```bash
mariadb --default-character-set=utf8mb4 -u intranet_user -p intranet
```

```sql
CREATE TABLE avisos (
    id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    fecha  DATE         NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO avisos (titulo, fecha) VALUES
    ('Corte de luz programado el viernes', '2026-11-06'),
    ('Nueva versión de la intranet',       '2026-11-10');

SELECT * FROM avisos;
SHOW CREATE TABLE avisos\G
```

`SHOW CREATE TABLE` debe mostrar `DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci`: la tabla hereda la configuración de la base de datos.

Es importante que se haga con `intranet_user` y no con `sudo mariadb`: demuestra que el usuario tiene los permisos que necesita (crear tablas, insertar).

## 5. El usuario no ve otras bases de datos

```bash
mariadb -u intranet_user -p -e "SHOW DATABASES;"
```

```
Database
information_schema
intranet
```

```bash
mariadb -u intranet_user -p -e "USE mysql;"
# ERROR 1044 (42000): Access denied for user 'intranet_user'@'localhost' to database 'mysql'
mariadb -u intranet_user -p -e "SELECT user FROM mysql.user;"
# ERROR 1142 (42000): SELECT command denied to user 'intranet_user'@'localhost' for table `mysql`.`user`
mariadb -u intranet_user -p -e "CREATE DATABASE otra;"
# ERROR 1044 (42000): Access denied for user 'intranet_user'@'localhost' to database 'otra'
```

`information_schema` aparece siempre: es una vista de solo lectura de los metadatos, y solo muestra lo que el usuario tiene permitido ver.

## 6. *Script* `prueba-bd.php`

Archivo completo en `archivos/prueba-bd.php`. Puntos esenciales:

```php
$dsn = 'mysql:host=localhost;dbname=intranet;charset=utf8mb4';
$pdo = new PDO($dsn, 'intranet_user', '********', [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);
$avisos = $pdo->query('SELECT id, titulo, fecha FROM avisos ORDER BY fecha')->fetchAll();
```

```bash
nano /var/www/intranet/prueba-bd.php
# navegador: http://intranet.empresa.local/prueba-bd.php  → tabla con los dos avisos
rm /var/www/intranet/prueba-bd.php
curl -I http://intranet.empresa.local/prueba-bd.php        # 404 Not Found
```

### Justificación de la forma de conexión (nivel 3)

| Elección | Por qué |
|:---------|:--------|
| **PDO** frente a `mysqli` | Misma interfaz para distintos gestores (MariaDB, PostgreSQL, SQLite); consultas preparadas con parámetros con nombre; es lo que se usa en la UP6. `mysqli` también es válido (WordPress lo usa). |
| `host=localhost` | PHP y MariaDB están en la misma máquina: con `localhost`, el controlador usa el *socket* de Unix (`/run/mysqld/mysqld.sock`), más rápido que TCP, y coincide con el usuario `@'localhost'`. |
| `charset=utf8mb4` en el DSN | La conexión usa el mismo juego de caracteres que la base de datos; sin él, los acentos pueden llegar mal. |
| `ERRMODE_EXCEPTION` | Los errores se capturan con `try/catch` en lugar de pasar desapercibidos. |
| El error se manda a `error_log` y no a la pantalla | El mensaje de la excepción puede incluir el usuario y el servidor; al visitante solo se le dice que hay un error. Comprobado: el detalle aparece en `/var/log/apache2/intranet_error.log`. |
| `htmlspecialchars` al mostrar los datos | Evita que un título con HTML o JavaScript se ejecute en el navegador (XSS). Se verá en la UP5. |

## 7. Dirección y puerto de escucha

```bash
sudo ss -tlnp | grep -E "3306|mariadbd"
# LISTEN 0 80 127.0.0.1:3306 0.0.0.0:* users:(("mariadbd",pid=…))
grep -rn "^bind-address" /etc/mysql/
# /etc/mysql/mariadb.conf.d/50-server.cnf:27:bind-address = 127.0.0.1
sudo ufw status                       # 3306 no aparece
```

**Explicación de referencia:** MariaDB escucha en el puerto 3306 **solo en la interfaz de bucle local (`127.0.0.1`)**. Las conexiones desde otro equipo no llegan al servicio aunque se abriera el cortafuegos; desde el anfitrión, `nc -zv 192.168.1.50 3306` o `Test-NetConnection 192.168.1.50 -Port 3306` falla. Hay **dos barreras más**: el cortafuegos no permite el 3306 y el usuario solo está definido para `localhost`. Para abrirlo habría que cambiar `bind-address`, crear el usuario para la IP concreta y abrir el puerto en `ufw` solo para esa IP (apartado de acceso remoto de los contenidos). En este servidor no es necesario: la única que se conecta es la aplicación PHP, que está en la misma máquina.

## 8. Copia de seguridad y restauración

```bash
# Copia (con el usuario de la aplicación es suficiente para una base de datos)
mariadb-dump -u intranet_user -p --single-transaction --default-character-set=utf8mb4 \
    intranet > intranet-$(date +%F).sql
ls -lh intranet-*.sql
grep -E "CREATE TABLE|INSERT INTO" intranet-*.sql

# Restauración en una base de datos nueva (como administrador: intranet_user no puede crearla)
sudo mariadb -e "CREATE DATABASE intranet_prueba CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mariadb --default-character-set=utf8mb4 intranet_prueba < intranet-$(date +%F).sql
sudo mariadb -e "SELECT * FROM intranet_prueba.avisos;"
```

Comprobado al preparar la solución: la restauración reproduce las dos filas con los acentos (y emojis) correctos.

A tener en cuenta:

- El volcado **no** incluye `CREATE DATABASE` si se hace `mariadb-dump intranet` (sin `--databases`): por eso se puede restaurar con otro nombre. Si alguien usó `--databases intranet`, el archivo contiene `USE intranet` y la «restauración» sobrescribe la original. Error frecuente que hay que señalar.
- `--single-transaction` hace una copia coherente de las tablas InnoDB sin bloquearlas: la aplicación sigue funcionando durante la copia.
- Los `mariadb-dump` recientes añaden en la primera línea `/*M!999999\- enable the sandbox mode */`: los clientes de MySQL no la entienden. Si alguien restaura con el cliente de MySQL y da error, esa es la causa.
- `intranet_user` no puede restaurar en `intranet_prueba` porque no tiene permisos sobre ella: es la prueba de que el mínimo privilegio funciona. Dar permisos a `intranet_user` sobre `intranet_prueba` para poder restaurar también es aceptable si se explica.
- Al terminar, `sudo mariadb -e "DROP DATABASE intranet_prueba;"` y borrar el `.sql` del servidor o llevarlo fuera (contiene datos).

### Cuándo se usaría (nivel 4 de CE 1f)

- **Antes de cambios de riesgo:** actualizar WordPress o un plugin, migrar la estructura de la base de datos.
- **Recuperación ante desastres:** fallo del disco, borrado accidental, base de datos corrupta o cifrada por un ataque.
- **Migración** a otro servidor o de desarrollo a producción.
- **Restaurar en una base de datos aparte** (lo que se hace aquí) sirve para **probar que la copia es válida** sin tocar los datos reales y para recuperar solo unos registros borrados. Una copia que nunca se ha restaurado no está comprobada.
- Enlace con la P1.2: copia diaria automatizada (`cron` o temporizador de systemd), fuera del servidor, con retención.

---

## Nivel 4 de CE 1c: el LAMP completo

| Capa | Componente | Práctica | Comprobación |
|:-----|:-----------|:---------|:-------------|
| **L**inux | Ubuntu Server 24.04, IP fija, `ufw`, SSH sin `root` | P1.2 | `hostnamectl`, `ufw status` |
| **A**pache | Apache 2.4, sitio `intranet` | P1.3 | `apache2ctl -S`, registro de accesos |
| **M**ariaDB | MariaDB 10.11, BD `intranet`, `intranet_user` | P1.4 | `SHOW GRANTS`, `ss -tlnp` |
| **P**HP | PHP 8.3 con `mod_php`, `pdo_mysql` | P1.3 | `prueba-bd.php` (integración de todo) |

```bash
systemctl is-active apache2 mariadb ssh
sudo ss -tlnp            # 22 en todas, 80 en todas, 3306 solo en 127.0.0.1
sudo ufw status          # 22, 80, 443
```

El flujo de una petición a `prueba-bd.php`: navegador → puerto 80 → Apache (*vhost* `intranet`) → `mod_php` → PDO por *socket* → MariaDB → HTML de vuelta. Un diagrama así en la memoria es un buen indicador de nivel 4.
