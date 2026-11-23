-- 01-crear-bd-usuario.sql — se ejecuta como administrador:  sudo mariadb < 01-crear-bd-usuario.sql
-- Crea la base de datos de la intranet y su usuario con permisos mínimos.

CREATE DATABASE intranet
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- 'localhost': solo puede conectarse desde el propio servidor
CREATE USER 'intranet_user'@'localhost' IDENTIFIED BY 'CAMBIAR-por-una-clave-larga';

-- Todos los permisos, pero solo sobre las tablas de «intranet»
GRANT ALL PRIVILEGES ON intranet.* TO 'intranet_user'@'localhost';

SHOW GRANTS FOR 'intranet_user'@'localhost';
