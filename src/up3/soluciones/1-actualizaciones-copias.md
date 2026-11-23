---
layout: doc
title: "Solución P3.1 — Actualizaciones, plugins, copias de seguridad e importación"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P3.1 — Actualizaciones, plugins, copias de seguridad e importación

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P3.1 Actualizaciones, plugins y copias](../ejercicios/1-actualizaciones-copias).
:::

- **Unidad:** UP3 · RA3 · CE 3c, 3d, 3e, 3h. Proyecto del portal interno.
- **Punto de partida:** el portal de la P2.2 (WordPress en AMPPS).
- **Entrega del alumnado:** puntos 3, 4, 5 y 6 del manual de usuario.
- **Probado** con WordPress 7.1.4 y el importador oficial (WordPress Importer 0.9.7): actualizaciones automáticas, exportación e importación de páginas. **UpdraftPlus no se ha podido instalar** en el entorno de preparación (sin acceso al repositorio de plugins); sus pasos siguen su documentación oficial.

::: danger Dos trampas comprobadas en la exportación e importación
1. **Si las páginas borradas siguen en la Papelera, la importación no las recupera.** El importador dice «La página “Comunicados” ya existe» y la salta, porque compara título y fecha también con las de la papelera. Comprobado: tras importar, las páginas seguían sin aparecer. Hay que **vaciar la papelera** (o borrar permanentemente) antes de importar.
2. **El menú depende de los identificadores de las páginas.** Al vaciar la papelera, el importador intenta reutilizar los mismos ID y, en la prueba, los recuperó: jerarquía y menú intactos. Pero si esos ID ya están ocupados, las páginas reciben otros nuevos y los enlaces del menú quedan rotos. Por eso hay que comprobar el menú después de importar.
:::

---

## Punto 3. Parches y actualizaciones

### 1. Versión instalada

- **Escritorio → Actualizaciones**: «Tienes la última versión de WordPress» o «Hay disponible una versión nueva», con la versión actual.
- También en **Escritorio → Inicio → De un vistazo** («WordPress 7.1.4 con el tema Twenty Twenty-Five») y en el pie de cualquier pantalla del panel.
- Más detalle: **Herramientas → Salud del sitio → Información → WordPress**.

### 2. Actualizaciones pendientes

La misma pantalla lista tres bloques: **WordPress**, **Plugins** y **Temas** (y **Traducciones**). El botón **Comprobar de nuevo** consulta los servidores de WordPress. En AMPPS hace falta conexión a Internet.

Si hay algo pendiente: **copia de seguridad antes** (punto 5) y después **Actualizar**.

### 3. Actualizaciones automáticas del núcleo

**Escritorio → Actualizaciones** → **Activar las actualizaciones automáticas para todas las nuevas versiones de WordPress**.

| Estado | Qué se instala solo |
|:-------|:--------------------|
| Por defecto | Solo las versiones **de mantenimiento y seguridad** (7.1.4 → 7.1.5). |
| Tras activarlo | También las **versiones principales** (7.1 → 7.2). |

Comprobado en el código de WordPress 7.1: el enlace guarda la opción `auto_update_core_major = enabled`; las menores (`auto_update_core_minor`) ya están activadas por defecto. Si `wp-config.php` define `WP_AUTO_UPDATE_CORE` o `AUTOMATIC_UPDATER_DISABLED`, la pantalla lo indica y no deja cambiarlo: es un error frecuente en alojamientos que lo fijan.

En AMPPS las actualizaciones automáticas dependen de WP-Cron, que solo se ejecuta cuando alguien visita el sitio.

## Punto 4. Gestión de plugins

### Dónde están

- **Plugins → Plugins instalados**: lista, estado (activo o inactivo), versión, autor, y la columna **Actualizaciones automáticas**.
- En disco: `wp-content/plugins/<carpeta-del-plugin>/` (en AMPPS, `C:\Program Files\Ampps\www\wp_<nombre>\wp-content\plugins`).
- Si hay versión nueva, aparece una franja «Hay disponible una nueva versión de …» con **Actualizar ahora**, y un número en el menú **Plugins**.

### Actualizar uno

**Actualizar ahora** en su fila, o marcarlo y **Acciones en lote → Actualizar**. Si no hay ninguno pendiente (instalación reciente), se puede instalar una versión anterior de un plugin desde su página de *Desarrollo → Versiones anteriores* para practicar; el error habitual es decir «no había nada que actualizar» y no demostrar el paso.

### Actualizaciones automáticas

Columna **Actualizaciones automáticas → Activar las actualizaciones automáticas** en la fila del plugin. Aparece la fecha de la próxima comprobación.

### Instalar UpdraftPlus

**Plugins → Añadir nuevo plugin** → buscar «UpdraftPlus» → **Instalar ahora** → **Activar**. Aparece en **Ajustes → Copias de seguridad de UpdraftPlus**.

### Por qué UpdraftPlus (nivel 3 de CE 3c)

El portal guarda comunicados e incidencias que la empresa no puede perder, y AMPPS no hace copias. UpdraftPlus cubre esa necesidad: copia **base de datos y archivos**, la **programa**, la **envía fuera** del equipo y **restaura** desde el propio panel, sin línea de órdenes. Es de los plugins de copias más usados del repositorio oficial y se mantiene al día.

### Cómo valorar un plugin nuevo (nivel 4)

Lista que debería aparecer en el manual, aplicable a cualquier plugin:

| Pregunta | Dónde se mira |
|:---------|:--------------|
| ¿Qué necesidad concreta cubre? ¿Lo hace ya otro plugin instalado? | Antes de buscar |
| ¿Es compatible con mi versión de WordPress y PHP? | Ficha del plugin: «Probado hasta», «Versión de PHP» |
| ¿Se mantiene? | «Última actualización» (desconfiar si pasa de un año) |
| ¿Lo usa mucha gente y funciona? | «Instalaciones activas», valoraciones y foro de soporte |
| ¿Qué es gratis y qué es de pago? | Ficha y web del desarrollador |
| ¿De dónde viene? | Solo del repositorio oficial o del desarrollador: nunca versiones «gratis» de plugins de pago |
| ¿Funciona en mi sitio? | Probarlo primero en una copia o en local |

## Punto 5. Copias de seguridad con UpdraftPlus

### 1. Programar

**Ajustes → Copias de seguridad de UpdraftPlus → Ajustes**:

| Ajuste | Valor de referencia | Justificación (nivel 3) |
|:-------|:--------------------|:------------------------|
| Programación de la copia de **archivos** | **Semanal**, conservar **4** | Los archivos (temas, plugins, medios) cambian poco en un portal de comunicados. |
| Programación de la copia de la **base de datos** | **Diaria**, conservar **14** | Los comunicados e incidencias se publican a diario: como mucho se perdería un día de trabajo. |
| Incluir en la copia | Plugins, temas, *uploads* y otros | `uploads` es lo único que no se puede volver a descargar. |

La versión gratuita permite cada 2, 4, 8 o 12 horas, diaria, semanal, quincenal o mensual, pero **no elegir la hora**; las copias incrementales y el cifrado de la base de datos son de pago. Como depende de WP-Cron, en AMPPS solo se ejecuta si el sitio recibe visitas: para la práctica, además, **Copia de seguridad ahora**.

### 2. Destino externo

En **Ajustes → Elige tu almacenamiento remoto**. En la versión gratuita: **Google Drive, Dropbox, Amazon S3, Rackspace, FTP, DreamObjects, OpenStack Swift y correo electrónico**. OneDrive, SFTP, WebDAV, Backblaze o Azure son de pago, y la versión gratuita solo envía cada copia a **un** destino.

Referencia: **Google Drive** o **Dropbox** con una cuenta creada para el módulo → **Guardar cambios** → seguir el enlace de autorización → volver al panel. Comprobación: la copia siguiente muestra el icono del destino y los archivos aparecen en la carpeta `UpdraftPlus` del servicio.

Lo que **no** vale como destino externo: dejar las copias en `wp-content/updraft` (es el mismo equipo) o el correo si la copia supera el límite de adjuntos.

### 3. Restaurar

Prueba recomendada, para que la restauración se vea:

1. **Copia de seguridad ahora** (marcar archivos y base de datos).
2. Hacer un cambio visible: borrar permanentemente una página o cambiar el título del sitio.
3. **Copia de seguridad / Restaurar → Copias de seguridad existentes → Restaurar** en la copia del paso 1.
4. Marcar los componentes (**Base de datos** basta para el cambio del paso 2) → **Siguiente** → **Restaurar**.
5. Comprobar que la página o el título han vuelto.

Si la copia solo está en el destino remoto, UpdraftPlus la descarga antes (*Recuperar del almacenamiento remoto*).

### Procedimiento ante un fallo (nivel 4)

| Situación | Qué hacer |
|:----------|:----------|
| Se borró un contenido | Restaurar solo la **base de datos** de la copia anterior (se pierde lo publicado después). |
| Una actualización rompió el sitio pero el panel funciona | Restaurar **plugins** y/o **temas** de la copia previa a la actualización. |
| No se puede entrar al panel | Instalar un WordPress limpio, instalar UpdraftPlus, conectar el mismo destino remoto, **Volver a examinar el almacenamiento remoto** y restaurar todo. |
| Se perdió el equipo | Lo mismo en otro equipo: por eso la copia tiene que estar fuera. |

Relación con la teoría: regla **3-2-1** (el sitio, la copia local y la remota) y «una copia que nunca se ha restaurado no está comprobada».

## Punto 6. Exportación e importación

### 1. Exportar las páginas

**Herramientas → Exportar** → **Páginas** (opcionalmente filtrar por estado) → **Descargar el archivo de exportación**. Se descarga `<sitio>.WordPress.<fecha>.xml`.

Comprobado: el archivo contiene un `<item>` por página, **también los borradores** (por ejemplo «Política de privacidad»), con título, contenido, *slug*, estado, fecha, autor, plantilla y **página superior** (`wp:post_parent`). No contiene el menú (es un objeto aparte) ni las imágenes, solo sus URL.

### 2. Eliminar páginas

**Páginas** → marcar varias (incluida una con subpáginas) → **Mover a la papelera** → **Papelera → Vaciar papelera**. **Sin vaciar la papelera, el paso 3 no funciona** (ver el aviso inicial).

### 3. Importar

**Herramientas → Importar → WordPress → Instalar ahora → Ejecutar el importador** → subir el XML → **Asignar autores**: asignar las páginas a un usuario existente → (si hubiera adjuntos, «Descargar e importar archivos adjuntos») → **Enviar**. Mensaje final: «Todo hecho. ¡Diviértete!».

### Cómo comprobar que la importación es correcta (nivel 4)

| Comprobación | Resultado esperado |
|:-------------|:-------------------|
| Número de páginas | Igual que antes de borrar (anotarlo antes). |
| Mensajes del importador | Ninguna página «ya existe» (si aparece, estaba en la papelera). |
| Jerarquía | Generales y Urgentes siguen dentro de Comunicados (columna o atributo *Superior*). |
| URL | `/comunicados/urgentes/` responde. |
| Contenido y estado | Igual que antes; los borradores siguen siendo borradores. |
| Menú | Todos los elementos llevan a su página (si alguna recibió otro ID, el enlace queda roto y hay que volver a añadirla). |
| Portada | Si «Inicio» era la portada estática, **Ajustes → Lectura** sigue apuntando a ella. |

### Exportación frente a copia de seguridad (nivel 3 de CE 3e)

| | Exportación (WXR) | Copia de seguridad (UpdraftPlus) |
|:--|:--|:--|
| Formato | Un XML legible | ZIP de archivos + SQL de la base de datos |
| Contiene | Entradas, páginas, comentarios, categorías, etiquetas, menús clásicos y referencias a medios | Todo: base de datos completa (ajustes, usuarios, plugins activos) y archivos |
| No contiene | Ajustes, usuarios con contraseña, plugins, temas, archivos multimedia | — |
| Para qué | **Trasladar contenidos** a otro WordPress o entre sitios | **Recuperar el sitio** tal como estaba |
| Al restaurar | Añade contenidos; no sobrescribe | Sustituye el estado del sitio |

---

## Rutina de actualización del portal (nivel 4 de CE 3h)

1. Actualizaciones de seguridad del núcleo y de plugins de confianza: **automáticas**.
2. Cada semana: revisar **Escritorio → Actualizaciones**, leer los cambios de las versiones principales.
3. Antes de una versión principal o de un plugin importante: **Copia de seguridad ahora** (enlaza con el punto 5) y, si es posible, probar en una copia local.
4. Actualizar, recorrer el portal (menú, portada, formularios) y revisar **Salud del sitio**.
5. Si algo falla: restaurar plugins/temas o base de datos de la copia del paso 3.
6. Borrar plugins y temas que no se usen: también hay que actualizarlos aunque estén desactivados.

### Riesgos que evita actualizar y qué puede romper (nivel 3)

- **Evita**: vulnerabilidades conocidas y publicadas, que los robots explotan de forma automática días después de salir el parche (la mayoría de los sitios WordPress comprometidos lo son por plugins sin actualizar).
- **Puede romper**: incompatibilidades entre un plugin y la versión nueva del núcleo o de PHP, cambios en el editor o en los bloques que alteran el diseño, errores fatales que dejan el sitio en blanco. Por eso las actualizaciones automáticas de versiones principales se combinan con copias frecuentes.
