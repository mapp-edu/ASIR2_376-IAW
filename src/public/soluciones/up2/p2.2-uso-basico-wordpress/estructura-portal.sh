#!/usr/bin/env bash
# P2.2 — Crea con WP-CLI la estructura de referencia del portal interno:
# ajustes generales, páginas con su jerarquía, página de inicio estática y
# menú principal con dos niveles (bloque de navegación del tema de bloques).
#
# Uso (en la carpeta de WordPress):  bash estructura-portal.sh
#   o indicando la ruta:             WP_PATH=/var/www/wp-intranet bash estructura-portal.sh
# En AMPPS (Windows) se puede ejecutar desde Git Bash si WP-CLI está instalado.
# Sirve al profesorado para preparar una demostración o comparar con el sitio
# del alumnado; el alumnado hace lo mismo desde el panel.
set -euo pipefail

WP_PATH="${WP_PATH:-.}"
wp() { command wp --path="$WP_PATH" --allow-root --skip-plugins --skip-themes "$@" 2>/dev/null; }

echo "== Ajustes generales"
wp option update blogname        "Portal interno · Empresa"
wp option update blogdescription "Avisos, incidencias y documentación para la plantilla"
wp option update timezone_string "Europe/Madrid"
wp option update date_format     "j \\d\\e F \\d\\e Y"
wp option update time_format     "H:i"
wp option update start_of_week   1
wp option update blog_public     0   # portal interno: que no lo indexen los buscadores

echo "== Enlaces permanentes con el nombre de la página"
wp rewrite structure '/%postname%/'
# WP-CLI no escribe .htaccess por su cuenta: si no existe, basta con abrir
# Ajustes → Enlaces permanentes en el panel y pulsar «Guardar cambios».
[ -f "$WP_PATH/.htaccess" ] || echo "AVISO: falta .htaccess; guarda los enlaces permanentes desde el panel."

echo "== Páginas"
pagina() {   # pagina "Título" "Contenido" [id_padre] [orden]
  wp post create --post_type=page --post_status=publish --porcelain \
     --post_title="$1" --post_content="<!-- wp:paragraph --><p>$2</p><!-- /wp:paragraph -->" \
     --post_parent="${3:-0}" --menu_order="${4:-0}"
}
INICIO=$(pagina "Inicio" "Bienvenida al portal interno de la empresa: aquí encontrarás los comunicados, podrás notificar incidencias al administrador de sistemas y consultar la documentación." 0 1)
COMUN=$(pagina  "Comunicados" "Comunicados de la empresa para toda la plantilla." 0 2)
GEN=$(pagina    "Generales" "Información general para los empleados." "$COMUN" 1)
URG=$(pagina    "Urgentes" "Comunicados urgentes. Revísalos al empezar la jornada." "$COMUN" 2)
MENS=$(pagina   "Mensajes" "Comunicación entre la plantilla y el administrador de sistemas." 0 3)
RES=$(pagina    "Incidencias resueltas" "Incidencias ya resueltas y su solución." "$MENS" 1)
NOT=$(pagina    "Notificar incidencia" "Describe la incidencia: qué ocurre, desde cuándo y en qué equipo." "$MENS" 2)
REC=$(pagina    "Recursos" "Repositorio de documentos y archivos de uso interno." 0 4)
CAL=$(pagina    "Calendario" "Eventos y fechas importantes de la empresa." 0 5)

echo "== Página de inicio estática"
wp option update show_on_front page
wp option update page_on_front "$INICIO"

echo "== Menú principal (bloque de navegación)"
# El bloque Navegación solo genera el enlace si el elemento guarda su "url" (el editor la guarda siempre).
url() { wp eval "echo get_permalink($1);"; }
enlace() { printf '<!-- wp:navigation-link {"label":"%s","type":"page","id":%s,"url":"%s","kind":"post-type"} /-->' "$1" "$2" "$(url "$2")"; }
submenu() { printf '<!-- wp:navigation-submenu {"label":"%s","type":"page","id":%s,"url":"%s","kind":"post-type"} -->%s<!-- /wp:navigation-submenu -->' "$1" "$2" "$(url "$2")" "$3"; }
MENU="$(enlace Inicio "$INICIO")"
MENU+="$(submenu Comunicados "$COMUN" "$(enlace Generales "$GEN")$(enlace Urgentes "$URG")")"
MENU+="$(submenu Mensajes "$MENS" "$(enlace 'Incidencias resueltas' "$RES")$(enlace 'Notificar incidencia' "$NOT")")"
MENU+="$(enlace Recursos "$REC")$(enlace Calendario "$CAL")"
wp post create --post_type=wp_navigation --post_status=publish --post_title="Menú principal" \
   --post_content="$MENU" --porcelain >/dev/null

echo "== Resultado"
wp post list --post_type=page --fields=ID,post_title,post_parent,menu_order --orderby=menu_order --order=asc
