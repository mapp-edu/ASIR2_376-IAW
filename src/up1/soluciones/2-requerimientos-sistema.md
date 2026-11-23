---
layout: doc
title: "Solución P1.2 — Análisis de requerimientos y preparación del sistema"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P1.2 — Análisis de requerimientos y preparación del sistema

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P1.2 Requerimientos y sistema](../ejercicios/2-requerimientos-sistema).
:::

- **Unidad:** UP1 · RA1 · CE 1a, 1b, 1g, 1i.
- **Archivos de la solución:**
  - <a :href="withBase('/soluciones/up1/p1.2-requerimientos-sistema/archivos/01-red-fija.yaml')" download><code>archivos/01-red-fija.yaml</code></a>: configuración de Netplan con IP fija (validada con `netplan generate`).
  - <a :href="withBase('/soluciones/up1/p1.2-requerimientos-sistema/archivos/10-seguridad.conf')" download><code>archivos/10-seguridad.conf</code></a>: archivo de configuración de SSH (validado con `sshd -t` y `sshd -T`).

::: warning Los datos cambian
Las versiones de la parte 1 se consultaron el **28/10/2026**. WordPress y WooCommerce revisan sus requisitos con cada versión importante: lo que vale es lo que publiquen las fuentes en la fecha en que se consulten.
:::

---

## Parte 1. Documento de requerimientos (respuesta de referencia)

### 1. Fuentes

| Fuente | URL | Consulta |
|:-------|:----|:---------|
| Requisitos de WordPress | <https://wordpress.org/about/requirements/> | 28/10/2026 |
| Recomendaciones de servidor de WooCommerce (para WooCommerce 10.8+) | <https://woocommerce.com/document/server-requirements/> | 28/10/2026 |
| Extensiones de PHP que comprueba WordPress (Salud del sitio) | <https://developer.wordpress.org/reference/classes/wp_site_health/get_test_php_extensions/> | 28/10/2026 |

Lo que publican, resumido:

- **WordPress:** PHP 8.3 o superior, MySQL 8.0 o superior **o** MariaDB 10.11 o superior, compatibilidad con HTTPS; Apache o Nginx recomendados. Sigue funcionando con PHP 7.4+ y MySQL 5.5.5+, pero esas versiones están fuera de soporte.
- **WooCommerce:** WordPress 6.9 o superior, PHP 8.3 o superior (probado hasta PHP 8.4), MySQL 8.0+ o MariaDB 10.6+, límite de memoria de WordPress de 256 MB o más, HTTPS. Extensiones: cURL o fsockopen, SOAP (algunas extensiones de pago), mbstring (obligatoria en tiendas que no están en inglés).

### 2. Componentes y versiones

| Componente | Mínima | Recomendada | Elección y por qué |
|:-----------|:-------|:------------|:-------------------|
| Sistema operativo | Linux con soporte vigente | Ubuntu Server **24.04 LTS** | Soporte de seguridad hasta 2029 y trae PHP 8.3 y MariaDB 10.11 en sus repositorios: cumple las dos fuentes sin repositorios externos. Ubuntu 26.04 LTS trae PHP 8.5, que WooCommerce aún no declara probado. |
| Servidor web | Cualquiera con PHP | **Apache 2.4** con `mod_rewrite` | Recomendado por ambas fuentes; `mod_rewrite` y `.htaccess` dan los enlaces permanentes de WordPress sin configuración adicional. Alternativa: Nginx + PHP-FPM, más eficiente en picos pero con más configuración. |
| Base de datos | MariaDB 10.6 (WooCommerce) | **MariaDB 10.11** o superior | Es la mínima de WordPress (la más exigente de las dos) y la que trae Ubuntu 24.04. Alternativa: MySQL 8.0+. |
| Lenguaje | PHP 8.3 | **PHP 8.3** (o 8.4) | Mínimo recomendado por las dos fuentes; 8.4 es el máximo probado por WooCommerce. |
| HTTPS | Obligatorio | Certificado de **Let's Encrypt** con Certbot | Gratuito y renovable automáticamente. Imprescindible en una tienda (datos personales, pagos). |
| Extensiones de PHP obligatorias | `json`, `hash` | — | Vienen incluidas en PHP 8. |
| Extensiones recomendadas | — | `mysqli`/`pdo_mysql`, `curl`, `mbstring`, `xml`/`dom`, `zip`, `intl`, `imagick` (o `gd`), `exif`, `fileinfo`, `openssl`, `sodium`, `soap` | Paquetes de Ubuntu: `php-mysql php-curl php-mbstring php-xml php-zip php-intl php-imagick php-soap` (el resto ya están en el núcleo de PHP). `imagick`/`gd` son necesarias para generar las miniaturas de las fotografías del catálogo. |
| Configuración de PHP | `memory_limit = 256M` | `memory_limit = 256M`, `upload_max_filesize = 32M`, `post_max_size` algo mayor | Memoria exigida por WooCommerce; subida suficiente para fotografías de producto. Se aplica en la P1.3. |

Se aceptan otras elecciones (Debian 12/13, Nginx, MySQL) si se justifican frente a las fuentes.

### 3. Requisitos funcionales y no funcionales

**Funcionales**

| Id | Requisito | Prioridad |
|:---|:----------|:----------|
| RF1 | El cliente puede consultar el catálogo por categorías, con fotografías, descripción, precio y disponibilidad. | Esencial |
| RF2 | El cliente puede buscar productos y filtrarlos por categoría, talla y precio. | Esencial |
| RF3 | El cliente puede añadir productos al carrito y completar el pedido indicando los datos de envío. | Esencial |
| RF4 | El cliente puede pagar con tarjeta mediante una pasarela de pago. | Esencial |
| RF5 | La tienda envía por correo la confirmación del pedido y los cambios de estado. | Esencial |
| RF6 | El personal de la tienda puede dar de alta productos, modificar precios y controlar el stock. | Esencial |
| RF7 | El cliente puede crear una cuenta y consultar su historial de pedidos. | Deseable |
| RF8 | La tienda puede crear cupones y rebajas con fecha de inicio y fin. | Deseable |
| RF9 | El cliente puede pagar con Bizum. | Deseable |
| RF10 | La tienda genera facturas en PDF. | Opcional |
| RF11 | El cliente puede dejar valoraciones de los productos. | Opcional |

**No funcionales**

| Id | Requisito | Prioridad |
|:---|:----------|:----------|
| RNF1 | Todo el sitio se sirve por HTTPS, y HTTP redirige a HTTPS. | Esencial |
| RNF2 | El sitio atiende 40 clientes simultáneos de forma habitual y 200 en rebajas sin errores. | Esencial |
| RNF3 | Las páginas de catálogo cargan en menos de 3 s con 40 clientes y en menos de 5 s con 200. | Esencial |
| RNF4 | El tratamiento de datos personales cumple el RGPD y la LOPDGDD: servidor en la UE, política de privacidad, consentimiento y derechos de los clientes. | Esencial |
| RNF5 | Se hace una copia de seguridad diaria de la base de datos y semanal de los archivos, fuera del servidor, y se prueba su restauración. | Esencial |
| RNF6 | La tienda no almacena datos de tarjetas: el pago se hace en la pasarela. | Esencial |
| RNF7 | El sitio se adapta a móviles. | Esencial |
| RNF8 | Disponibilidad del 99,5 % mensual, con mantenimiento de madrugada. | Deseable |
| RNF9 | El servidor puede ampliar CPU y memoria para las rebajas sin reinstalar. | Deseable |
| RNF10 | Accesibilidad según WCAG 2.1 nivel AA. | Deseable |
| RNF11 | Red de distribución de contenidos (CDN) para las imágenes. | Opcional |

### 4. Estimación de recursos

Las hipótesis deben estar escritas: es lo que diferencia el nivel 2 del 3.

**Concurrencia real.** «Conectados a la vez» no son peticiones a la vez. Hipótesis: cada cliente pide una página cada 15–20 s y una página de WooCommerce sin caché tarda unos 0,5 s de CPU en generarse.

- Normal: 40 clientes × 0,5 s / 15 s ≈ **1–3 peticiones PHP simultáneas**.
- Rebajas: 200 × 0,5 / 15 ≈ **7 de media**, con picos de 15–20 (el carrito y el pago no se pueden cachear).

**Memoria.**

| Uso | Normal | Rebajas |
|:----|:-------|:--------|
| Sistema y servicios | 0,5 GB | 0,5 GB |
| MariaDB (búfer de InnoDB) | 0,5 GB | 1 GB |
| Procesos de PHP (≈ 100 MB cada uno) | 5–10 → 1 GB | 20 → 2 GB |
| Caché de archivos y margen | 0,5 GB | 0,5 GB |
| **Total** | **≈ 2,5 GB → 4 GB** | **≈ 4 GB → 4–8 GB** |

**CPU.** 2 vCPU atienden la carga normal con margen; para las rebajas, 4 vCPU (o 2 vCPU con caché de páginas para el catálogo).

**Almacenamiento.**

| Concepto | Cálculo | Tamaño |
|:---------|:--------|:-------|
| Sistema operativo y servicios | — | 10 GB |
| WordPress, WooCommerce, tema y plugins | — | 1 GB |
| Fotografías | 500 productos × 4 fotos × (≈ 400 KB original + ≈ 600 KB de miniaturas que genera WordPress) | ≈ 2 GB |
| Base de datos | Catálogo, clientes y unos años de pedidos | < 1 GB |
| Registros y copias locales temporales | — | 10 GB |
| **Total actual** | | **≈ 25 GB** |
| Recomendado (crecimiento ×2–3) | | **60–80 GB SSD** |

**Transferencia.** Página media ≈ 1,5 MB (con caché del navegador, menos). En rebajas, 200 clientes × 1 página / 15 s × 1,5 MB ≈ 20 MB/s (≈ 160 Mbit/s) de pico: una CDN para las imágenes lo reduce mucho.

**Resultado:** 2 vCPU, 4 GB de RAM, 80 GB SSD de forma habitual, ampliable a 4 vCPU y 8 GB en rebajas.

### 5. Modalidad de alojamiento

| Modalidad | Valoración |
|:----------|:-----------|
| Compartido | **No.** Recursos compartidos con otros clientes y limitados (memoria, procesos); no soportaría los picos de rebajas ni permite configurar el servidor. |
| **VPS** | **Recomendado.** Recursos garantizados, acceso de administración completo (lo que se prepara en la parte 2), coste moderado y ampliable cambiando de plan. |
| Dedicado | Excesivo para 40–200 clientes y más caro; ampliarlo exige cambiar de hardware. |
| IaaS (AWS, Azure, Google Cloud) | Técnicamente el mejor para picos (escalado automático, balanceo), pero más caro y complejo de gestionar para una tienda pequeña. Se puede considerar si crece. |

Se exige que el proveedor tenga el centro de datos en la UE (RGPD) y copias de seguridad fuera del servidor.

### 6. Requisitos de seguridad

| Ámbito | Requisito | Se aplica en |
|:-------|:----------|:-------------|
| Cifrado | HTTPS con certificado válido en todo el sitio, redirección de HTTP a HTTPS, TLS 1.2 o superior. | P1.3 (puertos 80/443) y despliegue |
| Datos personales | RGPD y LOPDGDD: servidor en la UE, contrato de encargado del tratamiento con el proveedor, política de privacidad y de cookies, minimización de datos, procedimiento para los derechos de los clientes. Los datos de tarjeta no se guardan: pasarela externa (PCI DSS). | Configuración de WooCommerce (UP2) |
| Copias de seguridad | Diaria de la base de datos y semanal de los archivos; regla 3-2-1 (tres copias, dos soportes, una fuera); retención de 30 días; restauración probada cada mes. | P1.4 (`mariadb-dump` y restauración) |
| Acceso de administración del servidor | Usuario propio con `sudo`, sin acceso SSH de `root`, autenticación por clave, cortafuegos que solo deja pasar SSH, HTTP y HTTPS; actualizaciones de seguridad automáticas. | Parte 2 |
| Acceso de administración de la tienda | Cuentas nominativas con el rol mínimo necesario, contraseñas robustas, doble factor para administradores, límite de intentos de acceso. | UP3 |
| Base de datos | Usuario propio con permisos solo sobre su base de datos; MariaDB sin acceso desde fuera del servidor. | P1.4 |
| Mantenimiento | Actualizar núcleo, plugins y temas; registrar los accesos. | UP3 |

---

## Parte 2. Preparación del sistema operativo

Ubuntu Server 24.04 LTS (o 26.04) en una máquina virtual. Si se usa VirtualBox, el adaptador en **adaptador puente** (o red interna/NAT con reenvío de puertos) para poder acceder desde el anfitrión en las prácticas siguientes.

### 1. Actualizar

```bash
sudo apt update          # descarga la lista de paquetes disponibles
sudo apt upgrade -y      # instala las versiones nuevas de lo instalado
sudo reboot              # si se actualizó el núcleo (existe /var/run/reboot-required)
```

### 2. Nombre e IP fija

```bash
sudo hostnamectl set-hostname servidor-tienda
sudo nano /etc/hosts               # cambiar la línea 127.0.1.1 al nuevo nombre
ip -br addr                        # nombre de la interfaz (enp0s3, ens33…) e IP actual
ip route | grep default            # puerta de enlace actual
```

Configuración de red (archivo `archivos/01-red-fija.yaml`):

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: false
      addresses:
        - 192.168.1.50/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
```

```bash
sudo nano /etc/netplan/01-red-fija.yaml
sudo chmod 600 /etc/netplan/01-red-fija.yaml
sudo mv /etc/netplan/50-cloud-init.yaml /root/       # si existe: si no, sigue pidiendo DHCP
echo 'network: {config: disabled}' | sudo tee /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
sudo netplan try                                       # aplica y, si se pierde la conexión, vuelve atrás a los 120 s
```

`netplan try` es preferible a `netplan apply` cuando se trabaja por SSH: si la configuración nueva deja el servidor sin red, se deshace sola.

Comprobación:

```bash
hostnamectl                       # Static hostname: servidor-tienda
ip -br addr show enp0s3           # 192.168.1.50/24
ip route                          # default via 192.168.1.1
resolvectl status | grep -A2 "DNS Servers"
ping -c2 ubuntu.com
```

La IP debe estar en la red real del aula o de la red de la VM y fuera del rango del DHCP. Copiar el `192.168.1.50` de los apuntes sin comprobar la red es el error más frecuente: el servidor se queda sin conexión.

### 3. Usuario administrador

```bash
sudo adduser admintienda
sudo usermod -aG sudo admintienda
groups admintienda                # admintienda : admintienda sudo
su - admintienda
sudo whoami                       # root
```

En Ubuntu la cuenta `root` no tiene contraseña (está bloqueada) y el usuario creado en la instalación ya pertenece a `sudo`. Se pide otro usuario para practicar y para que cada administrador tenga su cuenta: `sudo` registra quién hizo cada cosa en `/var/log/auth.log`.

### 4. Cortafuegos

```bash
sudo ufw app list                 # perfiles disponibles: OpenSSH
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH            # ANTES de activarlo, o se corta la sesión SSH
sudo ufw enable
sudo ufw status verbose
```

Salida esperada:

```
Status: active
Default: deny (incoming), allow (outgoing), disabled (routed)
To                         Action      From
--                         ------      ----
22/tcp (OpenSSH)           ALLOW IN    Anywhere
22/tcp (OpenSSH (v6))      ALLOW IN    Anywhere (v6)
```

HTTP y HTTPS **no** se abren aquí: se abren en la P1.3, cuando haya un servidor web que los use.

### 5. SSH sin `root`

Se crea un archivo propio en `sshd_config.d` en lugar de editar `sshd_config` (archivo `archivos/10-seguridad.conf`):

```bash
sudo nano /etc/ssh/sshd_config.d/10-seguridad.conf
```

```text
PermitRootLogin no
MaxAuthTries 3
# PasswordAuthentication no      ← activar cuando las claves estén probadas
```

```bash
sudo sshd -t                                          # comprueba la sintaxis (sin salida = correcto)
sudo systemctl restart ssh
sudo sshd -T | grep -E "permitrootlogin|maxauthtries|passwordauthentication"
```

Salida esperada:

```
permitrootlogin no
maxauthtries 3
passwordauthentication yes
```

A tener en cuenta:

- El valor por defecto de Ubuntu es `PermitRootLogin prohibit-password` (root puede entrar con clave). No basta con que «root no tenga contraseña»: hay que poner `no`.
- En `sshd_config` gana **el primer valor** que aparece. Los archivos de `sshd_config.d` se leen al principio (línea `Include`), así que mandan sobre lo que haya más abajo en `sshd_config`. Por eso `sshd -T` (configuración efectiva) es mejor prueba que `grep` en el archivo.
- Las imágenes *cloud* traen `50-cloud-init.conf` con `PasswordAuthentication yes`; `10-seguridad.conf` va antes por orden alfabético.
- Prueba práctica: `ssh root@192.168.1.50` desde el anfitrión debe dar `Permission denied`.
- Extra de nivel 4: claves (`ssh-keygen -t ed25519` en el cliente, `ssh-copy-id admintienda@192.168.1.50`), y después `PasswordAuthentication no`.

### 6. Actualizaciones de seguridad automáticas

```bash
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades   # responder «Sí»
cat /etc/apt/apt.conf.d/20auto-upgrades
sudo unattended-upgrade --dry-run --debug | head -20
systemctl list-timers apt-daily*
```

`20auto-upgrades` debe contener:

```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

Por defecto, `/etc/apt/apt.conf.d/50unattended-upgrades` solo instala el origen `${distro_codename}-security`: actualizaciones de seguridad, no versiones nuevas que puedan romper algo. Opcional: `Unattended-Upgrade::Automatic-Reboot "true";` con una hora de madrugada (enlaza con RNF8).

### 7. Comprobación final

```bash
hostnamectl | grep hostname
ip -br addr
sudo ufw status verbose
sudo sshd -T | grep permitrootlogin
ss -tlnp                          # solo debe escuchar el 22 (y el 53 de systemd-resolved en 127.0.0.53)
cat /etc/apt/apt.conf.d/20auto-upgrades
```

---

## Nivel 3 de CE 1g: de qué protege cada medida

| Medida | Protege de |
|:-------|:-----------|
| Actualizar el sistema | Vulnerabilidades conocidas y ya corregidas en el software instalado. |
| IP fija | No es seguridad en sí, pero las reglas del cortafuegos, los registros DNS y las conexiones de la base de datos dependen de que no cambie. |
| Usuario con `sudo` | Errores con privilegios permanentes (se pide `sudo` solo cuando hace falta) y falta de trazabilidad (cada acción queda asociada a una persona). |
| Cortafuegos | Acceso a servicios que se instalen o queden escuchando sin querer: solo pasa lo que se permite expresamente. |
| SSH sin `root` | Ataques de fuerza bruta contra el usuario que existe en todos los Linux; el atacante tendría que adivinar también el nombre de usuario. |
| `MaxAuthTries` y claves | Fuerza bruta de contraseñas. |
| Actualizaciones automáticas | Que pasen días entre la publicación de un parche y su instalación. |

## Nivel 4: coherencia entre la parte 1 y la parte 2

| Requisito de la parte 1 | Medida de la parte 2 |
|:------------------------|:--------------------|
| Acceso de administración con usuario propio, sin `root` | Pasos 3 y 5 |
| Cortafuegos con solo SSH, HTTP y HTTPS | Paso 4 (HTTP y HTTPS en la P1.3) |
| Mantenimiento y parches | Pasos 1 y 6 |
| Ubuntu 24.04 LTS de la tabla de componentes | Sistema instalado (`lsb_release -a`) |
| Recursos estimados (2 vCPU, 4 GB) | Configuración de la VM (aunque en el aula se use menos, se justifica) |
