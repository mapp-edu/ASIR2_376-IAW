---
layout: doc
title: "Solución P2.1 — Instalación de WordPress en AMPPS"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P2.1 — Instalación de WordPress en AMPPS

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P2.1 Instalación de WordPress](../ejercicios/1-instalacion-wordpress).
:::

- **Unidad:** UP2 · RA2 · CE 2c, 2g. Proyecto del portal interno.
- **Entrega del alumnado:** punto 1 del manual de usuario.
- **Archivos de la solución:**
  - <a :href="withBase('/soluciones/up2/p2.1-instalacion-wordpress/archivos/crear-bd.sql')" download><code>archivos/crear-bd.sql</code></a>: creación de la base de datos y el usuario desde la pestaña SQL de phpMyAdmin.

En los ejemplos `nomAlumno` es `ana`.

::: warning Dos formas de leer «instalador automático»
El requisito 3 dice «usar el instalador automático de WordPress». Se puede entender de dos maneras:

- **A. El asistente web de WordPress** (`wp-admin/install.php`, la «instalación en 5 minutos»). Pide la base de datos, el usuario y la contraseña creados en el paso 2 y los escribe en `wp-config.php`. **Encaja con todos los requisitos**, incluida la comprobación del paso 5. Es la vía de referencia de esta solución.
- **B. Softaculous**, el instalador de aplicaciones de AMPPS. Crea él mismo la base de datos y elige las credenciales que escribe en `wp-config.php`, así que lo normal es que **no** aparezcan `bd_ana` ni `bdUser_ana` y no se cumpla el paso 5. Si alguien lo usa, la comprobación es mirar `wp-config.php`: o coincide con el paso 2, o no cumple.

---

## 1. Servicios de Apache y MySQL

1. Instalar AMPPS **como administrador** (ver el aviso del enunciado). La versión gratuita basta: incluye la gestión de dominios y de MySQL y las aplicaciones gratuitas, entre ellas WordPress. No incluye actualizaciones ni el «WordPress Manager».
2. Abrir AMPPS → pulsar **Start** en Apache y MySQL. Los dos indicadores en verde.
3. Comprobar en el navegador `http://localhost` → página de AMPPS.

| Problema | Causa habitual | Solución |
|:---------|:---------------|:---------|
| Apache no arranca | Puerto 80 ocupado (IIS, Skype antiguo, otro XAMPP) | `netstat -ano \| findstr :80` en `cmd` y parar el programa, o cambiar el puerto en AMPPS |
| MySQL no arranca | Puerto 3306 ocupado por otro MySQL/MariaDB | Parar el otro servicio en *services.msc* |
| AMPPS se cierra al instalar | Sin permisos de administrador | Ver el aviso del enunciado |

## 2. Base de datos y usuario

Desde phpMyAdmin (`http://localhost/phpmyadmin`; usuario `root`, contraseña `mysql`, la que trae AMPPS por defecto):

**Opción con asistente:** pestaña **Cuentas de usuario → Agregar cuenta de usuario**:

| Campo | Valor |
|:------|:------|
| Nombre de usuario | `bdUser_ana` |
| Nombre del host | **Local** → `localhost` |
| Contraseña / Debe volver a escribirse | `bdPass_ana` |
| Base de datos para la cuenta de usuario | ☐ (no marcar las opciones de crear base de datos) |
| Privilegios globales | **ninguno** |

Después, pestaña **Bases de datos** → crear `bd_ana` con cotejamiento `utf8mb4_unicode_ci`. Por último, en **Cuentas de usuario → bdUser_ana → Editar privilegios → Base de datos → bd_ana → Marcar todos → Continuar**.

**Opción con SQL** (pestaña **SQL**, `archivos/crear-bd.sql`):

```sql
CREATE DATABASE bd_ana CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bdUser_ana'@'localhost' IDENTIFIED BY 'bdPass_ana';
GRANT ALL PRIVILEGES ON bd_ana.* TO 'bdUser_ana'@'localhost';
```

También se acepta el apartado de bases de datos del panel de AMPPS (`http://localhost/ampps-admin`) si permite crear la base de datos y el usuario con esos nombres.

Comprobación: **Cuentas de usuario** muestra `bdUser_ana` · `localhost` · privilegios globales «USAGE», y en *Privilegios específicos de la base de datos* solo `bd_ana`.

### Para qué necesita WordPress la base de datos y por qué un usuario propio (nivel 3)

- WordPress guarda en la base de datos **todo lo que no es un archivo**: entradas, páginas, menús, usuarios y contraseñas cifradas, comentarios, ajustes del sitio y de los plugins. En la carpeta solo están el código, los temas, los plugins y los archivos subidos. Sin base de datos no hay sitio.
- Un usuario propio con permisos **solo sobre `bd_ana`** aplica el principio de mínimo privilegio: si alguien aprovecha una vulnerabilidad de WordPress o de un plugin, solo puede tocar esa base de datos, no las de otras aplicaciones ni la configuración del servidor. Usar `root` (lo que hace por comodidad mucha gente en AMPPS/XAMPP) daría acceso a todo.

## 3. Instalación de WordPress (vía A, asistente web)

1. Descargar WordPress en español desde `es.wordpress.org` y descomprimirlo en `C:\Program Files\Ampps\www\wp_ana` (la carpeta pública de AMPPS es `www`).
2. Abrir `http://localhost/wp_ana` → empieza el asistente.
3. **Idioma:** Español.
4. **Datos de la base de datos:**

| Campo | Valor | Qué hace |
|:------|:------|:---------|
| Nombre de la base de datos | `bd_ana` | Base de datos donde se crearán las tablas. |
| Nombre de usuario | `bdUser_ana` | Usuario con el que WordPress se conectará siempre. |
| Contraseña | `bdPass_ana` | Su contraseña. |
| Servidor de la base de datos | `localhost` | MySQL está en el mismo equipo. |
| Prefijo de tabla | `wp_` (por defecto) | Inicio del nombre de todas las tablas. Se cambia en la P2.4. |

Con esos datos el asistente comprueba la conexión y **crea `wp-config.php`**.

5. **Datos del sitio** (pantalla «Bienvenido»):

| Campo | Valor | Qué hace (nivel 3) |
|:------|:------|:-------------------|
| Título del sitio | `wp_ana` | Nombre que aparece en la cabecera y en la pestaña del navegador. Se cambia en la P2.2. |
| Nombre de usuario | `wpUser_ana` | Cuenta de administración. No es `admin`, que es el primero que prueban los ataques automáticos. |
| Contraseña | `wpPass_ana` | WordPress la marca como **débil**: hay que marcar «Confirma el uso de una contraseña débil». En un sitio real se acepta la que propone. |
| Tu correo electrónico | Uno creado para el módulo | Recibe los avisos y sirve para recuperar la contraseña. |
| Visibilidad en los motores de búsqueda | **Marcar** «Pedir a los motores de búsqueda que no indexen este sitio» | Es un portal **interno**: no debe aparecer en Google. Añade `noindex` y desactiva el envío al índice. |

6. **Instalar WordPress** → «¡Lo lograste!» → **Acceder**.

Detalle técnico: el usuario de la **base de datos** (`bdUser_ana`) y el administrador de **WordPress** (`wpUser_ana`) son cosas distintas. El primero lo usa WordPress para hablar con MySQL; el segundo, una persona para entrar al panel. Confundirlos es el error conceptual más frecuente.

## 4. Verificación

1. `http://localhost/wp_ana/wp-admin` → acceder con `wpUser_ana` / `wpPass_ana` → **Escritorio**.
2. Abrir `C:\Program Files\Ampps\www\wp_ana\wp-config.php` con VS Code o el Bloc de notas:

```php
/** The name of the database for WordPress */
define( 'DB_NAME', 'bd_ana' );

/** Database username */
define( 'DB_USER', 'bdUser_ana' );

/** Database password */
define( 'DB_PASSWORD', 'bdPass_ana' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );
```

3. En phpMyAdmin, `bd_ana` contiene ahora 12 tablas `wp_…` (`wp_options`, `wp_posts`, `wp_users`…).

### Qué demuestra cada comprobación y qué fallaría (nivel 3)

| Comprobación | Demuestra | Si un dato fuera incorrecto |
|:-------------|:----------|:----------------------------|
| Se abre el Escritorio | WordPress está instalado, conecta con la base de datos y la cuenta de administración funciona. | Contraseña de WordPress mal: «Error: la contraseña que has introducido…». |
| `DB_NAME`, `DB_USER`, `DB_PASSWORD` en `wp-config.php` | WordPress usa la base de datos y el usuario del paso 2, no `root`. | Cualquier dato mal en `wp-config.php`: «**Error al establecer una conexión con la base de datos**» en todo el sitio. |
| `DB_HOST` | El servidor de MySQL es el local. | Otro valor: el mismo error de conexión. |
| 12 tablas `wp_` en `bd_ana` | La instalación terminó y creó su estructura. | Si la base de datos tuviera ya tablas `wp_`, el asistente diría «WordPress ya está instalado». |

### Lista de verificación de referencia (nivel 4)

- [ ] Apache y MySQL en verde en AMPPS.
- [ ] `bdUser_ana@localhost` sin privilegios globales y con todos sobre `bd_ana`.
- [ ] `http://localhost/wp_ana` muestra el sitio.
- [ ] El panel abre con `wpUser_ana`.
- [ ] `wp-config.php`: `DB_NAME`, `DB_USER`, `DB_PASSWORD` y `DB_HOST` coinciden con lo creado.
- [ ] `bd_ana` tiene las tablas con el prefijo elegido.
- [ ] Ajustes → Lectura → Visibilidad en los motores de búsqueda: «Pedir a los motores de búsqueda que no indexen este sitio» marcado.
