<?php
/**
 * Plugin Name: Categorías en páginas
 * Description: Permite asignar categorías a las páginas y hace que los archivos de categoría muestren también las páginas. Alternativa mínima a los plugins del repositorio (P3.4).
 * Version:     1.0
 * Author:      IAW
 * License:     GPL-2.0-or-later
 */

if ( ! defined( 'ABSPATH' ) ) {
    exit;
}

// 1. La taxonomía «category» pasa a estar disponible también para el tipo de contenido «page».
//    Aparece el panel «Categorías» al editar una página y la columna en Páginas.
add_action( 'init', function () {
    register_taxonomy_for_object_type( 'category', 'page' );
} );

// 2. En los archivos de categoría (/category/electronica/...), WordPress solo busca entradas.
//    Se añaden las páginas a esa consulta, solo en la consulta principal de la parte pública.
add_action( 'pre_get_posts', function ( WP_Query $query ) {
    if ( is_admin() || ! $query->is_main_query() || ! $query->is_category() ) {
        return;
    }
    $query->set( 'post_type', array( 'post', 'page' ) );
} );
