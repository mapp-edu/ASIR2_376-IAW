<?php
// Fragmentos de wp-config.php de la P2.4 (no es un archivo completo).
// 1) Sustituir la línea existente  define( 'WP_DEBUG', false );  por:

define( 'WP_DEBUG', true );                                          // activa la depuración
define( 'WP_DEBUG_LOG', '/var/log/wordpress/wp-intranet-debug.log' ); // registro fuera de la carpeta pública
define( 'WP_DEBUG_DISPLAY', false );                                 // no muestra errores en la página
@ini_set( 'display_errors', 0 );

// 2) Añadir después de  /* Add any custom values between this line and the "stop editing" line. */

define( 'DISALLOW_FILE_EDIT', true );   // sin editor de archivos de temas y plugins en el panel
define( 'WP_POST_REVISIONS', 5 );       // máximo 5 revisiones por contenido

// 3) Al terminar la prueba del paso 9:
// define( 'WP_DEBUG', false );
