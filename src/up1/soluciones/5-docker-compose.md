---
layout: doc
title: "Solución P1.5 — Entorno integrado de pruebas con Docker Compose"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P1.5 — Entorno integrado de pruebas con Docker Compose

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P1.5 Entorno con Docker Compose](../ejercicios/5-docker-compose).
:::

- **Unidad:** UP1 · RA1 · CE 1d, 1h, 1i.
- **Contenido de la solución:** la carpeta `entorno-iaw/` (<a :href="withBase('/soluciones/up1/p1.5-docker-compose/entorno-iaw.zip')" download>descargar en ZIP</a>) es lo que debería entregar el alumnado (repositorio) y este documento recoge lo que debería aparecer en la memoria y las respuestas de referencia.

```
p1.5-docker-compose/
└── entorno-iaw/             # repositorio de referencia
    ├── docker-compose.yml
    ├── Dockerfile
    ├── .env.example
    ├── (.env)               # no incluido: crearlo con cp .env.example .env
    ├── .gitignore
    ├── README.md
    └── src/
        ├── index.php
        └── hora.php
```

---

## Parte 1. El entorno

### 1. Instalación de Docker y Docker Compose

En la máquina virtual Ubuntu Server de las prácticas anteriores, con el repositorio oficial de Docker:

```bash
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER      # cerrar sesión y volver a entrar
```

En Windows o macOS basta con Docker Desktop. Comprobación que debe aparecer en la memoria:

```bash
docker --version
docker compose version
docker run --rm hello-world
```

::: warning Compose v1 frente a v2
Si alguien usa `docker-compose` (con guion) está usando la versión 1, abandonada. Se acepta si funciona, pero conviene corregirlo: la práctica pide `docker compose`.
:::

### 2 y 3. `docker-compose.yml` y `Dockerfile`

Los archivos completos están en `entorno-iaw/`. Explicación que corresponde al **nivel 3 de CE 1h** («explica cada línea»):

#### `docker-compose.yml`

| Línea o bloque | Qué hace y por qué |
|:---------------|:-------------------|
| `name: entorno-iaw` | Fija el nombre del proyecto. Sin él, Compose usa el nombre de la carpeta y los contenedores, la red y el volumen cambian de nombre si se clona en otra carpeta. |
| `services:` | Lista de contenedores que forman el entorno. Cada servicio es un contenedor con su configuración. |
| **web** · `build: .` | No usa una imagen ya hecha: construye una a partir del `Dockerfile` de la carpeta actual. Es lo que pide el requisito 3. |
| `image: entorno-iaw-web:1.0` | Da nombre y versión a la imagen construida, para reconocerla en `docker images`. Opcional. |
| `ports: "8080:80"` | Publica el puerto 80 del contenedor (Apache) en el 8080 del equipo. Formato `equipo:contenedor`. |
| `volumes: ./src:/var/www/html` | *Bind mount*: la carpeta `src` del equipo aparece como raíz web de Apache. Se edita con VS Code en el equipo y el cambio se ve al recargar, sin reconstruir nada. |
| `environment: TZ: ${TZ_WEB:-Europe/Madrid}` | Zona horaria del contenedor. Toma el valor de `.env` y, si está vacío o no existe, usa `Europe/Madrid`. Se usa en la pregunta 7. |
| `DB_HOST: db` | Dentro de la red que crea Compose, cada servicio se resuelve por su nombre. Por eso el host de la base de datos es `db` y no `localhost` ni una IP. |
| `DB_NAME: ${DB_NAME:?…}` (y `DB_USER`, `DB_PASSWORD`) | Pasa a PHP los datos de conexión, leídos de `.env`. La forma `:?mensaje` hace que Compose se niegue a arrancar con un error claro si falta la variable. |
| `depends_on: db: condition: service_healthy` | `web` no arranca hasta que el *healthcheck* de `db` dice que MariaDB acepta conexiones. Con un `depends_on` simple solo se espera a que el contenedor exista, no a que la base de datos esté lista. |
| `restart: unless-stopped` | Si el contenedor se cae o se reinicia Docker, vuelve a arrancar, salvo que se haya parado a mano. |
| **db** · `image: mariadb:11.4` | Imagen oficial de MariaDB con la versión LTS fijada. Con `latest` el entorno cambiaría solo con el tiempo y dejaría de ser reproducible. |
| `MARIADB_ROOT_PASSWORD`, `MARIADB_DATABASE`, `MARIADB_USER`, `MARIADB_PASSWORD` | Variables que la imagen oficial lee **solo en el primer arranque** (volumen vacío) para crear la contraseña de root, la base de datos y el usuario propio con permisos sobre ella. Los valores salen de `.env`. |
| `volumes: datos-db:/var/lib/mysql` | Volumen con nombre gestionado por Docker donde MariaDB guarda los datos. Sobrevive a `docker compose down`; solo se borra con `down -v`. |
| `healthcheck:` | Comprobación periódica con el script `healthcheck.sh` que incluye la imagen: `--connect` verifica que acepta conexiones e `--innodb_initialized` que el motor está listo. `start_period` da margen a la primera inicialización. |
| Sin `ports` en `db` | La base de datos no se publica en el equipo: solo la ven `web` y `adminer` por la red interna. Reduce la superficie de ataque (enlaza con CE 1g). |
| **adminer** · `image: adminer:5` | Herramienta web de administración de bases de datos en un solo archivo PHP. |
| `ports: "8081:8080"` | Adminer escucha en el 8080 del contenedor; se publica en el 8081 del equipo para no chocar con `web`. |
| `ADMINER_DEFAULT_SERVER: db` | Rellena el campo «Servidor» del formulario de acceso. |
| `volumes: datos-db:` (raíz) | Declara el volumen con nombre que usa `db`. |

Se acepta `phpmyadmin` en lugar de Adminer (`image: phpmyadmin:5`, `PMA_HOST: db`, puerto `8081:80`).

#### `Dockerfile`

| Línea | Qué hace y por qué |
|:------|:-------------------|
| `FROM php:8.3-apache` | Parte de la imagen oficial: Debian, Apache con `mod_php` y PHP 8.3. |
| `RUN docker-php-ext-install pdo_mysql` | Compila e instala el controlador PDO para MySQL/MariaDB con el script que trae la propia imagen, y lo activa. Equivale al `apt install php-mysql` de la P1.4. |
| `RUN echo 'date.timezone = ${TZ}' > …/zz-zona-horaria.ini` | PHP **no** usa la variable de entorno `TZ`: su zona horaria sale de la directiva `date.timezone` y, si no está definida, es UTC. Los archivos `.ini` admiten `${VARIABLE}`, que PHP sustituye al arrancar, así que la directiva sigue a `TZ` sin reconstruir la imagen. Las comillas simples evitan que el shell sustituya `${TZ}` durante la construcción. |

::: tip Lo que no se espera del alumnado
La tercera línea del `Dockerfile` no la pide el enunciado. Quien solo ponga `TZ` en el `docker-compose.yml` verá en la pregunta 7 que la hora de PHP **no cambia** (sigue en UTC). Si lo detecta, lo investiga y lo resuelve (con este `.ini` o con `date_default_timezone_set(getenv('TZ'))` al principio del PHP), es un claro indicador de nivel 3–4. Si dice que cambia sin haberlo resuelto, la captura no cuadrará.
:::

### 4. Credenciales en `.env`

- `.env` con los valores reales y `.gitignore` con la línea `.env`.
- `docker-compose.yml` solo contiene referencias `${…}`.
- Evidencias para la memoria:

```bash
git check-ignore -v .env        # .gitignore:2:.env   .env
git status --short              # .env no aparece
```

### 5. Levantar el entorno y comprobarlo

```bash
docker compose up -d --build
docker compose ps
```

Salida esperada (los tiempos y versiones exactas varían):

```
NAME                   IMAGE                 SERVICE   STATUS                   PORTS
entorno-iaw-adminer-1  adminer:5             adminer   Up 30 seconds            0.0.0.0:8081->8080/tcp
entorno-iaw-db-1       mariadb:11.4          db        Up 41 seconds (healthy)  3306/tcp
entorno-iaw-web-1      entorno-iaw-web:1.0   web       Up 30 seconds            0.0.0.0:8080->80/tcp
```

Fíjate en que `db` muestra `3306/tcp` sin `0.0.0.0:`: el puerto existe dentro de la red pero no está publicado.

Registros:

```bash
docker compose logs db | tail      # «mariadbd: ready for connections»
docker compose logs web | tail     # «Apache/2.4.x (Debian) PHP/8.3.x configured -- resuming normal operations»
docker compose logs adminer        # «PHP 8.x Development Server … started»
```

Comprobaciones extra que suben la nota de CE 1h:

```bash
docker compose exec web php -m | grep pdo           # PDO y pdo_mysql
docker compose exec web php -r 'echo date_default_timezone_get();'   # Europe/Madrid
docker volume ls | grep datos-db                    # entorno-iaw_datos-db
docker network ls | grep entorno-iaw                # entorno-iaw_default
```

---

## Parte 2. Cliente y servidor

### 6 y 9. `hora.php`

El archivo está en `entorno-iaw/src/hora.php`. Elementos que debe tener:

- **Hora del servidor:** `date('H:i:s')` en PHP, más la zona (`date_default_timezone_get()`).
- **Hora del navegador:** `new Date().toLocaleTimeString()` en un `<script>`, más la zona (`Intl.DateTimeFormat().resolvedOptions().timeZone`).
- **Consulta PDO:** conexión con los datos de las variables de entorno, `SELECT VERSION()`, `try/catch` y sin mostrar el mensaje de la excepción al usuario.

Detalle didáctico de la solución: la hora del navegador se actualiza cada segundo con `setInterval` y la del servidor se queda congelada hasta que se recarga. Hace visible que el PHP se ejecutó una vez, en el servidor, y el JavaScript sigue ejecutándose en el equipo cliente.

Resultado esperado en `http://localhost:8080/hora.php`: dos horas iguales (si servidor y cliente están en la misma zona), las dos zonas y una línea del tipo `Versión de MariaDB: 11.4.x-MariaDB-ubu2404`.

Problemas habituales:

| Síntoma | Causa |
|:--------|:------|
| `could not find driver` | El servicio usa `image: php:8.3-apache` en lugar de `build: .`, o no se reconstruyó tras crear el `Dockerfile` (`--build`). |
| `SQLSTATE[HY000] [2002] Connection refused` o `No such file or directory` | Host `localhost` en lugar de `db`, o `web` arrancó antes de que MariaDB estuviera lista (falta `condition: service_healthy`). |
| `Access denied for user` | Credenciales de `.env` cambiadas después del primer arranque sin borrar el volumen. |
| Contraseñas escritas en `hora.php` | Funciona, pero incumple el requisito 4 en espíritu: las credenciales deben venir del entorno. |
| Se muestra `$e->getMessage()` en la página | Funciona, pero revela detalles internos del servidor. |

### 7. Cambio de zona horaria: respuesta de referencia

**Prueba A — cambiar la zona del servidor.** En `.env` se pone `TZ_WEB=America/New_York` y se recrea el contenedor (no hace falta reconstruir la imagen):

```bash
docker compose up -d
docker compose exec web php -r 'echo date("H:i T");'
```

Al recargar `hora.php`, **cambia la hora del servidor** (6 horas menos que Madrid) y la zona pasa a `America/New_York`. **La del navegador no cambia.**

**Prueba B — cambiar la zona del equipo cliente.** En Windows: *Configuración → Hora e idioma → Fecha y hora*, desactivar «Establecer zona horaria automáticamente» y elegir otra (en Ubuntu con escritorio: `timedatectl set-timezone Asia/Tokyo`). Al recargar la página (a veces hay que reiniciar el navegador), **cambia la hora del navegador** y **no cambia la del servidor**.

Alternativa sin tocar el sistema: en Chrome, *DevTools → ⋮ → More tools → Sensors → Location*, elegir una ciudad; el navegador emula esa zona horaria.

**Explicación.** Cada hora la calcula un programa distinto en una máquina distinta, y cada uno consulta su propio reloj y su propia configuración:

| | Hora del servidor | Hora del navegador |
|:--|:--|:--|
| La calcula | PHP, dentro del contenedor `web` | El motor JavaScript del navegador |
| Cuándo | Una vez, al generar la respuesta | Cada vez que se ejecuta el script (cada segundo) |
| Depende de | `TZ` del contenedor → `date.timezone` de PHP | Zona horaria del sistema operativo del cliente |
| Cambia en | Prueba A | Prueba B |

**Matiz que conviene que aparezca (nivel 3–4):** aunque Docker se ejecute en el mismo PC que el navegador, cambiar la zona del PC **no** cambia la hora del servidor. El contenedor no hereda la zona horaria del equipo anfitrión (por defecto es UTC): es, a efectos prácticos, otra máquina. Por eso una aplicación con usuarios en varios países debe decidir dónde calcula las fechas, guardarlas en UTC y convertirlas a la zona de cada usuario al mostrarlas.

### 8. Código fuente: respuesta de referencia

Con *Ver código fuente* (`Ctrl+U`) se ve el HTML con las horas ya escritas en el bloque del servidor, la versión de MariaDB y el `<script>` completo, pero ni una línea de PHP: no aparecen `date()`, `getenv()`, `new PDO` ni las credenciales.

**Por qué.** Cuando el navegador pide `hora.php`, Apache ve la extensión `.php` y pasa el archivo al intérprete (`mod_php`). PHP ejecuta el código y lo sustituye por lo que imprime; Apache envía al navegador **solo ese resultado** (HTML). El JavaScript, en cambio, para PHP es texto normal: viaja tal cual dentro de la respuesta y es el navegador quien lo interpreta al recibirlo. Lo que se ve en el código fuente es exactamente lo que llegó por la red.

Evidencia que se puede pedir en la memoria:

```bash
curl -s http://localhost:8080/hora.php | grep -E "getenv|PDO\(|<\?php"   # sin resultados
```

**Matiz de nivel 3:** en *Ver código fuente* la hora del navegador aparece como `--:--:--`, porque es el HTML recibido. En *Inspeccionar* (DevTools, pestaña Elements) aparece la hora real, porque muestra el DOM después de que JavaScript lo modificara. Es la diferencia entre lo que envía el servidor y lo que hace el cliente con ello.

**Consecuencia de seguridad:** por eso las credenciales de la base de datos pueden estar al alcance de PHP y nunca deben estar en JavaScript. Si alguien viera PHP en el código fuente, el servidor no lo está procesando (archivo abierto con `file://`, extensión `.html`, módulo PHP no cargado…) y estaría exponiendo el código y lo que contenga.

### Nivel 4 de CE 1d: ventajas e inconvenientes de cada lado

Respuesta de referencia, relacionada con el ejemplo:

| | Procesar en el servidor (PHP) | Procesar en el cliente (JavaScript) |
|:--|:--|:--|
| Ventajas | Acceso a datos privados (la base de datos); el código y las credenciales no salen del servidor; resultado igual para todos los navegadores; el usuario no puede manipularlo. | Respuesta inmediata sin viajar a la red (la hora se actualiza sola); descarga trabajo del servidor; conoce el contexto del usuario (su zona horaria, su idioma, el tamaño de pantalla). |
| Inconvenientes | Cada actualización exige una nueva petición (la hora se congela); carga en el servidor con muchos usuarios; no conoce el contexto del cliente salvo que se lo envíe. | El código es visible y modificable por el usuario; no se puede confiar en sus datos (el usuario puede cambiar su reloj); depende de que JavaScript esté activado y del navegador; no puede acceder directamente a la base de datos. |
| En el ejemplo | La versión de MariaDB **solo** puede obtenerse aquí. | La hora local del usuario **solo** se conoce bien aquí. |

Conclusión esperable: se combinan. Lo que necesita datos o seguridad, en el servidor; lo que mejora la interacción, en el cliente. Y nunca se confía en una validación hecha solo en el cliente (enlaza con los formularios de la UP5).

---

## Parte 3. Reproducibilidad

### 10. Repositorio, `README.md` y `.env.example`

```bash
cd entorno-iaw
git init
git add .
git status --short          # comprobar que .env NO está
git commit -m "Entorno IAW con Docker Compose"
git branch -M main
git remote add origin https://github.com/USUARIO/entorno-iaw.git
git push -u origin main
```

El `README.md` de referencia incluye lo que pide cada nivel de CE 1i:

- **Nivel 2:** requisitos, pasos para levantar el entorno, `.env.example` con los nombres sin valores.
- **Nivel 3:** cómo parar (`stop`, `down`), borrar (`down -v`, `--rmi local`) y reiniciar (`restart`, `up -d --build`, empezar de cero).
- **Nivel 4:** problemas frecuentes con su solución, direcciones y datos de acceso a Adminer, aviso de que las credenciales solo se aplican en el primer arranque. Son las preguntas que, si faltan, la otra persona acaba haciendo.

### 11. Prueba con otra persona

En la memoria debe constar quién la hizo, en qué sistema, qué pasos siguió y qué tuvo que preguntar. Plantilla orientativa:

| Dato | Ejemplo |
|:-----|:--------|
| Persona que prueba | Nombre del compañero o compañera |
| Equipo y sistema | Portátil Windows 11 con Docker Desktop 4.x |
| Pasos seguidos | Clonar, copiar `.env.example`, rellenar, `up -d --build`, abrir `hora.php` y Adminer |
| Incidencias | Puerto 8080 ocupado por XAMPP; lo resolvió con el apartado «Problemas frecuentes» |
| Preguntas que tuvo que hacer | Ninguna → nivel 4 · Alguna → anotarla y mejorar el `README.md` |
| Evidencia | Captura de `docker compose ps` y de `hora.php` en el equipo de la otra persona |

Si alguna pregunta fue necesaria, lo valioso es que el `README.md` se corrija después y se cite el commit.

---

## Nivel 4 de CE 1h: comparación de entornos

| Aspecto | Instalación manual (P1.3–P1.4) | XAMPP / AMPPS | Docker Compose (P1.5) |
|:--------|:-------------------------------|:--------------|:----------------------|
| Tiempo de puesta en marcha | Alto: muchos pasos a mano | Muy bajo: un instalador | Bajo: un comando, tras instalar Docker |
| Reproducibilidad | Baja: depende de seguir la documentación al pie de la letra | Media: depende de la versión del paquete instalada | Alta: el archivo describe el entorno y las versiones fijadas |
| Parecido con producción | Alto: es un servidor real | Bajo: pensado solo para desarrollo, configuración poco segura por defecto | Alto: las mismas imágenes pueden usarse en el servidor |
| Aislamiento | Ninguno: todo en el mismo sistema | Ninguno: comparte el equipo y puertos | Cada servicio en su contenedor; varios proyectos con versiones distintas a la vez |
| Cambiar de versión de PHP o MariaDB | Difícil (repositorios, conflictos) | Hay que reinstalar el paquete | Cambiar una etiqueta y `up -d --build` |
| Seguridad por defecto | La que configures (P1.2–P1.4) | Débil (root sin contraseña en MySQL, paneles abiertos) | Credenciales obligatorias, base de datos no publicada |
| Consumo de recursos | Bajo (nativo) | Bajo | Algo mayor; en Windows y macOS necesita una máquina virtual por debajo |
| Lo que se aprende | Cómo funciona cada pieza | Poco sobre la configuración | Infraestructura como código, redes y volúmenes |
| Cuándo usarlo | Para aprender y en servidores tradicionales | Para empezar a programar sin complicaciones | Para trabajar en equipo y desplegar igual en todas partes |

Conclusión esperable: no se sustituyen, se complementan. La instalación manual explica lo que Docker automatiza; sin ella, el `docker-compose.yml` es una caja negra.
