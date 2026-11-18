---
layout: doc
title: Simulacro de examen de la 1.ª evaluación
sidebar: true
outline: [2, 3]
aside: true
---

# 📝 Simulacro de examen de la 1.ª evaluación

<ExportPDF />

::: info-box Ficha de la prueba
- **Unidades:** UP1, UP2 y UP3 · **RA1, RA2 y RA3**.
- **Duración:** 2 horas.
- **Parte A. Test:** 20 preguntas · 4 puntos · 30 minutos orientativos.
- **Parte B. Práctica:** 8 apartados sobre tu proyecto P3.4 · 6 puntos · 85 minutos orientativos.
- **Nota final:** suma de las dos partes, sobre 10. Se supera con 5.
:::

| Nombre y apellidos | | Fecha | |
|:--|:--|:--|:--|
| | | | |

::: tip-box Simulacro
Esta prueba tiene el mismo formato, duración y tipo de preguntas que el examen. Hazla cronometrando el tiempo: es la mejor forma de saber cómo repartirlo.
:::

## Antes de empezar

1. Arranca Apache y MySQL en XAMPP y comprueba que tu tienda (proyecto P3.4) funciona y que puedes entrar en el panel como administrador y con los demás usuarios.
2. Si tu proyecto no arranca, avisa en los **10 primeros minutos**: se te dará el proyecto base para hacer la práctica, sin penalización.
3. Crea un documento de respuestas (`Apellido_Nombre.docx` o `.odt`) con un apartado para cada ejercicio de la parte B. Al final lo exportarás a PDF.
4. No hace falta Internet: todo lo necesario está en tu proyecto. No se permite consultar apuntes ni usar asistentes de IA.

## Parte A. Test

- Cada pregunta tiene **una sola** respuesta correcta.
- Acierto: **+0,2** · Error: **−1/3 del valor (−0,067)** · En blanco: **0**.
- Si se hace en papel, marca la respuesta en la tabla del final de esta parte.

**1.** Al analizar los requisitos de un servidor para WordPress, ¿qué dato se obtiene de la documentación oficial del CMS y no de la estimación de la carga?  
<small>RA1 · CE 1a · 0,2 p</small>

- **a)** La memoria RAM necesaria para 200 clientes simultáneos.
- **b)** El ancho de banda mensual del alojamiento.
- **c)** Las versiones mínima y recomendada de PHP y del gestor de bases de datos.
- **d)** El número de núcleos de CPU del servidor.

**2.** En una aplicación web de tres capas con Apache, PHP y MariaDB, ¿qué capa ocupa MariaDB?  
<small>RA1 · CE 1b · 0,2 p</small>

- **a)** La capa de presentación.
- **b)** La capa de datos.
- **c)** La capa de lógica de negocio.
- **d)** La capa de transporte.

**3.** Después de modificar un virtual host de Apache en Ubuntu, ¿qué orden comprueba la sintaxis antes de aplicar los cambios?  
<small>RA1 · CE 1c · 0,2 p</small>

- **a)** sudo systemctl status apache2
- **b)** sudo a2ensite --check
- **c)** sudo apache2ctl -S --reload
- **d)** sudo apache2ctl configtest

**4.** Un navegador pide una página .php que también contiene JavaScript. ¿Qué recibe el navegador?  
<small>RA1 · CE 1d · 0,2 p</small>

- **a)** El HTML generado por PHP y el código JavaScript, pero no el código PHP.
- **b)** El código PHP y el JavaScript, que interpreta el propio navegador.
- **c)** Solo el código PHP, que el navegador envía después a MariaDB.
- **d)** Nada hasta que el JavaScript se ha ejecutado en el servidor.

**5.** ¿Qué extensión de PHP utiliza WordPress para conectarse a MySQL o MariaDB?  
<small>RA1 · CE 1e · 0,2 p</small>

- **a)** mbstring
- **b)** curl
- **c)** mysqli
- **d)** intl

**6.** Se quiere que el usuario de base de datos de una aplicación solo pueda conectarse desde el propio servidor. ¿Cómo se crea?  
<small>RA1 · CE 1f · 0,2 p</small>

- **a)** CREATE USER 'app'@'%' IDENTIFIED BY '…';
- **b)** CREATE USER 'app'@'localhost' IDENTIFIED BY '…';
- **c)** CREATE USER 'app'@'0.0.0.0' IDENTIFIED BY '…';
- **d)** CREATE USER 'app' FROM LOCAL IDENTIFIED BY '…';

**7.** ¿Por qué hay que borrar el archivo info.php con phpinfo() después de usarlo?  
<small>RA1 · CE 1g · 0,2 p</small>

- **a)** Porque consume mucha CPU mientras está en el servidor.
- **b)** Porque impide que WordPress se instale correctamente.
- **c)** Porque desactiva las extensiones de PHP que no se muestran.
- **d)** Porque muestra versiones, rutas y configuración que facilitan un ataque.

**8.** ¿Qué aporta un entorno con Docker Compose frente a XAMPP?  
<small>RA1 · CE 1h · 0,2 p</small>

- **a)** El entorno queda descrito en un archivo y se reproduce igual en cualquier equipo, con cada servicio aislado en su contenedor.
- **b)** Incluye un gestor de bases de datos, que XAMPP no trae.
- **c)** No necesita configurar ningún puerto.
- **d)** Es la única opción que permite usar PHP 8.

**9.** ¿Cuál es la principal ventaja de un gestor de contenidos frente a una web hecha a mano?  
<small>RA2 · CE 2a · 0,2 p</small>

- **a)** Las páginas cargan siempre más rápido.
- **b)** Personas sin conocimientos técnicos pueden publicar y actualizar contenidos desde el navegador.
- **c)** No necesita servidor web ni base de datos.
- **d)** No hay que actualizarlo nunca.

**10.** ¿En qué tipo de gestor de contenidos se clasifica Moodle?  
<small>RA2 · CE 2b · 0,2 p</small>

- **a)** Blog.
- **b)** Wiki.
- **c)** Plataforma de aprendizaje (LMS).
- **d)** Comercio electrónico.

**11.** Durante la instalación de WordPress, ¿qué archivo crea el asistente con los datos de conexión a la base de datos?  
<small>RA2 · CE 2c · 0,2 p</small>

- **a)** .htaccess
- **b)** wp-settings.php
- **c)** index.php
- **d)** wp-config.php

**12.** Una empresa modifica WordPress (licencia GPL) para usarlo en su intranet y no lo distribuye. ¿Qué le obliga la licencia?  
<small>RA2 · CE 2d · 0,2 p</small>

- **a)** Nada: las obligaciones de la GPL nacen al distribuir el software modificado.
- **b)** Publicar el código modificado en un plazo de 30 días.
- **c)** Pagar una licencia por cada usuario de la intranet.
- **d)** Cambiar el nombre del programa.

**13.** Con un tema de bloques como Twenty Twenty-Five, ¿dónde se edita el menú principal?  
<small>RA2 · CE 2e · 0,2 p</small>

- **a)** Apariencia → Menús.
- **b)** Ajustes → Lectura.
- **c)** Apariencia → Editor → Navegación (o el bloque Navegación de la cabecera).
- **d)** Ajustes → Enlaces permanentes.

**14.** ¿Qué constante de wp-config.php impide editar el código de temas y plugins desde el panel?  
<small>RA2 · CE 2f · 0,2 p</small>

- **a)** WP_DEBUG
- **b)** DISALLOW_FILE_EDIT
- **c)** FORCE_SSL_ADMIN
- **d)** WP_POST_REVISIONS

**15.** ¿Qué herramienta de WordPress revisa la configuración del servidor (PHP, extensiones, HTTPS…) y avisa de problemas?  
<small>RA2 · CE 2g · 0,2 p</small>

- **a)** Ajustes → Generales
- **b)** Escritorio → Actualizaciones
- **c)** Herramientas → Exportar
- **d)** Herramientas → Salud del sitio

**16.** ¿Qué puede hacer un usuario con el rol Colaborador en WordPress?  
<small>RA3 · CE 3b · 0,2 p</small>

- **a)** Escribir sus entradas y enviarlas a revisión, pero no publicarlas ni subir archivos.
- **b)** Publicar sus entradas sin revisión y subir imágenes.
- **c)** Editar y publicar las entradas de cualquier usuario.
- **d)** Instalar plugins, pero no cambiar el tema.

**17.** ¿Qué debe incluir una copia de seguridad completa de un sitio WordPress?  
<small>RA3 · CE 3d · 0,2 p</small>

- **a)** Solo la base de datos: los archivos se pueden volver a descargar.
- **b)** Solo la carpeta wp-content.
- **c)** La base de datos y los archivos, sobre todo wp-content/uploads.
- **d)** El archivo XML de Herramientas → Exportar.

**18.** ¿Qué genera Herramientas → Exportar en WordPress?  
<small>RA3 · CE 3e · 0,2 p</small>

- **a)** Un volcado SQL completo de la base de datos.
- **b)** Un XML (formato WXR) con entradas, páginas, comentarios y taxonomías, sin ajustes ni plugins.
- **c)** Un ZIP con todos los archivos del sitio.
- **d)** Un CSV con los usuarios y sus contraseñas.

**19.** Con los enlaces permanentes activados, ¿cuál es la URL del feed de la categoría «salud»?  
<small>RA3 · CE 3g · 0,2 p</small>

- **a)** /salud.rss
- **b)** /feed/?category=salud.xml
- **c)** /wp-json/salud/feed
- **d)** /category/salud/feed/

**20.** Sin cambiar nada, ¿qué actualizaciones del núcleo instala WordPress automáticamente?  
<small>RA3 · CE 3h · 0,2 p</small>

- **a)** Las de mantenimiento y seguridad (por ejemplo, 7.1.3 → 7.1.4).
- **b)** Ninguna: todas deben instalarse a mano.
- **c)** Todas, incluidas las versiones principales (7.1 → 7.2).
- **d)** Solo las de los plugins.

### Hoja de respuestas

| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   |   |   |   |   |   |   |   |   |

| 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   |   |   |   |   |   |   |   |   |

## Parte B. Práctica sobre tu proyecto

Trabajarás sobre la tienda ElectroHogar que entregaste en la [P3.4](./4-proyecto-integrador-cms) (XAMPP + WordPress). Los apartados se pueden hacer en cualquier orden, salvo cuando uno se refiere a otro.

En tu documento de respuestas, para cada apartado: **capturas** de lo que se pide en *Evidencias* y una **explicación breve** de lo que has hecho y por qué. Sin evidencias, el apartado no se puede puntuar.

| Apartado | RA · CE | Puntos | Tiempo orientativo |
|:--|:--|:--:|:--:|
| 1. Ajustes del intérprete PHP | RA1 · CE 1c, 1e | 0,75 | 8 min |
| 2. Copia de la base de datos en phpMyAdmin | RA1 · RA3 · CE 1f, 3e | 1 | 10 min |
| 3. Nueva sección del catálogo | RA2 · CE 2e, 2g | 1,25 | 12 min |
| 4. Mantenimiento y seguridad | RA2 · RA3 · CE 2f, 3h | 0,75 | 8 min |
| 5. Capacidades por grupo con Groups | RA3 · CE 3b, 3c | 0,75 | 15 min |
| 6. Plantilla para la página Contacto | RA3 · CE 3f | 0,5 | 7 min |
| 7. Copias de seguridad y restauración | RA3 · CE 3d | 0,75 | 15 min |
| 8. Informe de accesos | RA3 · CE 3i | 0,25 | 7 min |
| **Total** | | **6** | **82 min** |

### 1. Ajustes del intérprete PHP · 0,75 puntos

<small>RA1 · CE 1c, 1e · 8 minutos orientativos</small>

La tienda va a importar catálogos grandes. En el `php.ini` de XAMPP:

1. Sube `max_execution_time` a **120** segundos y `max_input_vars` a **3000**.
2. Aplica el cambio y demuestra **desde WordPress** que el servidor usa los valores nuevos.

**Evidencias:** Captura de las líneas de `php.ini` y de **Herramientas → Salud del sitio → Información → Servidor** con los dos valores.

### 2. Copia de la base de datos en phpMyAdmin · 1 punto

<small>RA1 · RA3 · CE 1f, 3e · 10 minutos orientativos</small>

1. Exporta con phpMyAdmin la base de datos de tu tienda en formato **SQL**.
2. Crea una base de datos nueva `tienda_pruebas` (cotejamiento `utf8mb4_unicode_ci`) e **importa** en ella el archivo.
3. Comprueba que tiene las mismas tablas y el mismo número de páginas que la original.

**Evidencias:** Capturas de la exportación, de la importación terminada y de la comparación (número de tablas y consulta o vista de `wp_posts` con las páginas).

### 3. Nueva sección del catálogo · 1,25 puntos

<small>RA2 · CE 2e, 2g · 12 minutos orientativos</small>

La tienda empieza a vender artículos de jardín.

1. Crea la subcategoría **Jardín** dentro de **Hogar**.
2. Crea la página **Jardín**, con un párrafo y una imagen, asígnale la categoría Jardín.
3. Añádela al menú en el **tercer nivel**: Productos → Hogar → Jardín.
4. Comprueba desde la parte pública, sin sesión iniciada, que el menú lleva a la página y que la página aparece en el archivo de la categoría Hogar.

**Evidencias:** Capturas de la categoría, de la página con su categoría, del editor del menú y de la parte pública (menú desplegado y archivo de Hogar).

### 4. Mantenimiento y seguridad · 0,75 puntos

<small>RA2 · RA3 · CE 2f, 3h · 8 minutos orientativos</small>

1. Limita a **5** las revisiones que WordPress guarda de cada contenido.
2. Activa las **actualizaciones automáticas** de todos los plugins que usa la tienda.
3. Elimina los plugins y temas que no se usen, dejando un tema por defecto de reserva.

**Evidencias:** Capturas de `wp-config.php`, de **Plugins** con la columna de actualizaciones automáticas y de **Apariencia → Temas**.

### 5. Capacidades por grupo con Groups · 0,75 puntos

<small>RA3 · CE 3b, 3c · 15 minutos orientativos</small>

Los autores del grupo **Contenidos web** deben poder editar las páginas de producto sin cambiarles el rol.

1. Con el plugin Groups, asigna al grupo **Contenidos web** las capacidades **mínimas** para que sus miembros puedan editar las páginas de producto que ya existen (las creó otra persona y están publicadas), sin poder borrarlas ni crear páginas nuevas.
2. Comprueba con un **autor del grupo** que ahora puede editar y actualizar la página Móviles, y con un usuario que no sea del grupo que no puede.
3. Explica por qué es mejor esta solución que convertir a esos autores en editores.

**Evidencias:** Capturas de las capacidades del grupo y de las dos comprobaciones (Móviles actualizada por el autor del grupo; menú Páginas ausente para el otro usuario).

### 6. Plantilla para la página Contacto · 0,5 puntos

<small>RA3 · CE 3f · 7 minutos orientativos</small>

Crea una **plantilla personalizada** para páginas, sin el título de la página y con el contenido a ancho amplio, y aplícala solo a **Contacto**.

**Evidencias:** Capturas de la plantilla en el editor del sitio, del selector de plantilla de la página Contacto y de la parte pública de Contacto comparada con Sobre nosotros.

### 7. Copias de seguridad y restauración · 0,75 puntos

<small>RA3 · CE 3d · 15 minutos orientativos</small>

1. Cambia la programación de UpdraftPlus: archivos **semanal** conservando 4 copias, base de datos **diaria** conservando 7.
2. Haz una **copia de seguridad ahora** completa.
3. Borra **permanentemente** la página **Sobre nosotros** (también de la papelera).
4. **Restaura** la copia y comprueba que la página vuelve con su contenido, su categoría y su enlace en el menú.

**Evidencias:** Capturas de la programación, de la copia en *Copias de seguridad existentes*, de la papelera vacía, del proceso de restauración y de la página recuperada en la parte pública.

### 8. Informe de accesos · 0,25 puntos

<small>RA3 · CE 3i · 7 minutos orientativos</small>

1. Desde una ventana privada, visita la página Jardín y una dirección que no exista (por ejemplo `/ofertas-black-friday/`).
2. Localiza esas dos peticiones en el registro de accesos de Apache de XAMPP e interpreta cada campo.

**Evidencias:** Captura de la orden de búsqueda y de las líneas encontradas, con la explicación.

## Cómo se puntúa la práctica

Cada apartado se valora con la [escala de niveles 0–4](/general/contenidos/3-evaluacion) del módulo y se convierte en puntos de forma proporcional:

| Nivel | Significado | Puntos del apartado |
|:--:|:--|:--:|
| 0 | No hecho o sin relación con lo pedido | 0 % |
| 1 | Incompleto o incorrecto: faltan elementos esenciales | 25 % |
| 2 | Correcto y completo, sin justificar | 50 % |
| 3 | Correcto, completo y justificado | 75 % |
| 4 | Además, coherente con el resto del proyecto y bien comunicado | 100 % |

## Entrega

1. Al terminar, haz con UpdraftPlus una **copia de seguridad ahora** (solo base de datos basta).
2. Exporta el documento de respuestas a **PDF**.
3. Entrega el PDF y el archivo `…-db.gz` de la copia (está en `C:\xampp\htdocs\<tu-sitio>\wp-content\updraft`) por el medio que indique el profesorado (Aules o el servidor del aula).
4. Reserva los **5 últimos minutos** para la entrega.

---

**Volver a:** [Prácticas de UP3](./)
