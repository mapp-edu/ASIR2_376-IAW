---
layout: doc
title: Implantación de Aplicaciones Web
description: Segundo curso del CFGS de Administración de Sistemas Informáticos en Red
sidebar: true
outline: [2, 3]
aside: true
---

# 📘 Implantación de Aplicaciones Web

El módulo de Implantación de Aplicaciones Web capacita al alumnado para instalar, configurar y administrar los servidores, los gestores de contenidos y las aplicaciones web que sustentan la mayoría de los servicios digitales de las organizaciones actuales. El perfil profesional asociado —administrador o administradora de aplicaciones web— es una figura demandada en pequeñas y medianas empresas, departamentos de sistemas de grandes organizaciones y proveedores de alojamiento y servicios cloud.

::: info-box Ficha del módulo
- **Ciclo:** CFGS Administración de Sistemas Informáticos en Red (ASIR), 2º curso.
- **Modalidad:** presencial, 4 horas semanales.
- **Lengua de los materiales:** castellano.
:::

## 🚀 Transversalidad

El módulo se relaciona directamente con otros módulos del ciclo, especialmente con Implantación de Sistemas Operativos, Servicios de Red e Internet y Seguridad y Alta Disponibilidad, y sienta las bases para el módulo de Formación en Centros de Trabajo (FCT), en el que buena parte del alumnado desarrollará tareas de administración de CMS, servidores LAMP/LEMP e intranets corporativas.

## 🛠️ Análisis del stack tecnológico del sector

Antes de diseñar las unidades de trabajo se ha realizado un análisis del stack tecnológico que emplean actualmente las empresas dedicadas a la implantación y el mantenimiento de aplicaciones web, con el fin de que los contenidos, herramientas y prácticas del módulo respondan a la realidad del mercado laboral valenciano y nacional.

### Sistemas operativos de servidor

El mercado de servidores web está dominado ampliamente por sistemas GNU/Linux. Las distribuciones más utilizadas en entornos empresariales son:

- **Ubuntu Server LTS** — distribución de referencia en proveedores cloud (AWS, Azure, Google Cloud, Hetzner) por su ciclo de soporte largo y su amplia documentación.
- **Debian** — muy utilizada en hosting compartido y en entornos que priorizan la estabilidad.
- **AlmaLinux / Rocky Linux** — sustitutas de CentOS tras su descontinuación, habituales en paneles de control como cPanel o Plesk.
- **Windows Server con IIS** — minoritario fuera de entornos .NET, pero presente en organizaciones con infraestructura Microsoft.

Para el módulo se ha optado por Ubuntu Server LTS como sistema base de las prácticas, por ser el más extendido en la oferta de proveedores cloud y en la documentación oficial de los CMS y aplicaciones que se implantarán.

### Servidores web

- **Apache HTTP Server** — el más utilizado históricamente, con un amplio soporte de módulos (`mod_php`, `mod_rewrite`, `mod_ssl`) y compatibilidad total con los CMS del bloque de contenidos.
- **Nginx** — cada vez más presente, especialmente como proxy inverso y balanceador delante de Apache o de intérpretes PHP-FPM, por su bajo consumo de recursos.
- **LiteSpeed / OpenLiteSpeed** — adopción creciente en hosting orientado a WordPress por su rendimiento con caché integrada.

El módulo trabaja Apache como servidor principal (por su papel central en el currículo y su facilidad docente) e introduce Nginx como proxy inverso en la unidad de seguridad, reflejando la arquitectura híbrida Nginx + Apache/PHP-FPM habitual en producción.

### Lenguajes de script de servidor

- **PHP** — sigue siendo el lenguaje predominante en la Web, al ser la base de WordPress, Joomla, Drupal, Moodle y Nextcloud; versiones 8.x con el gestor de dependencias Composer.
- **Node.js** (JavaScript en servidor) — muy presente en aplicaciones a medida y APIs REST modernas.
- **Python** (Django/Flask) — utilizado en aplicaciones de análisis de datos y automatización, y creciente en pymes tecnológicas.

Dado que el currículo exige trabajar «un lenguaje de guiones concreto» y que el ecosistema de gestores de contenidos del propio módulo (RA2, RA3, RA7) se apoya en PHP, se selecciona PHP como lenguaje vehicular de las unidades de RA5 y RA6, sin perjuicio de mencionar Node.js y Python como alternativas del mercado.

### Sistemas gestores de bases de datos

- **MySQL / MariaDB** — el binomio más extendido en aplicaciones web, con compatibilidad total con los CMS trabajados.
- **PostgreSQL** — en expansión en proyectos que requieren integridad y funciones avanzadas.
- **SQLite** — usado en entornos de desarrollo ligero y pruebas.

Se trabajará MariaDB (fork libre de MySQL, incluido por defecto en los repositorios de Ubuntu Server) como SGBD de referencia, gestionado mediante phpMyAdmin y línea de órdenes.

### Entornos integrados de desarrollo y pruebas

- **XAMPP / WAMP / MAMP** — entornos multiplataforma «todo en uno» (Apache + MySQL/MariaDB + PHP) muy utilizados para pruebas locales rápidas.
- **Docker y Docker Compose** — la tendencia dominante en empresas para desplegar entornos reproducibles (contenedores de Apache, PHP-FPM, MariaDB, Nginx) tanto en desarrollo como en producción.
- **Laragon** — alternativa ligera orientada al desarrollo PHP en Windows.

El módulo utiliza XAMPP o un LAMP nativo sobre Ubuntu Server para el aprendizaje de la instalación «paso a paso» (RA1) y añade una introducción a Docker Compose como plataforma integrada de prueba y despliegue, en cumplimiento del criterio de evaluación 1.h).

### Gestores de contenidos (CMS)

- **WordPress** — líder indiscutible del mercado de CMS, tanto para sitios corporativos como para tiendas en línea mediante WooCommerce.
- **Joomla** — utilizado en portales institucionales y corporativos de complejidad media.
- **Drupal** — orientado a proyectos de mayor envergadura que requieren alta personalización y seguridad.
- **Moodle** — gestor de contenidos educativos (LMS), muy relevante en el contexto de centros educativos y de empresas de formación.

Se trabajarán los tres CMS generalistas (WordPress, Joomla y Drupal) para dar cumplimiento al criterio de clasificación y comparación (CE 2.b y 2.d), profundizando especialmente en WordPress por su cuota de mercado y su adaptación (RA7).

### Aplicaciones de ofimática web

- **Nextcloud** — plataforma libre de trabajo colaborativo e intranet, con edición de documentos integrando Collabora Online u ONLYOFFICE.
- **Google Workspace y Microsoft 365** — soluciones SaaS líderes en el mercado, de referencia obligada aunque no se instalen en el aula por ser propietarias.
- **OpenProject / Redmine** — gestión de proyectos colaborativos de código abierto.

Para las prácticas de instalación se utilizará Nextcloud con ONLYOFFICE como suite ofimática web autoalojada, por ser software libre, integrable en una intranet y coherente con el resto del stack LAMP trabajado en el módulo; se estudiarán como referencia comparativa Google Workspace y Microsoft 365.

### Seguridad y buenas prácticas

- Certificados TLS gratuitos mediante Let's Encrypt / Certbot.
- Cortafuegos de aplicación (UFW, fail2ban) y *hardening* de SSH.
- Políticas de copias de seguridad automatizadas y control de versiones (Git) para el código desplegado.

Estos aspectos se integran de forma transversal en todas las unidades de trabajo, y con ellos se cumplen los criterios de evaluación relativos a la seguridad en el acceso a servidores, CMS y aplicaciones de ofimática (CE 1.g, 2.f, 4.f, 5.h, 6.f).

### Síntesis: stack tecnológico de referencia del módulo

| Capa | Tecnología seleccionada para el aula |
|:-----|:-------------------------------------|
| Sistema operativo | Ubuntu Server LTS |
| Servidor web | Apache HTTP Server (+ Nginx como proxy inverso) |
| Lenguaje de script de servidor | PHP 8.x + Composer |
| Sistema gestor de bases de datos | MariaDB + phpMyAdmin |
| Entorno integrado de pruebas | XAMPP / LAMP nativo + Docker Compose |
| Gestores de contenidos | WordPress (principal), Joomla y Drupal (comparativa) |
| Ofimática web | Nextcloud + ONLYOFFICE (comparativa con Google Workspace / M365) |
| Seguridad | Let's Encrypt, UFW, fail2ban, copias de seguridad, Git |

## ✍️ Resultados de aprendizaje y su relación con las unidades de programación

El módulo se organiza en 7 unidades de programación (UP), cada una vinculada a un resultado de aprendizaje (RA) del currículo oficial, de manera que la superación de la unidad implica la evaluación de los criterios asociados a ese RA.

| UP | Título de la unidad de programación | RA | Peso | Horas |
|:---|:------------------------------------|:--:|:----:|:-----:|
| [UP1](/up1/) | Conceptos sobre aplicaciones web e instalación de servidores de aplicaciones web | 1 | 10 % | 20 |
| [UP2](/up2/) | Implantación de gestores de contenidos | 2 | 10 % | 20 |
| [UP3](/up3/) | Administración de gestores de contenidos | 3 | 10 % | 20 |
| [UP4](/up4/) | Adaptación y personalización de gestores de contenidos | 7 | 10 % | 15 |
| [UP5](/up5/) | Programación de documentos web con lenguajes de script de servidor (PHP) | 5 | 25 % | 25 |
| [UP6](/up6/) | Acceso a bases de datos desde lenguajes de script de servidor | 6 | 25 % | 25 |
| [UP7](/up7/) | Gestión de aplicaciones de ofimática web | 4 | 10 % | 15 |

El detalle de cada RA, con sus criterios de evaluación y contenidos, está en [Resultados de aprendizaje](./contenidos/2-resultados-aprendizaje). La forma de puntuar cada práctica se explica en [Evaluación y rúbricas](./contenidos/3-evaluacion).

---

**Siguiente paso:** [Organización y recursos →](./contenidos/1-organizacion)
