#!/usr/bin/env bash
# P3.4 — Monta con WP-CLI el sitio de referencia de la tienda (partes 2 a 4 del proyecto):
# ajustes, categorías, páginas con categoría, menú de tres niveles, usuarios y grupos.
#
# Requisitos en wp-content/plugins: «categorias-en-paginas» (archivos/) y «groups» (repositorio oficial).
# Uso:  WP_PATH=/opt/lampp/htdocs/tienda bash tienda-referencia.sh
#       (en XAMPP para Windows, desde Git Bash con WP-CLI instalado: WP_PATH=/c/xampp/htdocs/tienda)
# El alumnado hace lo mismo desde el panel; esto sirve para preparar una demostración o comparar.
set -euo pipefail
WP_PATH="${WP_PATH:-/opt/lampp/htdocs/tienda}"
ADMIN="${ADMIN:-gerente}"   # usuario administrador creado en la instalación
TEMA="${TEMA:-twentytwentyfour}"
wp() { command wp --path="$WP_PATH" --allow-root "$@" 2>/dev/null; }

echo "== Ajustes"
wp option update blogname "ElectroHogar"
wp option update blogdescription "Electrónica y hogar al mejor precio"
wp option update timezone_string "Europe/Madrid"
wp rewrite structure '/%postname%/'
wp theme activate "$TEMA"
wp plugin activate categorias-en-paginas groups

echo "== Categorías"
cat_new() { wp term create category "$1" --slug="$2" ${3:+--parent="$3"} --porcelain; }
ELE=$(cat_new "Electrónica" electronica); HOG=$(cat_new "Hogar" hogar)
MOV=$(cat_new "Móviles" moviles "$ELE"); ORD=$(cat_new "Ordenadores" ordenadores "$ELE")
COC=$(cat_new "Cocina" cocina "$HOG"); DEC=$(cat_new "Decoración" decoracion "$HOG")
INF=$(cat_new "Información" informacion)
wp term update category 1 --name="General" --slug=general >/dev/null   # en vez de «Sin categoría»

pagina() {  # título categoría autor contenido
  wp post create --post_type=page --post_status=publish --post_title="$1" --post_category="$2" \
     --post_author="$(wp user get "$3" --field=ID)" --post_content="$4" --porcelain
}
echo "== Usuarios"
alta() { wp user get "$1" >/dev/null 2>&1 || wp user create "$1" "$1@electrohogar.example" --role="$2" --display_name="$3" --user_pass="$4" --porcelain >/dev/null; }
alta lsanz     editor      "Lucía Sanz (responsable de contenidos)"  'Ed1tora-Lucia-2026'
alta dperez    author      "Diego Pérez (dependiente de electrónica)" 'Aut0r-Diego-2026'
alta mgil      author      "Marta Gil (dependienta de hogar)"         'Aut0ra-Marta-2026'
alta ajimenez  contributor "Álex Jiménez (alumno en prácticas)"       'Col4b-Alex-2026'
alta cliente1  subscriber  "Cliente registrado"                       'Susc-Cliente-2026'

echo "== Páginas (los autores no pueden crear páginas: las crean la gerente y la editora)"
SOB=$(pagina "Sobre nosotros" "$INF" "$ADMIN" '<!-- wp:paragraph --><p>ElectroHogar es una tienda familiar de electrónica y hogar. Consulta nuestras secciones de <a href="/category/electronica/">Electrónica</a> y <a href="/category/hogar/">Hogar</a>.</p><!-- /wp:paragraph -->')
CON=$(pagina "Contacto" "$INF" "$ADMIN" '<!-- wp:paragraph --><p>Escríbenos a <a href="mailto:info@electrohogar.example">info@electrohogar.example</a> o visítanos de lunes a sábado.</p><!-- /wp:paragraph -->')
PMOV=$(pagina "Móviles" "$MOV" lsanz ""); PORD=$(pagina "Ordenadores" "$ORD" lsanz "")
PCOC=$(pagina "Cocina" "$COC" lsanz "");   PDEC=$(pagina "Decoración" "$DEC" lsanz "")
# Contenido de ejemplo: fuera la «Página de ejemplo» y el «Hola, mundo»; la política de privacidad, a Información
wp post delete 1 2 --force >/dev/null || true
wp post term set 3 category "$INF" --by=id >/dev/null || true

echo "== Menú de tres niveles"
url_p() { wp eval "echo get_permalink($1);"; }
url_c() { wp eval "echo get_category_link($1);"; }
enl() { printf '<!-- wp:navigation-link {"label":"%s","type":"page","id":%s,"url":"%s","kind":"post-type"} /-->' "$1" "$2" "$(url_p "$2")"; }
sub_cat() { printf '<!-- wp:navigation-submenu {"label":"%s","type":"category","id":%s,"url":"%s","kind":"taxonomy"} -->%s<!-- /wp:navigation-submenu -->' "$1" "$2" "$(url_c "$2")" "$3"; }
MENU='<!-- wp:home-link {"label":"Inicio"} /-->'
MENU+='<!-- wp:navigation-submenu {"label":"Productos"} -->'
MENU+="$(sub_cat Electrónica "$ELE" "$(enl Móviles "$PMOV")$(enl Ordenadores "$PORD")")"
MENU+="$(sub_cat Hogar "$HOG" "$(enl Cocina "$PCOC")$(enl Decoración "$PDEC")")"
MENU+='<!-- /wp:navigation-submenu -->'
MENU+="$(enl 'Sobre nosotros' "$SOB")$(enl Contacto "$CON")"
wp post create --post_type=wp_navigation --post_status=publish --post_title="Menú principal" --post_content="$MENU" --porcelain >/dev/null

echo "== Grupos (plugin Groups)"
wp eval '
$grupos = array(
  "Equipo de tienda" => array("dperez", "mgil", "ajimenez"),
  "Contenidos web"   => array("lsanz", "dperez", "mgil"),
);
foreach ($grupos as $nombre => $usuarios) {
  $g = Groups_Group::read_by_name($nombre);
  $id = $g ? $g->group_id : Groups_Group::create(array("name" => $nombre));
  foreach ($usuarios as $login) {
    $u = get_user_by("login", $login);
    if ($u && !Groups_User_Group::read($u->ID, $id)) Groups_User_Group::create(array("user_id" => $u->ID, "group_id" => $id));
  }
  $miembros = array();
  foreach ((new Groups_Group($id))->users as $gu) $miembros[] = $gu->user->user_login;
  echo "  $nombre: " . implode(", ", $miembros) . "\n";
}'

echo "== Resultado"
wp user list --fields=user_login,display_name,roles
wp post list --post_type=page --fields=ID,post_title,post_author --orderby=title --order=asc
