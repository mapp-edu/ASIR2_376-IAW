#!/usr/bin/env bash
# P2.4 — Lista de verificación reutilizable de una instalación de WordPress en LAMP.
# Uso: sudo bash verificar-wp.sh [carpeta] [url] [base_de_datos] [prefijo]
WP="${1:-/var/www/wp-intranet}"; URL="${2:-http://wp.empresa.local}"; BD="${3:-wp_intranet}"; PRE="${4:-intra_}"
ok(){ printf '  [OK]  %s\n' "$1"; }; ko(){ printf '  [!!]  %s\n' "$1"; }
echo "== Servidor"
php -r 'exit(version_compare(PHP_VERSION,"8.3","<"));' && ok "PHP $(php -r 'echo PHP_VERSION;') (recomendado 8.3+)" || ko "PHP antiguo"
for e in mysqli curl dom mbstring xml zip intl gd imagick exif fileinfo; do php -m | grep -qix "$e" && ok "extensión $e" || ko "falta la extensión $e"; done
apache2ctl -M 2>/dev/null | grep -q rewrite_module && ok "mod_rewrite activo" || ko "mod_rewrite inactivo"
echo "== Archivos"
[ "$(stat -c %U "$WP/wp-content")" = www-data ] && ok "wp-content es de www-data" || ko "wp-content no es de www-data"
P=$(stat -c %a "$WP/wp-config.php"); [ "$P" -le 640 ] && ok "wp-config.php con permisos $P" || ko "wp-config.php con permisos $P (demasiado abiertos)"
echo "== wp-config.php"
grep -q "'DISALLOW_FILE_EDIT', true" "$WP/wp-config.php" && ok "editor de archivos desactivado" || ko "editor de archivos activo"
grep -q "'WP_POST_REVISIONS', 5" "$WP/wp-config.php" && ok "revisiones limitadas a 5" || ko "revisiones sin limitar"
grep -q "'WP_DEBUG', false" "$WP/wp-config.php" && ok "depuración desactivada" || ko "depuración activa"
echo "== Web"
C=$(curl -s -o /dev/null -w '%{http_code}' "$URL/"); [ "$C" = 200 ] && ok "portada 200" || ko "portada $C"
# La primera entrada (?p=1, «Hola, mundo») debe redirigir a su enlace permanente y responder 200
R=$(curl -s -L -o /dev/null -w '%{http_code} %{url_effective}' "$URL/?p=1")
case "$R" in "200 "*"?p="*) ko "enlaces permanentes sin activar ($R)";; "200 "*) ok "enlace permanente ${R#200 }";; *) ko "enlace permanente: $R";; esac
C=$(curl -s -o /dev/null -w '%{http_code}' "$URL/wp-content/debug.log"); [ "$C" = 404 ] && ok "debug.log no publicado" || ko "debug.log accesible ($C)"
echo "== Base de datos"
N=$(mysql -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$BD' AND table_name LIKE '${PRE}%';"); [ "$N" -ge 12 ] && ok "$N tablas con prefijo $PRE" || ko "solo $N tablas con prefijo $PRE"
mysql -N -e "SELECT CONCAT('  ', option_name, ' = ', option_value) FROM $BD.${PRE}options WHERE option_name IN ('siteurl','home');"
