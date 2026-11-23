#!/usr/bin/env bash
# P1.1 — Reproduce las partes 1, 2 y 3 de la práctica en un repositorio limpio.
# Uso: bash repo-referencia.sh [carpeta]   (por defecto ./servidor-docs)
# Sirve al profesorado para ver la historia que debería tener un repositorio
# correcto y comparar con el del alumnado. La parte 4 (GitHub) se hace a mano.
set -euo pipefail
export GIT_PAGER=cat LC_ALL=C.UTF-8

DIR="${1:-servidor-docs}"
rm -rf "$DIR" && mkdir "$DIR" && cd "$DIR"
paso() { printf '\n\033[1;34m### %s\033[0m\n' "$*"; }
cmd()  { printf '\033[0;32m$ %s\033[0m\n' "$*"; eval "$@"; }

# ── Parte 1 ─────────────────────────────────────────────────────────────
paso "1.1 Configuración (local al repositorio para no tocar la del equipo)"
cmd git init -q
cmd git config user.name '"Ana Alumna"'
cmd git config user.email '"ana.alumna@example.com"'
cmd git symbolic-ref HEAD refs/heads/main
cmd git config --list --local

paso "1.3 README.md"
printf '# Servidor web de la empresa\n\nDocumentación y configuración del servidor web, con su historia de cambios.\n' > README.md
cmd git status --short
cmd git add README.md
cmd git status --short
cmd git commit -q -m '"Añade el README con el propósito del repositorio"'

paso "1.4 config/puertos.txt"
mkdir config
printf 'HTTP   80/tcp\nHTTPS  443/tcp\nSSH    22/tcp\nMySQL  3306/tcp\n' > config/puertos.txt
cmd git add config/puertos.txt
cmd git commit -q -m '"Añade la lista de puertos de los servicios"'

paso "1.5 Nuevo puerto y diferencia antes de confirmar"
printf 'FTP    21/tcp\n' >> config/puertos.txt
cmd git diff
cmd git commit -q -am '"Añade puerto ftp"'

paso "1.6 Corregir el mensaje de la última confirmación"
cmd git commit -q --amend -m '"Añade el puerto de FTP a la lista de puertos"'

paso "1.7 Historia y autoría por línea"
cmd git log --oneline
cmd git blame config/puertos.txt

# ── Parte 2 ─────────────────────────────────────────────────────────────
paso "2.1 Borrar una línea sin preparar y recuperarla"
sed -i '/^SSH/d' config/puertos.txt
cmd git status --short
cmd git restore config/puertos.txt
cmd git status --short

paso "2.2 Borrar, preparar, sacar del área de preparación y recuperar"
sed -i '/^SSH/d' config/puertos.txt
cmd git add config/puertos.txt
cmd git status --short
cmd git restore --staged config/puertos.txt
cmd git status --short
cmd git restore config/puertos.txt
cmd git status --short

paso "2.3 Borrado accidental confirmado y deshecho con revert"
cmd git rm -q README.md
cmd git commit -q -m '"Elimina el README"'
cmd git revert --no-edit HEAD
cmd ls

paso "2.4 .gitignore"
printf '# Registros\n*.log\n\n# Credenciales y datos sensibles\nsecretos.txt\n' > .gitignore
echo "error de prueba" > acceso.log
echo "clave=no-subir" > secretos.txt
cmd git status --short
cmd git add .gitignore
cmd git commit -q -m '"Ignora los registros y el archivo de secretos"'
cmd git status --short --ignored
cmd git check-ignore -v acceso.log secretos.txt

# ── Parte 3 ─────────────────────────────────────────────────────────────
paso "3.1 Rama apache con un virtual host"
cmd git switch -q -c apache
cat > config/vhost-intranet.conf <<'EOF'
<VirtualHost *:80>
    ServerName intranet.empresa.local
    DocumentRoot /var/www/intranet
    ErrorLog ${APACHE_LOG_DIR}/intranet_error.log
    CustomLog ${APACHE_LOG_DIR}/intranet_access.log combined
</VirtualHost>
EOF
cmd git add config/vhost-intranet.conf
cmd git commit -q -m '"Añade el virtual host de la intranet"'

paso "3.2 Cambio en main"
cmd git switch -q main
sed -i '1s/.*/# Documentación del servidor web de la empresa/' README.md
cmd git commit -q -am '"Cambia el título del README"'

paso "3.3 Árbol de todas las ramas"
cmd git log --oneline --graph --all

paso "3.4 Fusionar apache en main y borrar la rama"
cmd git merge --no-edit apache
cmd git branch -d apache
cmd git log --oneline --graph

paso "3.5 Conflicto"
cmd git switch -q -c puertos
sed -i 's|^HTTP   80/tcp|HTTP   8080/tcp|' config/puertos.txt
cmd git commit -q -am '"Cambia HTTP al puerto 8080"'
cmd git switch -q main
sed -i 's|^HTTP   80/tcp|HTTP   80/tcp   (redirige a HTTPS)|' config/puertos.txt
cmd git commit -q -am '"Indica que HTTP redirige a HTTPS"'
cmd git merge puertos || true
cmd git status --short
cmd cat config/puertos.txt
# Resolución: se mantiene el puerto estándar 80 (el que esperan los navegadores)
# y la nota de la redirección; el 8080 se descarta.
sed -i '/^<<<<<<<\|^=======\|^>>>>>>>/d; /^HTTP   8080/d' config/puertos.txt
cmd cat config/puertos.txt
cmd git add config/puertos.txt
cmd git commit -q -m '"Fusiona puertos: HTTP se queda en el 80 y redirige a HTTPS"'
cmd git branch -d puertos
cmd git log --oneline --graph --all
