#!/usr/bin/env bash
# P3.2 — Crea el equipo de la revista, el rol Corrector, y comprueba los permisos de cada rol
# con peticiones reales a la API REST de WordPress (lo mismo que hace el editor de bloques).
#
# Uso (en el servidor, como root):  WP_PATH=/var/www/revista URL=http://revista.local bash equipo-revista.sh
# Requisitos: WP-CLI, curl, python3. Para usar contraseñas de aplicación por HTTP,
# el script define WP_ENVIRONMENT_TYPE=local en wp-config.php (quitar al terminar).
# Sirve al profesorado para preparar una demostración o comparar con lo que entrega el alumnado.
set -euo pipefail
WP_PATH="${WP_PATH:-/var/www/revista}"
URL="${URL:-http://revista.local}"
wp() { command wp --path="$WP_PATH" --allow-root "$@" 2>/dev/null; }

echo "== Usuarios (contraseñas de ejemplo: cámbialas)"
alta() {  # usuario rol nombre contraseña
  wp user get "$1" >/dev/null 2>&1 || wp user create "$1" "$1@revista.local" --role="$2" --display_name="$3" --user_pass="$4" --porcelain >/dev/null
  wp user set-role "$1" "$2" >/dev/null
}
alta lmartin  editor      "Luis Martín"   'Ed1tor-Luis-2026'
alta cruiz    editor      "Carmen Ruiz"   'Ed1tor-Carmen-2026'
alta jlopez   author      "Javier López"  'Aut0r-Javier-2026'
alta mgarcia  contributor "Marta García"  'Col4b-Marta-2026'
alta pnavarro contributor "Pablo Navarro" 'Col4b-Pablo-2026'

echo "== Rol Corrector"
wp role exists corrector || wp role create corrector Corrector >/dev/null
wp cap add corrector read edit_posts edit_others_posts edit_published_posts publish_posts >/dev/null
alta acorrea corrector "Ana Correa" 'C0rrect0r-Ana-2026'
echo "  capacidades: $(wp cap list corrector | tr '\n' ' ')"
wp user list --fields=user_login,display_name,roles

echo "== Comprobación de permisos por la API REST"
wp config set WP_ENVIRONMENT_TYPE local >/dev/null
declare -A AP
for u in mgarcia lmartin jlopez acorrea; do AP[$u]=$(wp user application-password create "$u" "prueba-p32" --porcelain); done
B="$URL/wp-json/wp/v2"
api() {   # descripción usuario esperado curl-args...
  local d="$1" u="$2" esp="$3"; shift 3
  local code; code=$(curl -s -u "$u:${AP[$u]}" -o /tmp/p32.json -w "%{http_code}" "$@")
  local res; res=$(python3 -c "import json;d=json.load(open('/tmp/p32.json'));print(d.get('code') or d.get('status',''))" 2>/dev/null || true)
  local marca="OK"; [ "$code" = "$esp" ] || marca="!!"
  printf '  [%s] %-50s %s %s\n' "$marca" "$d" "$code" "$res"
}
printf 'x' > /tmp/p32.png
api "Colaborador publica directamente"            mgarcia 403 -X POST "$B/posts" -d title="Artículo de Marta" -d status=publish
api "Colaborador envía a revisión"                mgarcia 201 -X POST "$B/posts" -d title="Artículo de Marta" -d status=pending -d content="Texto"
PEND=$(python3 -c "import json;print(json.load(open('/tmp/p32.json'))['id'])")
api "Colaborador sube una imagen"                 mgarcia 403 -X POST "$B/media" -H "Content-Disposition: attachment; filename=p.png" -H "Content-Type: image/png" --data-binary @/tmp/p32.png
api "Editor publica el artículo de Marta"         lmartin 200 -X POST "$B/posts/$PEND" -d status=publish
api "Colaborador edita su artículo ya publicado"  mgarcia 403 -X POST "$B/posts/$PEND" -d title="Cambio"
api "Autor publica su artículo"                   jlopez  201 -X POST "$B/posts" -d title="Artículo de Javier" -d status=publish
PROPIO=$(python3 -c "import json;print(json.load(open('/tmp/p32.json'))['id'])")
api "Autor edita el artículo de Marta"            jlopez  403 -X POST "$B/posts/$PEND" -d title="Cambio de Javier"
api "Corrector edita el artículo del autor"       acorrea 200 -X POST "$B/posts/$PROPIO" -d title="Artículo de Javier (corregido)"
api "(preparación) borrador que pasará a Pablo"  acorrea 201 -X POST "$B/posts" -d title="Artículo de Pablo" -d status=draft
TMP=$(python3 -c "import json;print(json.load(open('/tmp/p32.json'))['id'])")
wp post update "$TMP" --post_author="$(wp user get pnavarro --field=ID)" --post_status=pending >/dev/null
api "Corrector publica el pendiente de Pablo"     acorrea 200 -X POST "$B/posts/$TMP" -d status=publish
api "Corrector borra una entrada"                 acorrea 403 -X DELETE "$B/posts/$PROPIO"
api "Corrector crea una página"                   acorrea 403 -X POST "$B/pages" -d title="Página"
api "Corrector sube una imagen"                   acorrea 403 -X POST "$B/media" -H "Content-Disposition: attachment; filename=p.png" -H "Content-Type: image/png" --data-binary @/tmp/p32.png

echo "== Limpieza de las contraseñas de aplicación y del modo local"
for u in mgarcia lmartin jlopez acorrea; do
  for id in $(wp user application-password list "$u" --field=uuid); do wp user application-password delete "$u" "$id" >/dev/null; done
done
wp config delete WP_ENVIRONMENT_TYPE >/dev/null || true
rm -f /tmp/p32.json /tmp/p32.png
