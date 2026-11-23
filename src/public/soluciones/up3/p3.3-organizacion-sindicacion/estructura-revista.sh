#!/usr/bin/env bash
# P3.3 — Monta con WP-CLI la organización de referencia de la revista (tema Twenty Twenty-Five):
# categorías y subcategorías, artículos con etiquetas, enlaces permanentes con la categoría,
# menú de secciones, plantilla de archivo de categoría y plantilla «Sin barra lateral».
#
# Uso:  WP_PATH=/var/www/revista bash estructura-revista.sh
# El alumnado hace lo mismo desde el panel; esto sirve para preparar una demostración o comparar.
set -euo pipefail
WP_PATH="${WP_PATH:-/var/www/revista}"
TEMA="${TEMA:-twentytwentyfive}"
wp() { command wp --path="$WP_PATH" --allow-root "$@" 2>/dev/null; }

echo "== Categorías"
cat_id() { wp term list category --slug="$1" --field=term_id; }
cat_new() {  # nombre slug descripción [padre]
  local id; id=$(cat_id "$2")
  [ -n "$id" ] || id=$(wp term create category "$1" --slug="$2" --description="$3" ${4:+--parent="$4"} --porcelain)
  echo "$id"
}
TEC=$(cat_new "Tecnología" tecnologia "Informática, ciencia aplicada e Internet.")
SAL=$(cat_new "Salud" salud "Hábitos saludables, prevención y avances médicos.")
CUL=$(cat_new "Cultura" cultura "Agenda y crítica cultural.")
CIN=$(cat_new "Cine" cine "Estrenos, festivales y clásicos." "$CUL")
MUS=$(cat_new "Música" musica "Conciertos, discos y festivales." "$CUL")

echo "== Artículos (las etiquetas «jóvenes», «Valencia» y «festivales» se repiten entre secciones)"
art() { wp post create --post_title="$1" --post_status=publish --post_category="$2" --tags_input="$3" \
        --post_content="<!-- wp:paragraph --><p>$1.</p><!-- /wp:paragraph -->" --porcelain >/dev/null; }
art "La inteligencia artificial llega a las aulas" "$TEC" "inteligencia artificial,educación,jóvenes"
art "Dormir bien mejora la memoria"                 "$SAL" "jóvenes,hábitos,educación"
art "Museos gratis el primer domingo de mes"        "$CUL" "Valencia,museos,ocio"
art "Festival de cortometrajes en Valencia"         "$CIN" "Valencia,jóvenes,festivales"
art "Gira de otoño de la orquesta"                  "$MUS" "Valencia,conciertos,festivales"

echo "== Enlaces permanentes: /categoría/artículo/"
wp rewrite structure '/%category%/%postname%/'
[ -f "$WP_PATH/.htaccess" ] || echo "AVISO: guarda Ajustes → Enlaces permanentes en el panel para crear .htaccess"

echo "== Menú de secciones"
# El bloque Navegación solo genera el enlace si el elemento guarda su "url" (el editor la guarda siempre).
curl_cat() { wp eval "echo get_category_link($1);"; }
cl() { printf '<!-- wp:navigation-link {"label":"%s","type":"category","id":%s,"url":"%s","kind":"taxonomy"} /-->' "$1" "$2" "$(curl_cat "$2")"; }
MENU="$(cl Tecnología "$TEC")$(cl Salud "$SAL")"
MENU+="<!-- wp:navigation-submenu {\"label\":\"Cultura\",\"type\":\"category\",\"id\":$CUL,\"url\":\"$(curl_cat "$CUL")\",\"kind\":\"taxonomy\"} -->$(cl Cine "$CIN")$(cl Música "$MUS")<!-- /wp:navigation-submenu -->"
wp post create --post_type=wp_navigation --post_status=publish --post_title="Secciones" --post_content="$MENU" --porcelain >/dev/null

echo "== Plantilla de archivo de categoría"
CAT_TPL='<!-- wp:template-part {"slug":"header"} /-->
<!-- wp:group {"tagName":"main","style":{"spacing":{"margin":{"top":"var:preset|spacing|60"}}},"layout":{"type":"constrained"}} -->
<main class="wp-block-group" style="margin-top:var(--wp--preset--spacing--60)">
<!-- wp:group {"style":{"spacing":{"padding":{"top":"var:preset|spacing|40","bottom":"var:preset|spacing|40","left":"var:preset|spacing|40","right":"var:preset|spacing|40"}}},"backgroundColor":"accent-5","layout":{"type":"constrained"}} -->
<div class="wp-block-group has-accent-5-background-color has-background">
<!-- wp:query-title {"type":"archive","showPrefix":false} /-->
<!-- wp:term-description {"fontSize":"large"} /-->
</div>
<!-- /wp:group -->
<!-- wp:pattern {"slug":"twentytwentyfive/template-query-loop"} /-->
</main>
<!-- /wp:group -->
<!-- wp:template-part {"slug":"footer"} /-->'
ID=$(wp post create --post_type=wp_template --post_name=category --post_title="Archivo de categoría" --post_status=publish --post_content="$CAT_TPL" --porcelain)
wp post term set "$ID" wp_theme "$TEMA" >/dev/null

echo "== Plantilla personalizada «Sin barra lateral» y página «Sobre la revista»"
PAG_TPL='<!-- wp:template-part {"slug":"header"} /-->
<!-- wp:group {"tagName":"main","align":"full","layout":{"type":"constrained","contentSize":"1100px"}} -->
<main class="wp-block-group alignfull">
<!-- wp:post-title {"level":1} /-->
<!-- wp:post-content {"layout":{"type":"constrained","contentSize":"1100px"}} /-->
</main>
<!-- /wp:group -->
<!-- wp:template-part {"slug":"footer"} /-->'
ID=$(wp post create --post_type=wp_template --post_name=wp-custom-template-sin-barra-lateral --post_title="Sin barra lateral" --post_status=publish --post_content="$PAG_TPL" --porcelain)
wp post term set "$ID" wp_theme "$TEMA" >/dev/null
wp post meta update "$ID" is_wp_suggestion 0 >/dev/null
wp post create --post_type=page --post_title="Sobre la revista" --post_status=publish \
   --post_content="<!-- wp:paragraph --><p>Revista digital sobre tecnología, salud y cultura.</p><!-- /wp:paragraph -->" \
   --page_template=wp-custom-template-sin-barra-lateral --porcelain >/dev/null

echo "== Resultado"
wp term list category --fields=term_id,name,slug,parent,count
wp term list post_tag --fields=name,count
