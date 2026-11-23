-- 02-avisos.sql — se ejecuta con el usuario de la aplicación:
--   mariadb --default-character-set=utf8mb4 -u intranet_user -p intranet < 02-avisos.sql

SET NAMES utf8mb4;   -- el cliente envía UTF-8 aunque el terminal no esté configurado

CREATE TABLE avisos (
    id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    fecha  DATE         NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO avisos (titulo, fecha) VALUES
    ('Corte de luz programado el viernes', '2026-11-06'),
    ('Nueva versión de la intranet',       '2026-11-10');

SELECT * FROM avisos;
