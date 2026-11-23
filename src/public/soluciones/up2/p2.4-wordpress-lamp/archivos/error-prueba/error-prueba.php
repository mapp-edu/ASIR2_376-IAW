<?php
/**
 * Plugin Name: Error de prueba (P2.4)
 * Description: Provoca a propósito un aviso de PHP en cada página para comprobar el registro de depuración. Desactivar y borrar al terminar.
 * Version:     1.0
 * Author:      IAW
 */

if ( ! defined( 'ABSPATH' ) ) {
    exit; // impide ejecutar el archivo llamándolo directamente por URL
}

add_action( 'wp_footer', function () {
    // Error intencionado: la variable $mensaje no existe.
    // PHP 8 genera «Warning: Undefined variable $mensaje».
    echo '<!-- prueba: ' . $mensaje . ' -->';
} );
