---
layout: doc
title: Aplicaciones de ofimática web
sidebar: true
outline: [2, 3]
aside: true
---

# 📎 Aplicaciones de ofimática web

<ExportPDF />

Las **aplicaciones de ofimática web** son procesadores de texto, hojas de cálculo, presentaciones, calendarios o gestores de archivos que funcionan en el navegador. Los datos se guardan en un servidor y no en el equipo de cada persona, lo que permite trabajar desde cualquier dispositivo y editar un mismo documento entre varias personas a la vez.

Para quien administra los sistemas de una organización, la pregunta no es solo qué aplicación usar, sino **dónde** van a estar los datos, **quién** accede a ellos y **cómo** se integran con el resto de servicios.

## Tipos de aplicaciones

| Tipo | Qué permite | Ejemplos |
|:-----|:------------|:---------|
| **Procesador de textos** | Redactar documentos con formato, comentarios y control de cambios. | Google Docs, Word para la web, ONLYOFFICE Docs, Collabora Online |
| **Hoja de cálculo** | Tablas, fórmulas, gráficos y análisis de datos. | Google Sheets, Excel para la web, ONLYOFFICE, Collabora |
| **Presentaciones** | Diapositivas con texto, imágenes, vídeo, transiciones y animaciones. | Google Slides, PowerPoint para la web, ONLYOFFICE |
| **Gestión de archivos** | Almacenar, sincronizar, compartir y versionar archivos. | Google Drive, OneDrive, Nextcloud Files |
| **Calendario** | Eventos, recordatorios y calendarios compartidos. | Google Calendar, Outlook, Nextcloud Calendar |
| **Citas** | Que otras personas reserven un hueco libre en tu agenda. | Páginas de reserva de Google Calendar, Microsoft Bookings, Nextcloud Appointments |
| **Tareas** | Listas de pendientes con fechas, responsables y estados. | Google Tasks, Microsoft To Do y Planner, Nextcloud Tasks y Deck |
| **Correo y contactos** | Mensajería y libretas de direcciones compartidas. | Gmail, Outlook, Nextcloud Mail y Contacts |
| **Comunicación** | Chat y videollamadas. | Google Meet, Teams, Nextcloud Talk |

## Funcionalidades comunes

- **Accesibles** desde cualquier dispositivo con un navegador.
- **Colaboración en tiempo real:** varias personas editan el mismo documento y ven los cambios de las demás al momento, con comentarios y menciones.
- **Almacenamiento en un servidor**, con historial de versiones de cada documento.
- **Integración** entre las aplicaciones: un evento del calendario enlaza a un documento, una tarea a un archivo.
- **Plantillas** para documentos habituales.
- **Seguridad:** permisos por documento, cifrado de las comunicaciones, autenticación en dos pasos.
- **Actualizaciones automáticas** en los servicios en la nube.
- **Interoperabilidad:** abren y guardan en formatos estándar (OpenDocument, OOXML de Microsoft Office, PDF).
- **Funciones avanzadas:** fórmulas, macros, automatización, asistentes de inteligencia artificial.

## Modelos de implantación

| | **Servicio en la nube (SaaS)** | **Autoalojada** |
|:--|:-------------------------------|:----------------|
| **Ejemplos** | Google Workspace, Microsoft 365, Zoho Workplace | Nextcloud con Nextcloud Office (Collabora) u ONLYOFFICE |
| **Dónde están los datos** | En los centros de datos del proveedor. | En un servidor de la organización o de un proveedor elegido. |
| **Instalación** | Ninguna: se contrata y se dan de alta los usuarios. | Hay que instalar, configurar y mantener el servidor. |
| **Coste** | Suscripción por usuario y mes. | Software libre; coste del servidor y de su administración. |
| **Control y privacidad** | Depende de las condiciones del proveedor. | Total. Facilita cumplir el RGPD y la normativa de protección de datos. |
| **Integración con la intranet** | Mediante las APIs y conectores del proveedor. | Directa: mismo servidor, mismos usuarios (LDAP). |

En este módulo se instala **Nextcloud**, por ser software libre, autoalojado y basado en la misma pila LAMP que el resto del curso. Google Workspace y Microsoft 365 se estudian como referencia.

## Requisitos

### Para usar una aplicación en la nube

- **Conexión a Internet** estable. Algunas aplicaciones permiten trabajar sin conexión y sincronizan después.
- **Navegador actualizado** y compatible: Chrome, Firefox, Edge o Safari.
- **Cuenta de usuario** en el servicio.
- **Hardware modesto:** el procesamiento lo hace el servidor. Para documentos grandes o vídeo conviene más memoria.
- **Espacio de almacenamiento** suficiente en la cuenta.

### Para autoalojar Nextcloud

- Un servidor **LAMP** o **LEMP** con PHP en una versión admitida por la versión de Nextcloud y las extensiones que pide.
- **MariaDB o MySQL** (o PostgreSQL).
- **HTTPS** con un certificado válido: las aplicaciones de escritorio y móvil lo exigen.
- **Almacenamiento** para los archivos de los usuarios, fuera de la carpeta pública.
- Para editar documentos en línea, un **servidor de documentos**: Collabora Online o ONLYOFFICE Docs, normalmente en un contenedor aparte.

Los requisitos exactos de cada versión están en el [manual de administración de Nextcloud](https://docs.nextcloud.com/server/latest/admin_manual/installation/system_requirements.html).

## Instalación de Nextcloud en un servidor LAMP

Sobre el servidor Ubuntu de la [UP1](/up1/contenidos/5-instalacion-servidores), con Apache, PHP y MariaDB instalados:

### 1. Extensiones de PHP y base de datos

```bash
sudo apt install php-curl php-gd php-mbstring php-xml php-zip php-intl \
                 php-bcmath php-gmp php-imagick php-apcu unzip
```

```sql
CREATE DATABASE nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'una-contraseña-segura';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Descarga y permisos

```bash
cd /tmp
wget https://download.nextcloud.com/server/releases/latest.zip
unzip latest.zip
sudo mv nextcloud /var/www/nextcloud
sudo mkdir /var/nextcloud-data
sudo chown -R www-data:www-data /var/www/nextcloud /var/nextcloud-data
```

El directorio de datos va **fuera** de la carpeta pública, por la misma razón que el `moodledata` de Moodle: que nadie pueda descargar los archivos escribiendo su URL.

### 3. Sitio en Apache

```apache
<VirtualHost *:80>
    ServerName nube.empresa.local
    DocumentRoot /var/www/nextcloud
    <Directory /var/www/nextcloud>
        Require all granted
        AllowOverride All
        Options FollowSymLinks MultiViews
    </Directory>
</VirtualHost>
```

```bash
sudo a2ensite nextcloud.conf
sudo a2enmod rewrite headers env dir mime
sudo systemctl reload apache2
```

### 4. Asistente de instalación

Al abrir `http://nube.empresa.local`, el asistente pide la cuenta de administración, el directorio de datos (`/var/nextcloud-data`) y los datos de la base de datos. También se puede instalar desde la línea de órdenes con la herramienta `occ`:

```bash
cd /var/www/nextcloud
sudo -u www-data php occ maintenance:install \
     --database mysql --database-name nextcloud \
     --database-user nextcloud --database-pass 'una-contraseña-segura' \
     --admin-user admin_nube --admin-pass 'otra-contraseña-segura' \
     --data-dir /var/nextcloud-data
```

### 5. Ajustes posteriores

- Añadir el nombre del servidor a los **dominios de confianza** (`trusted_domains` en `config/config.php`).
- Configurar las **tareas en segundo plano** con *cron* para el usuario `www-data`:

  ```bash
  sudo crontab -u www-data -e
  # añadir:
  */5 * * * * php -f /var/www/nextcloud/cron.php
  ```

- Revisar **Configuración de administración → Vista general**: Nextcloud comprueba la instalación y avisa de lo que falta (caché, cabeceras de seguridad, HTTPS…).

::: tip-box Alternativas más rápidas
Para una prueba, Nextcloud se puede instalar con su imagen de contenedor **Nextcloud All-in-One**, que incluye la base de datos, el servidor de documentos y las copias de seguridad, o con el paquete `snap install nextcloud`.
:::

### 6. Edición de documentos en línea

Desde **Aplicaciones**, instala **Nextcloud Office** (basado en Collabora Online) u **ONLYOFFICE**, y configura en sus ajustes la dirección del servidor de documentos. A partir de ese momento, los documentos de texto, hojas de cálculo y presentaciones se abren y se editan en el navegador, entre varias personas a la vez.

## Configuración

- **Preferencias de cada usuario:** idioma, zona horaria, foto, notificaciones, formato de archivo por defecto.
- **Aplicaciones:** Nextcloud se amplía con aplicaciones (Calendar, Contacts, Tasks, Deck, Talk, Forms…), que el administrador activa o desactiva.
- **Apariencia:** nombre, logotipo y colores corporativos, en **Configuración de administración → Personalización**.
- **Correo saliente:** un servidor SMTP para enviar avisos y enlaces compartidos.
- **Clientes de escritorio y móvil:** sincronizan una carpeta del equipo con el servidor.

## Integración de aplicaciones heterogéneas

Una organización usa aplicaciones de distintos fabricantes que deben intercambiar datos y compartir usuarios. Los mecanismos más habituales son:

| Mecanismo | Para qué | Ejemplos |
|:----------|:---------|:---------|
| **Protocolos estándar** | Que cualquier cliente acceda a los datos. | WebDAV (archivos), CalDAV (calendarios y tareas), CardDAV (contactos) |
| **Directorio de usuarios** | Que todas las aplicaciones usen las mismas cuentas. | LDAP, Active Directory |
| **Inicio de sesión único (SSO)** | Entrar una vez y acceder a todas las aplicaciones. | SAML, OpenID Connect |
| **APIs web** | Que una aplicación pida o envíe datos a otra. | APIs REST de Google Workspace, Microsoft Graph, Nextcloud |
| **Formatos de intercambio** | Mover información entre aplicaciones. | `.ics` (eventos), `.vcf` (contactos), CSV, JSON |
| **Automatización de flujos** | Que un evento en una aplicación provoque una acción en otra. | Flujos de Nextcloud, Power Automate, Zapier, n8n |

Por ejemplo, el calendario de Nextcloud se puede suscribir desde Thunderbird o desde el móvil por CalDAV, y una aplicación PHP propia puede crear eventos generando un archivo `.ics`.

## Gestión de usuarios

- **Alta de usuarios:** a mano, por importación o, en una organización, sincronizados desde LDAP o Active Directory.
- **Grupos:** por departamento o por proyecto. Los permisos y las carpetas compartidas se asignan a grupos, no a personas sueltas.
- **Roles:** administradores, administradores de un grupo y usuarios.
- **Cuotas:** espacio máximo por usuario.
- **Ciclo de vida de la cuenta:** alta al incorporarse, cambios al cambiar de puesto y baja al marcharse, transfiriendo antes sus archivos a otra persona.

## Control de accesos

| Aspecto | Cómo se aplica |
|:--------|:---------------|
| **Autenticación** | Contraseñas con política de complejidad y segundo factor (TOTP, llave de seguridad). |
| **Autorización** | Al compartir, se elige si el destinatario puede **ver**, **editar**, **crear**, **borrar** o **volver a compartir**. |
| **Enlaces públicos** | Con contraseña, fecha de caducidad y, si se quiere, solo lectura o solo subida de archivos. |
| **Sesiones** | Tiempo máximo de inactividad; el usuario puede ver y cerrar sus sesiones abiertas en otros dispositivos. |
| **Restricciones** | Limitar el acceso por red o por grupo, impedir compartir fuera de la organización. |
| **Auditoría** | Registro de quién accede, descarga, comparte o borra cada archivo. |

## Aseguramiento de la información

- **Cifrado en tránsito** con HTTPS y **cifrado en reposo** del almacenamiento, sobre todo si es externo.
- **Copias de seguridad** del directorio de datos, de la base de datos y de la configuración, siguiendo la regla 3-2-1.
- **Versiones y papelera:** permiten recuperar un archivo borrado o volver a una versión anterior.
- **Antivirus** para los archivos subidos.
- **Actualizaciones** del servidor, de Nextcloud y de sus aplicaciones.
- **Formación de los usuarios:** cómo compartir con seguridad, reconocer el *phishing*, no reutilizar contraseñas.
- **Cumplimiento normativo:** el RGPD exige saber dónde están los datos personales, quién accede a ellos y protegerlos.

## Trabajo cooperativo

El valor de estas aplicaciones está en usarlas **juntas** y **en equipo**:

- Un documento compartido en el que cada persona redacta su parte, con comentarios y control de cambios.
- Una hoja de cálculo común para el inventario, editada por varios departamentos.
- Un calendario de grupo con las reuniones y entregas, y una lista de tareas con responsables y fechas.
- Un tablero de tareas (Deck, Planner, Trello) para seguir el estado de un proyecto.

::: note-box Fuente
Tema elaborado a partir de los contenidos del aula de IAW del CEEDCV (Mara Vañó Alonso, curso 2024-2025). Ver [Créditos y fuentes](/general/contenidos/4-creditos).
:::

---

**Siguiente paso:** [Prácticas de la unidad →](../ejercicios/)
