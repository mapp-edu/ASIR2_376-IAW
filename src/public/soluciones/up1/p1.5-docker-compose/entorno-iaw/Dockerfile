# Imagen del servicio web: la oficial de PHP con Apache, más lo que le falta.
FROM php:8.3-apache

# La imagen oficial no trae el controlador de MySQL/MariaDB para PDO.
RUN docker-php-ext-install pdo_mysql

# PHP no usa la variable TZ del sistema: usa date.timezone (si no, UTC).
# Este ini toma su valor de la variable TZ al arrancar el contenedor.
RUN echo 'date.timezone = ${TZ}' > /usr/local/etc/php/conf.d/zz-zona-horaria.ini
