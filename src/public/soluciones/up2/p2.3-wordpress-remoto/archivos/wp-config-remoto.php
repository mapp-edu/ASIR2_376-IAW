<?php
// P2.3 — Fragmento para wp-config.php del sitio remoto (no es un archivo completo).
// Va ANTES de la línea:  /* That's all, stop editing! Happy publishing. */

// Impide editar el código de temas y plugins desde el panel
define( 'DISALLOW_FILE_EDIT', true );

// El panel de administración solo funciona por HTTPS (activar cuando el certificado esté instalado)
define( 'FORCE_SSL_ADMIN', true );

// Si al pasar a HTTPS el sitio entra en un bucle de redirecciones, fijar aquí las direcciones:
// define( 'WP_HOME',    'https://iaw-ana.ejemplo-hosting.com' );
// define( 'WP_SITEURL', 'https://iaw-ana.ejemplo-hosting.com' );
