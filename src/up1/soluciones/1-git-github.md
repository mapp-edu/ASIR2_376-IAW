---
layout: doc
title: "Solución P1.1 — Control de versiones con Git y GitHub"
sidebar: true
outline: [2, 3]
aside: true
---

# ✅ Solución P1.1 — Control de versiones con Git y GitHub

<script setup>
import { withBase } from 'vitepress'
</script>

<ExportPDF />

::: info-box Cómo usar esta solución
Es **una** solución de referencia: otras configuraciones son válidas si funcionan y se justifican. Enunciado: [P1.1 Git y GitHub](../ejercicios/1-git-github).
:::

- **Unidad:** UP1 · RA1 · CE 1b, 1i.
- **Archivos de la solución:**
  - <a :href="withBase('/soluciones/up1/p1.1-git-github/repo-referencia.sh')" download><code>repo-referencia.sh</code></a>: reproduce las partes 1 a 3 en un repositorio limpio (`bash repo-referencia.sh /tmp/servidor-docs`). Sirve para ver cómo debería quedar la historia y para enseñarlo en clase.
  - <a :href="withBase('/soluciones/up1/p1.1-git-github/salida-referencia.txt')" download><code>salida-referencia.txt</code></a>: salida completa de ese guion, con todas las órdenes y sus resultados.

Las órdenes de esta solución son las de Git 2.23 o posterior (`git switch`, `git restore`). Se aceptan las equivalentes antiguas (`git checkout`, `git reset HEAD`) si se explican, pero conviene comentarlo: los contenidos del módulo usan las nuevas.

---

## Parte 1. Repositorio local

### 1. Instalación y configuración

```bash
sudo apt update && sudo apt install -y git      # Windows: Git for Windows (git-scm.com)
git --version
git config --global user.name "Ana Alumna"
git config --global user.email "ana.alumna@example.com"
git config --global init.defaultBranch main
git config --global --list
```

| Orden | Para qué sirve |
|:------|:---------------|
| `user.name`, `user.email` | Firman cada confirmación. El correo debería ser el mismo de GitHub para que la web asocie las confirmaciones a la cuenta. |
| `init.defaultBranch main` | Los repositorios nuevos empiezan en `main` en lugar de `master`, como los que crea GitHub. Evita tener dos ramas distintas al hacer `push`. |
| `--global` | Se guarda en `~/.gitconfig` y vale para todos los repositorios del usuario. Sin él, solo para el repositorio actual (`.git/config`). |

### 2. Crear el repositorio

```bash
mkdir servidor-docs && cd servidor-docs
git init
```

`git init` crea la carpeta oculta `.git`, que **es** el repositorio: guarda la historia y la configuración. Borrarla convierte la carpeta en una normal.

### 3. `README.md`: estado antes y después de preparar

```bash
printf '# Servidor web de la empresa\n\nDocumentación y configuración del servidor web, con su historia de cambios.\n' > README.md
git status            # README.md «Untracked files»       (en --short: ?? README.md)
git add README.md
git status            # «Changes to be committed»           (en --short: A  README.md)
git commit -m "Añade el README con el propósito del repositorio"
```

**Explicación de las tres zonas (lo que pide el nivel 3 del primer elemento):**

| Zona | Qué contiene | Se pasa a la siguiente con |
|:-----|:-------------|:---------------------------|
| Directorio de trabajo | Los archivos tal como están en el disco ahora. | `git add` |
| Área de preparación (*staging*, índice) | La foto de lo que irá en la próxima confirmación. Permite confirmar solo parte de los cambios. | `git commit` |
| Repositorio (`.git`) | Las confirmaciones: fotos permanentes con autor, fecha y mensaje. | — |

En la salida corta de `git status`, la columna izquierda es el área de preparación y la derecha el directorio de trabajo: ` M` (modificado sin preparar), `M ` (preparado), `A ` (nuevo preparado), `??` (sin seguimiento), `!!` (ignorado).

### 4. `config/puertos.txt`

```bash
mkdir config
cat > config/puertos.txt <<'EOF'
HTTP   80/tcp
HTTPS  443/tcp
SSH    22/tcp
MySQL  3306/tcp
EOF
git add config/puertos.txt
git commit -m "Añade la lista de puertos de los servicios"
```

Git no guarda carpetas vacías: `config` entra en el repositorio porque contiene un archivo.

### 5. Añadir un puerto y ver la diferencia

```bash
echo "FTP    21/tcp" >> config/puertos.txt
git diff
git commit -am "Añade puerto ftp"
```

Salida esperada de `git diff`: la línea nueva precedida de `+`. `git diff` compara el directorio de trabajo con el área de preparación; si el alumno ya ha hecho `git add`, no verá nada y tendrá que usar `git diff --staged`. Es un buen punto para comprobar que ha entendido las zonas.

`-a` en `commit` prepara automáticamente los archivos que **ya tienen seguimiento**; no sirve para archivos nuevos.

### 6. Corregir el mensaje

```bash
git commit --amend -m "Añade el puerto de FTP a la lista de puertos"
```

`--amend` sustituye la última confirmación por otra nueva (cambia su identificador). Es seguro **solo si no se ha subido todavía**: si ya estaba en GitHub, obligaría a forzar el `push` y estropearía la copia de los demás.

### 7. Historia y autoría

```bash
git log --oneline
git blame config/puertos.txt
```

Salida de referencia (los identificadores y fechas cambian):

```
bf684e1 Añade el puerto de FTP a la lista de puertos
d7fa955 Añade la lista de puertos de los servicios
6546a7e Añade el README con el propósito del repositorio

d7fa955e (Ana Alumna 2026-10-28 11:32:29 +0100 1) HTTP   80/tcp
…
bf684e11 (Ana Alumna 2026-10-28 11:32:29 +0100 5) FTP    21/tcp
```

`git blame` indica, línea a línea, en qué confirmación y por quién se escribió. En un servidor responde a «¿quién abrió este puerto y por qué?».

---

## Parte 2. Deshacer cambios

| Situación | Orden | Zona que se corrige | Riesgo |
|:----------|:------|:--------------------|:-------|
| 1. Cambio sin preparar | `git restore config/puertos.txt` | Directorio de trabajo ← última versión preparada/confirmada | **Irreversible**: el cambio no estaba en ninguna parte de Git y se pierde. |
| 2. Cambio preparado | `git restore --staged config/puertos.txt` y después `git restore config/puertos.txt` | Primero el área de preparación; el archivo del disco no se toca. Después, el directorio de trabajo. | El primer paso no pierde nada. El segundo, como en el caso 1. |
| 3. Confirmación equivocada | `git revert HEAD` | Repositorio: añade una confirmación que hace lo contrario | Ninguno: no reescribe la historia y es seguro aunque ya esté subida. |
| 4. Archivos que no deben entrar | `.gitignore` | Evita que pasen a sin seguimiento → preparados | Solo actúa sobre archivos **sin seguimiento**: si ya se había confirmado, ignorarlo no lo saca de la historia. |

### 1. Sin preparar

```bash
sed -i '/^SSH/d' config/puertos.txt
git status --short             #  M config/puertos.txt
git restore config/puertos.txt
git status --short             # (vacío)
```

### 2. Preparado

```bash
sed -i '/^SSH/d' config/puertos.txt
git add config/puertos.txt
git status --short             # M  config/puertos.txt   (preparado)
git restore --staged config/puertos.txt
git status --short             #  M config/puertos.txt   (vuelve a no preparado, el cambio sigue)
git restore config/puertos.txt
```

La diferencia entre `M ` y ` M` en las capturas es la evidencia de que se ha entendido el paso.

### 3. Confirmación de un borrado

```bash
git rm README.md
git commit -m "Elimina el README"
git revert --no-edit HEAD      # crea «Revert "Elimina el README"»
ls                             # README.md vuelve a estar
```

Alternativa aceptable: `git reset --hard HEAD~1`. Funciona, pero **borra** la confirmación de la historia y descarta lo que hubiera sin confirmar. Si el alumnado la usa, para el nivel 3 debe explicar que solo es adecuada en local y antes de subir. `git revert` es la respuesta preferida porque el enunciado pide «deshacer esa confirmación» y en el repositorio compartido de la parte 4 sería la única segura.

### 4. `.gitignore`

```gitignore
# Registros
*.log

# Credenciales y datos sensibles
secretos.txt
```

```bash
echo "error de prueba" > acceso.log
echo "clave=no-subir"  > secretos.txt
git status --short                       # solo aparece ?? .gitignore
git add .gitignore && git commit -m "Ignora los registros y el archivo de secretos"
git status --short --ignored             # !! acceso.log   !! secretos.txt
git check-ignore -v acceso.log secretos.txt
```

`.gitignore` **sí** se confirma: es configuración del proyecto que comparten todos.

### Nivel 4: relación con las credenciales de un servidor real

Respuesta de referencia:

- `.gitignore` es la primera barrera: archivos como `.env`, `wp-config.php` o claves privadas no deben entrar nunca en un repositorio, y menos si es público. Se vuelve a ver en la P1.5 con el `.env` de Docker Compose.
- Si una contraseña ya se confirmó, añadirla a `.gitignore` **no** la borra: sigue en la historia. `git rm --cached archivo` deja de seguirlo a partir de ahora, pero las versiones antiguas siguen accesibles.
- Si ya se subió a GitHub hay que **dar la credencial por comprometida y cambiarla**. Reescribir la historia (`git filter-repo`) solo reduce la exposición: cualquiera puede haber clonado o bifurcado el repositorio.
- `git revert` deshace el efecto pero conserva la confirmación con el secreto; `git reset` solo la elimina de la copia local.
- GitHub tiene *secret scanning* y *push protection*, que bloquean el `push` si detectan un token conocido.

---

## Parte 3. Ramas

```bash
# 1. Rama apache
git switch -c apache
cat > config/vhost-intranet.conf <<'EOF'
<VirtualHost *:80>
    ServerName intranet.empresa.local
    DocumentRoot /var/www/intranet
    ErrorLog ${APACHE_LOG_DIR}/intranet_error.log
    CustomLog ${APACHE_LOG_DIR}/intranet_access.log combined
</VirtualHost>
EOF
git add config/vhost-intranet.conf
git commit -m "Añade el virtual host de la intranet"

# 2. Cambio en main
git switch main
sed -i '1s/.*/# Documentación del servidor web de la empresa/' README.md
git commit -am "Cambia el título del README"

# 3. Árbol
git log --oneline --graph --all

# 4. Fusión y borrado
git merge apache            # se abre el editor con «Merge branch 'apache'»
git branch -d apache
```

Árbol esperado en el paso 3, con las dos ramas separadas desde la misma confirmación:

```
* 7b997a3 Añade el virtual host de la intranet
| * 07ec594 Cambia el título del README
|/
* 1f3b48a Ignora los registros y el archivo de secretos
```

Como las dos ramas han avanzado, la fusión es de **tres vías** y crea una confirmación de fusión con dos padres. Si alguien no hizo el paso 2 antes de fusionar, verá *Fast-forward* y ninguna confirmación de fusión: no es un error, pero el árbol no muestra la bifurcación que pide el paso 3.

`git branch -d` solo borra ramas ya fusionadas; `-D` fuerza el borrado y puede perder trabajo.

### 5. Conflicto

```bash
git switch -c puertos
sed -i 's|^HTTP   80/tcp|HTTP   8080/tcp|' config/puertos.txt
git commit -am "Cambia HTTP al puerto 8080"

git switch main
sed -i 's|^HTTP   80/tcp|HTTP   80/tcp   (redirige a HTTPS)|' config/puertos.txt
git commit -am "Indica que HTTP redirige a HTTPS"

git merge puertos           # CONFLICT (content): Merge conflict in config/puertos.txt
git status                  # both modified: config/puertos.txt
```

Contenido del archivo durante el conflicto:

```
<<<<<<< HEAD
HTTP   80/tcp   (redirige a HTTPS)
=======
HTTP   8080/tcp
>>>>>>> puertos
HTTPS  443/tcp
…
```

Se edita a mano (o con VS Code, «Accept Current / Incoming / Both»), se quitan las marcas y se deja el contenido decidido:

```bash
git add config/puertos.txt
git commit -m "Fusiona puertos: HTTP se queda en el 80 y redirige a HTTPS"
git branch -d puertos
git log --oneline --graph --all
```

**Explicación de referencia (nivel 3):** las dos ramas cambiaron **la misma línea** desde el antepasado común, de forma distinta. Git fusiona solo cuando los cambios están en zonas diferentes; aquí no puede saber cuál es correcto y lo deja a la persona. La decisión debe justificarse con criterio técnico; por ejemplo: «se mantiene el 80 porque es el puerto que usan los navegadores por defecto y la nota de la redirección aporta información; el 8080 obligaría a escribir el puerto en la URL». Cualquier decisión razonada vale; lo que no vale es dejar las marcas `<<<<<<<` en el archivo (comprobar en GitHub).

Árbol final de referencia:

```
*   17aefc7 Fusiona puertos: HTTP se queda en el 80 y redirige a HTTPS
|\
| * 78a0122 Cambia HTTP al puerto 8080
* | 570686a Indica que HTTP redirige a HTTPS
|/
*   1589d61 Merge branch 'apache'
|\
| * 7b997a3 Añade el virtual host de la intranet
* | 07ec594 Cambia el título del README
|/
* 1f3b48a Ignora los registros y el archivo de secretos
* eddb780 Revert "Elimina el README"
* 74dea2f Elimina el README
* bf684e1 Añade el puerto de FTP a la lista de puertos
* d7fa955 Añade la lista de puertos de los servicios
* 6546a7e Añade el README con el propósito del repositorio
```

---

## Parte 4. GitHub

### 1 y 2. Publicar el repositorio

1. En GitHub: *New repository* → nombre `servidor-docs`, **Public**, **sin** README, `.gitignore` ni licencia (si se crean, el remoto tendrá una confirmación que el local no tiene y el primer `push` fallará).
2. Crear un token: *Settings → Developer settings → Personal access tokens → Fine-grained tokens*, con acceso al repositorio y permiso *Contents: Read and write*. Caducidad corta.

```bash
git remote add origin https://github.com/USUARIO/servidor-docs.git
git remote -v
git push -u origin main        # usuario de GitHub y, como contraseña, el token
```

En Windows, Git Credential Manager abre el navegador y no hace falta token. Alternativas igual de válidas: SSH con clave (`git@github.com:…`) o `gh auth login`.

Comprobación del paso 2: *Insights → Network* o la lista de *commits* de GitHub deben mostrar las mismas confirmaciones, con los mismos identificadores, que `git log --oneline --graph --all`. Eso es lo que pide el nivel 4 del elemento de ramas.

Error típico: `! [rejected] main -> main (fetch first)` → el repositorio remoto se creó con README. Se resuelve con `git pull --rebase origin main` (o `--allow-unrelated-histories`) y volviendo a hacer `push`.

### 3. Bifurcación y *pull request*

```bash
# En la web del compañero: botón «Fork»
git clone https://github.com/USUARIO/servidor-docs.git servidor-docs-companero
cd servidor-docs-companero
git switch -c revision
echo "Ana Alumna — revisión de la documentación de puertos" > revisores.txt
git add revisores.txt
git commit -m "Añade revisores.txt con la revisión de Ana Alumna"
git push -u origin revision
```

Después, en GitHub, *Compare & pull request*: base `COMPANERO/servidor-docs:main` ← head `USUARIO/servidor-docs:revision`.

Descripción de referencia (nivel 4: se puede revisar sin preguntar):

```markdown
## Qué cambia
Añade `revisores.txt` con mi nombre, para dejar constancia de que he revisado la documentación.

## Por qué
Es la tarea 4.3 de la P1.1: practicar la colaboración mediante bifurcación y pull request.

## Cómo comprobarlo
- Solo se añade un archivo; no se modifica ninguno existente.
- No hay conflictos con `main`.

## Observaciones de la revisión
En `config/puertos.txt` falta indicar si MySQL debe estar abierto al exterior; propongo añadir una nota.
```

### 4. Aceptar la que se recibe

En *Pull requests* → abrir la recibida → *Files changed* (revisar, opcionalmente *Review changes → Approve*) → *Merge pull request* → *Confirm merge*. Después, en local:

```bash
git pull
```

### Explicación de referencia: `push`, `pull`, `clone` y bifurcación (nivel 3)

| Orden / concepto | Qué hace |
|:-----------------|:---------|
| `git clone URL` | Copia un repositorio remoto completo, con toda su historia, y configura `origin` apuntando a él. |
| `git push` | Envía al remoto las confirmaciones locales que no tiene. Necesita permiso de escritura. |
| `git pull` | Trae las confirmaciones del remoto (`fetch`) y las integra en la rama actual (`merge` o `rebase`). |
| Bifurcación (*fork*) | Copia del repositorio **en GitHub** bajo la cuenta propia. Permite proponer cambios a un proyecto en el que no se tiene permiso de escritura: se trabaja en la copia y se pide al propietario que incorpore los cambios mediante una *pull request*, que él revisa antes de aceptar. |

---

## Problemas habituales

| Síntoma | Causa |
|:--------|:------|
| Confirmaciones firmadas como «root» o con un correo que GitHub no reconoce | Falta `user.name`/`user.email`, o se configuró después de confirmar. |
| `git log` muestra `Añade puerto ftp` | No se hizo el paso 1.6, o se hizo `--amend` sin `-m` y se dejó el mismo texto. |
| No hay confirmación «Elimina el README» seguida de «Revert …» | Usó `git restore` o `git checkout` antes de confirmar: no es lo que pide el paso 2.3. |
| `secretos.txt` aparece en GitHub | Se confirmó antes de crear `.gitignore`. |
| Marcas `<<<<<<<` en `puertos.txt` en GitHub | Conflicto resuelto con `git add` sin editar el archivo. |
| No existe la rama `master`/`main` en GitHub o hay dos | Falta `init.defaultBranch main` y se subió `master`. |
| Token visible en capturas o en `git remote -v` (`https://TOKEN@github.com/…`) | Incumple el aviso del enunciado. Hay que revocar el token. |
