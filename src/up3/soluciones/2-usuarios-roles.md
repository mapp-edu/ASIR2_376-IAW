---
layout: doc
title: "Solución P3.2 — Usuarios, roles y registro de actividad"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P3.2 — Usuarios, roles y registro de actividad

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P3.2 Usuarios, roles y actividad](../ejercicios/2-usuarios-roles).
:::

- **Unidad:** UP3 · RA3 · CE 3b, 3i.
- **Archivos de la solución:**
  - <a :href="withBase('/soluciones/up3/p3.2-usuarios-roles/equipo-revista.sh')" download><code>equipo-revista.sh</code></a>: crea el equipo y el rol Corrector con WP-CLI y **comprueba cada permiso** con peticiones reales a la API REST (lo que hace por debajo el editor de bloques). Sirve para enseñarlo en clase o para comparar.
- **Probado** con WordPress 7.1.4, Members 3.3.2 y Simple History 5.37: todos los permisos de la tabla del paso 2–5, la baja con y sin reasignación, el registro de actividad y el `access.log` de Apache.

---

## 1. Usuarios del equipo

**Usuarios → Añadir nuevo usuario**. Una cuenta por persona, correo propio, **Generar contraseña** (o una de 12+ caracteres) y desmarcar el envío por correo si el servidor no lo tiene configurado.

| Persona | Usuario | Rol | Por qué (mínimo privilegio, nivel 3) |
|:--------|:--------|:----|:-------------------------------------|
| Directora | `directora` (o su nombre) | **Administrador** | Es la responsable del sitio: plugins, ajustes y usuarios. Una sola cuenta de administración. |
| Editor 1 | `lmartin` | **Editor** | Revisa y publica el trabajo de todos y modera comentarios; no necesita tocar plugins, ajustes ni usuarios. |
| Editor 2 | `cruiz` | **Editor** | Ídem. Dos editores para que la revisión no dependa de una persona. |
| Autor de plantilla | `jlopez` | **Autor** | Publica lo suyo sin revisión y sube imágenes; no toca el trabajo de los demás. |
| Colaborador externo 1 | `mgarcia` | **Colaborador** | Su trabajo se revisa antes de publicarse y no sube archivos al servidor. |
| Colaborador externo 2 | `pnavarro` | **Colaborador** | Ídem. |

Ninguno se llama `admin`. Si la instalación de la UP2 tiene un administrador llamado `admin`, se crea uno nuevo y se borra `admin` atribuyendo su contenido.

Capacidades de cada rol, obtenidas de la instalación de prueba (extracto):

| Capacidad | Administrador | Editor | Autor | Colaborador |
|:----------|:-------------:|:------:|:-----:|:-----------:|
| `publish_posts` publicar entradas | sí | sí | sí | — |
| `upload_files` subir archivos | sí | sí | sí | — |
| `edit_others_posts` editar entradas de otros | sí | sí | — | — |
| `delete_others_posts` borrar entradas de otros | sí | sí | — | — |
| `edit_published_posts` editar lo ya publicado | sí | sí | sí | — |
| `edit_pages` / `publish_pages` páginas | sí | sí | — | — |
| `moderate_comments`, `manage_categories` | sí | sí | — | — |
| `unfiltered_html` HTML y JavaScript sin filtrar | sí | sí | — | — |
| `manage_options`, `install_plugins`, `list_users` | sí | — | — | — |

## 2–4. Comprobación de permisos

Cada prueba con **una ventana privada por usuario** (o cerrando sesión), con capturas.

| Prueba | Resultado esperado en el panel | Resultado comprobado (API REST) |
|:-------|:-------------------------------|:--------------------------------|
| Colaborador escribe una entrada | El botón no dice «Publicar» sino **Enviar a revisión** | Publicar directamente: **403** `rest_cannot_publish` |
| Colaborador la envía | Queda **Pendiente** | **201**, estado `pending` |
| Colaborador intenta subir imagen | No aparece **Medios** en el menú; en el bloque Imagen solo puede **insertar desde URL** | **403** `rest_cannot_create` |
| Editor revisa y publica | **Entradas → Pendientes** → abrir → **Publicar** | **200**, estado `publish` |
| Colaborador intenta editar su entrada ya publicada | No aparece el enlace **Editar** | **403** `rest_cannot_edit` |
| Autor publica la suya | Botón **Publicar** | **201**, `publish` |
| Autor intenta editar la de otro | Ve la entrada en la lista, pero sin **Editar** | **403** `rest_cannot_edit` |

Detalle importante: el colaborador **no puede modificar su artículo una vez publicado** (no tiene `edit_published_posts`). Si quiere corregirlo, se lo pide a un editor.

## 5. Rol **Corrector**

Con **Members** (o **User Role Editor**): menú **Members → Añadir nuevo rol** (en Members 3.x; versiones antiguas lo ponían en **Usuarios → Roles**) → nombre «Corrector» → marcar en **Entradas**:

| Capacidad | Marcar | Por qué |
|:----------|:------:|:--------|
| `read` | ✔ | Entrar en el panel. |
| `edit_posts` | ✔ | Editar entradas (base de todas las demás). |
| `edit_others_posts` | ✔ | Editar las de **cualquier** autor. |
| `edit_published_posts` | ✔ | Corregir las que ya están publicadas. |
| `publish_posts` | ✔ | Publicar. |
| `delete_posts`, `delete_others_posts`, `delete_published_posts` | ✘ | No puede borrar. |
| `edit_pages`, `publish_pages`, `delete_pages`… | ✘ | No gestiona páginas. |
| `upload_files` | ✘ (opcional) | No se pide. Si se marca y se justifica (insertar imágenes en las correcciones), se acepta. |

Equivalente con WP-CLI: `wp role create corrector Corrector` y `wp cap add corrector read edit_posts edit_others_posts edit_published_posts publish_posts`.

Usuario nuevo `acorrea` con rol Corrector. Comprobado:

| Prueba | Resultado |
|:-------|:----------|
| Editar y guardar una entrada publicada de otro autor | **200** ✔ |
| Publicar una entrada pendiente de un colaborador | **200** ✔ |
| Borrar una entrada | **403** `rest_cannot_delete` ✔ (no aparece **Papelera**) |
| Crear o editar una página | **403** ✔ (no aparece el menú **Páginas**) |
| Subir una imagen | **403** ✔ |

Con Members hay además **Denegar** junto a cada capacidad: denegar prevalece sobre conceder, útil si el usuario tiene varios roles.

### Comparación con los roles predefinidos (nivel 4)

| | Corrector | Editor | Autor |
|:--|:--|:--|:--|
| Editar entradas de otros | Sí | Sí | No |
| Publicar | Sí | Sí | Solo lo suyo |
| Borrar | **No** | Sí, todo | Lo suyo |
| Páginas, categorías, comentarios | **No** | Sí | No |
| Subir archivos | No | Sí | Sí |

El Editor tiene permisos de más (borrar, páginas, comentarios) y el Autor de menos (no toca lo de otros). Conviene crear un rol cuando **ninguno de los predefinidos encaja sin dar permisos de más**; y no conviene si basta con uno existente, porque cada rol propio es una configuración más que documentar y revisar.

## 6. Registro de actividad

Plugin **Simple History** (o **WP Activity Log**). Acciones de prueba: inicio de sesión del colaborador, publicación del editor, intento con contraseña incorrecta, intento con un usuario inexistente. Informe en el menú **Simple History** (o **Escritorio → Simple History**, según la configuración del plugin), filtrable por usuario, fecha y tipo, y exportable a CSV/JSON.

Entradas obtenidas en la prueba (de más reciente a más antigua):

```
info     Logged in                                                (lmartin)
warning  Failed to login with username "noexiste" (username does not exist)
warning  Failed to login with username "lmartin" (incorrect password entered)
info     Logged in                                                (mgarcia)
info     Updated post "Artículo de Marta"                         (publicado por lmartin)
info     Created post "Artículo de Marta"                         (mgarcia, pendiente)
info     Created user acorrea with role corrector
```

## 7. `wp-login.php` en el registro de Apache

```bash
sudo grep "wp-login.php" /var/log/apache2/access.log | tail     # o el log del sitio / el del alojamiento
```

Las mismas cuatro pruebas en el `access.log`:

```
127.0.0.1 - - [18/Nov/2026:09:53:05 +0000] "POST /wp-login.php HTTP/1.1" 302 1192 "-" "…"   ← correcto
127.0.0.1 - - [18/Nov/2026:09:53:05 +0000] "POST /wp-login.php HTTP/1.1" 200 6572 "-" "…"   ← contraseña mal
127.0.0.1 - - [18/Nov/2026:09:53:05 +0000] "POST /wp-login.php HTTP/1.1" 200 6535 "-" "…"   ← usuario inexistente
127.0.0.1 - - [18/Nov/2026:09:53:05 +0000] "POST /wp-login.php HTTP/1.1" 302 1192 "-" "…"   ← correcto
```

Cómo leerlo: `POST` es el envío del formulario; **302** (redirección al panel) significa acceso correcto; **200** significa que WordPress ha vuelto a mostrar el formulario, es decir, **acceso fallido**. Los `GET /wp-login.php` son solo abrir la página.

En AMPPS: `C:\Program Files\Ampps\apache\logs\access.log`. En un alojamiento compartido: sección *Registros* o *Estadísticas* del panel, si existe.

### Diferencia entre los dos registros (nivel 3)

| | Registro del servidor (Apache) | Registro de actividad (plugin) |
|:--|:--|:--|
| Qué guarda | Cada petición HTTP: IP, fecha, método, URL, código, tamaño, navegador | Acciones con significado en WordPress: quién inició sesión, qué publicó, borró o cambió |
| Usuario | **No** (el usuario va en el cuerpo del POST) | Sí, y el motivo del fallo |
| Visitas y robots | Sí, todas, también las de páginas públicas y los ataques | Solo lo que pasa por WordPress |
| Si WordPress falla o se manipula | Sigue registrando | Puede perderse o borrarse desde el panel |
| Para qué | Detectar ataques, errores, tráfico | Auditar quién hizo cada cambio |

Se complementan: el de Apache prueba que hubo 40 POST fallidos desde una IP; el del plugin dice con qué usuarios lo intentaron.

### Qué revisar periódicamente (nivel 4)

- Cada semana: inicios de sesión fallidos (muchos seguidos desde la misma IP → fuerza bruta: limitar intentos o bloquear la IP).
- Accesos correctos a horas o desde lugares raros; usuarios que entran y no deberían.
- Altas de usuarios, cambios de rol, plugins instalados o activados: solo debe hacerlos la directora.
- Contenidos borrados.
- En Apache: códigos 404 en masa (escaneos), peticiones a `xmlrpc.php`, picos de 500.
- Cuentas sin actividad en meses: candidatas a baja.

## 8. Baja de un colaborador sin perder sus artículos

**Usuarios → pasar el ratón sobre el colaborador → Borrar** → WordPress pregunta qué hacer con su contenido → **Atribuir todo el contenido a:** (un editor) → **Confirmar borrado**.

Comprobado:

- **Con reasignación**: la entrada pendiente de `pnavarro` pasó a tener como autor al editor; el usuario desapareció.
- **Sin reasignación** («Borrar todo el contenido»): la entrada de `mgarcia` se fue a la **papelera**. Se puede recuperar durante 30 días, pero queda sin autor válido: es lo que **no** hay que hacer.

Alternativa que conserva la firma del artículo (nivel 4): **no borrar** la cuenta, sino quitarle el acceso: cambiar el rol a **— Sin rol en este sitio —**, cambiar su contraseña por una aleatoria y **Cerrar todas las sesiones** en su perfil. Los artículos siguen apareciendo con su nombre y la persona no puede entrar.
