---
layout: doc
title: Implantació d'Aplicacions Web
description: Segon curs del CFGS d'Administració de Sistemes Informàtics en Xarxa
sidebar: true
outline: [2, 3]
aside: true
---

## 📘 Implantació d'Aplicacions Web

El mòdul d'Implantació d'Aplicacions Web capacita l'alumnat per instal·lar, configurar i administrar els servidors, els gestors de continguts i les aplicacions web que sustenten la majoria dels serveis digitals de les organitzacions actuals. El perfil professional associat -administrador o administradora d'aplicacions web- és una figura demandada en petites i mitjanes empreses, departaments de sistemes de grans organitzacions i proveïdors d'allotjament i serveis cloud.

## 🚀 Transversalidad

El mòdul es relaciona directament amb altres mòduls del cicle, especialment amb Implantació de Sistemes Operatius, Serveis en Xarxa i Seguretat i Alta Disponibilitat, i estableix les bases per al mòdul de Formació en Centres de Treball (FCT), en què bona part de l'alumnat desenvoluparà tasques d'administració de CMS, servidors LAMP/LEMP i intranets corporatives.

## 🛠️ Anàlisi de l'stack tecnològic del sector

Abans de dissenyar les unitats de treball s'ha realitzat una anàlisi de l'stack tecnològic que empren actualment les empreses dedicades a la implantació i el manteniment d'aplicacions web, a fi que els continguts, eines i pràctiques del mòdul responguin a la realitat del mercat laboral valencià i nacional.

### Sistemes operatius de servidor

El mercat de servidors web està dominat àmpliament per sistemes GNU/Linux. Les distribucions més utilitzades en entorns empresarials són: 
- Ubuntu Server LTS — distribució de referència en proveïdors cloud (AWS, Azure, Google Cloud, Hetzner) pel seu cicle de suport llarg i la seva àmplia documentació. 
- Debian — molt utilitzada en hosting compartit i en entorns que prioritzen estabilitat. 
- AlmaLinux / Rocky Linux — substitutes de CentOS després de descontinuar-les, habituals en panells de control com cPanel o Plesk. 
- Windows Server amb IIS — minoritari fora d'entorns .NET, però present a organitzacions amb infraestructura Microsoft.

Per al mòdul s'ha optat per Ubuntu Server LTS com a sistema base de les pràctiques, per ser el més estès en l'oferta de proveïdors cloud i en la documentació oficial dels CMS i aplicacions que s'implantaran.

### Servidors web 

- Apache HTTP Server — el més utilitzat històricament, amb un ampli suport de mòduls (mod_php, mod_rewrite, mod_ssl) i compatibilitat total amb els CMS del bloc de continguts. 
- Nginx — cada vegada més present, especialment com a servidor intermediari invers i balancejador davant d'Apache o d'intèrprets PHP-FPM, pel baix consum de recursos. 
- LiteSpeed ​​/ OpenLiteSpeed ​​— l'adopció creixent en hosting orientat a WordPress pel seu rendiment amb memòria cau integrada.

El mòdul treballa Apache com a servidor principal (pel seu paper central al currículum i la seva facilitat docent) i introdueix Nginx com a proxy invers a la unitat de seguretat, reflectint l'arquitectura híbrida Nginx + Apache/PHP-FPM habitual en producció.

### Llenguatges de script de servidor 

- PHP — continua sent el llenguatge predominant a la Web, en ser la base de WordPress, Joomla, Drupal, Moodle i Nextcloud; versions 8.x amb gestor de dependències Composer. 
- Node.js (JavaScript en servidor) — molt present en aplicacions a mida i APIs REST modernes. 
- Python (Django/Flask) — utilitzat en aplicacions d'anàlisi de dades i automatització i creixent en pimes tecnològiques.

Atès que el currículum exigeix ​​treballar «un llenguatge de guions concret» i que l'ecosistema de gestors de continguts del mateix mòdul (RA2, RA3, RA7) es recolza en PHP, se selecciona PHP com a llenguatge vehicular de les unitats RA5 i RA6, sense perjudici d'esmentar Node.js i Python com a alternatives del mercat.

### Sistemes gestors de bases de dades 

- MySQL/MariaDB — el binomi més estès en aplicacions web, amb compatibilitat total amb els CMS treballats. 
- PostgreSQL — en expansió en projectes que requereixen integritat i funcions avançades. 
- SQLite — usat en entorns de desenvolupament lleuger i proves.

Es treballarà MariaDB (fork lliure de MySQL, inclòs per defecte als repositoris d'Ubuntu Server) com a SGBD de referència, gestionat mitjançant phpMyAdmin i línia d'ordres.

### Entorns integrats de desenvolupament i proves 

- XAMPP / WAMP / MAMP — entorns multiplataforma «tot en un» (Apache + MySQL/MariaDB + PHP) molt utilitzats per a proves locals ràpides. 
- Docker i Docker Compose — la tendència dominant en empreses per desplegar entorns reproduïbles (contenidors d'Apache, PHP-FPM, MariaDB, Nginx) tant en desenvolupament com en producció. 
- Laragon — alternativa lleugera orientada a desenvolupament PHP a Windows.

El mòdul utilitza XAMPP o un LAMP nadiu sobre Ubuntu Server per a l'aprenentatge de la instal·lació “pas a pas” (RA1) i afegeix una introducció a Docker Compose com a plataforma integrada de prova i desplegament, en compliment del criteri d'avaluació 1.h).

### Gestors de continguts (CMS) 

- WordPress — líder indiscutible del mercat de CMS, tant per a llocs corporatius com per a botigues en línia mitjançant WooCommerce. 
- Joomla — utilitzat en portals institucionals i corporatius de complexitat mitjana. 
- Drupal — orientat a projectes de més envergadura que requereixen alta personalització i seguretat. 
- Moodle — gestor de continguts educatius (LMS), molt rellevant en el context de centres educatius i d'empreses de formació.

Es treballaran els tres CMS generalistes (WordPress, Joomla i Drupal) per donar compliment al criteri de classificació i comparació (CE 2.b i 2.d), aprofundint especialment en WordPress per la seva quota de mercat i la seva adaptació (RA7).

### Aplicacions d'ofimàtica web 

- Nextcloud — plataforma lliure de treball col·laboratiu i intranet, amb edició de documents integrant Col·labora Online o ONLYOFFICE. 
- Google Workspace i Microsoft 365 — solucions SaaS líders al mercat, de referència obligada encara que no s'instal·lin a l'aula per ser-ne propietàries. 
- OpenProject / Redmine — gestió de projectes col·laboratius de codi obert.

Per a les pràctiques d'instal·lació s'utilitzarà Nextcloud amb ONLYOFFICE com a suite ofimàtica web autoallotjada, per ser programari lliure, integrable a una intranet i coherent amb la resta de l'stack LAMP treballat al mòdul; s'estudiaran com a referència comparativa Google Workspace i Microsoft 365.

### Seguretat i bones pràctiques 

- Certificats TLS gratuïts mitjançant Let's Encrypt/Certbot. 
- Tallafocs d'aplicació (UFW, fail2ban) i hardening de SSH. 
- Polítiques de còpies de seguretat automatitzades i control de versions (Git) per al codi desplegat.

Aquests aspectes s'integren de forma transversal a totes les unitats de treball, i es compleixen els criteris d'avaluació relatius a seguretat en l'accés a servidors, CMS i aplicacions d'ofimàtica (CE 1.g, 2.f, 4.f, 5.h, 6.f).

### Síntesi: stack tecnològic de referència del mòdul

| Capa | Tecnologia seleccionada per a l'aula |
|------|--------------------------------------|
| Sistema operatiu | Ubuntu Server LTS |
| Servidor web | Apache HTTP Server (+ Nginx com a servidor intermediari invers) |
| Llenguatge de seqüència de servidor | PHP 8.x + Composer |
| Sistema gestor de base de dades | MariaDB + phpMyAdmin |
| Entorn integrat de proves | XAMPP / LAMP nadiu + Docker Compose |
| Gestors de continguts | WordPress (principal), Joomla i Drupal (comparativa) |
| Ofimàtica web | Nextcloud + ONLYOFFICE (comparativa amb Google Workspace/M365) |
| Seguretat | Let's Encrypt, UFW, fail2ban, còpies de seguretat, Git |

## ✍️ Resultats d'aprenentatge i la seva relació amb les unitats de treball

El mòdul s'organitza en 7 unitats de treball (UT), cadascuna vinculada a un resultat d'aprenentatge (RA) del currículum oficial, de manera que la superació de la unitat implica l'avaluació dels criteris associats a aquest RA.
| UP | Títol de la unitat de programació | RA | Hores |
|----|-----------------------------------|----|-------|
| [UP1](./contenidos/2-up1) | Conceptes sobre aplicacions web i instal·lació de servidors d'aplicacions web | 1 | 20 |
| [UP2](./contenidos/3-up2) | Implantació de gestors de continguts | 2 | 20 |
| [UP3](./contenidos/4-up3) | Administració de gestors de continguts | 3 | 20 |
| [UP4](./contenidos/5-up4) | Adaptació i personalització de gestors de continguts | 7 | 15 |
| [UP5](./contenidos/6-up5) | Programació de documents web amb llenguatges d'script de servidor (PHP) | 5 | 25 |
| [UP6](./contenidos/7-up6) | Accés a bases de dades des de llenguatges d'script de servidor | 6 | 25 |
| [UP7](./contenidos/8-up7) | Gestió d'aplicacions d'ofimàtica web | 4 | 15 |

## 🎞️ Diapositivas e imágenes

| Guía | Descripción |
|------|-------------|
| [9. Crear diapositivas](./contenidos/9-diapositivas) | Componente SlidesViewer — guía completa |
| [10. Catálogo de patrones](./contenidos/10-diapositivas-demo) | Demo visual de todos los layouts de diapositiva |
| [11. Imágenes para contenido](./contenidos/11-imagenes) | Rutas, formatos y optimización |

## 🌐 Publicación

| Guía | Descripción |
|------|-------------|
| [12. Despliegue](./contenidos/12-despliegue) | GitHub Pages, GitHub Actions y troubleshooting |

---

## 🗂️ Ejercicios de ejemplo

El módulo incluye dos modelos de ejercicio listos para usar como referencia:

[Ver los ejercicios →](./ejercicios/)
