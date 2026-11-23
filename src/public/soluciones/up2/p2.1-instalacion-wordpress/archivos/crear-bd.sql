-- P2.1 — Base de datos y usuario de WordPress (phpMyAdmin → pestaña SQL, conectado como root).
-- Sustituir «ana» por el nombre del alumno o alumna.

CREATE DATABASE bd_ana CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Solo desde el propio equipo y solo con permisos sobre su base de datos
CREATE USER 'bdUser_ana'@'localhost' IDENTIFIED BY 'bdPass_ana';
GRANT ALL PRIVILEGES ON bd_ana.* TO 'bdUser_ana'@'localhost';

SHOW GRANTS FOR 'bdUser_ana'@'localhost';
