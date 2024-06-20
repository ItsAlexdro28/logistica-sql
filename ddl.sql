DROP DATABASE IF EXISTS 'logistica';
CREATE DATABASE 'logistica';

USE 'logistica';

CREATE TABLE paises (
    pais_id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_pais PRIMARY KEY (pais_id)
)

