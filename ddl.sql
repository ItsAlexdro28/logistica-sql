DROP DATABASE IF EXISTS logistica;
CREATE DATABASE logistica;

USE logistica;

CREATE TABLE paises (
    pais_id INT AUTO_INCREMENT,
    nombre VARCHAR(56),
    CONSTRAINT pk_pais_id_paises PRIMARY KEY (pais_id)
);

CREATE TABLE ciudades (
    ciudad_id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    pais_id INT,
    CONSTRAINT pk_ciudad_id_ciudades PRIMARY KEY (ciudad_id),
    CONSTRAINT fk_ciudad_pais_ciudades FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
);

CREATE TABLE sucursales (
    sucursal_id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    ciudad_id INT,
    CONSTRAINT pk_sucursal_id_sucursales PRIMARY KEY (sucursal_id),
    CONSTRAINT fk_sucursal_ciudad_sucursales FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

CREATE TABLE marcas (
    marca_id INT AUTO_INCREMENT,
    nombre VARCHAR(30),
    CONSTRAINT pk_marca_id_marcas PRIMARY KEY (marca_id)
);

CREATE TABLE tipo_vehiculo (
    tipo_vehiculo_id INT AUTO_INCREMENT,
    marca_id INT,
    modelo VARCHAR(40),
    año_modelo VARCHAR(4),
    descripcion VARCHAR(50),
    CONSTRAINT pk_tipo_vehiculo_id_tipo_vehiculo PRIMARY KEY (tipo_vehiculo_id),
    CONSTRAINT fk_tipo_vehiculo_marca_tipo_vehiculo FOREIGN KEY (marca_id) REFERENCES marcas(marca_id)
);

CREATE TABLE vehiculos (
    vehiculo_id INT AUTO_INCREMENT,
    placa VARCHAR(6),
    tipo_vehiculo_id INT,
    capacidad_carga DECIMAL(10,2),
    sucursal_id INT,
    CONSTRAINT pk_vehiculo_id_vehiculos PRIMARY KEY (vehiculo_id),
    CONSTRAINT fk_vehiculo_tipo_vehiculo_vehiculos FOREIGN KEY (tipo_vehiculo_id) REFERENCES tipo_vehiculo(tipo_vehiculo_id),
    CONSTRAINT fk_vehiculo_sucursal_vehiculos FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE disponibilidad (
    disponibilidad_id INT AUTO_INCREMENT,
    estado BIT,
    CONSTRAINT pk_disponibilidad_id_disponibilidad PRIMARY KEY (disponibilidad_id)
);

CREATE TABLE conductores (
    conductor_id INT AUTO_INCREMENT,
    nombre VARCHAR(60),
    disponibilidad_id INT,
    CONSTRAINT pk_conductor_id_conductores PRIMARY KEY (conductor_id),
    CONSTRAINT fk_conductor_disponibilidad_conductores FOREIGN KEY (disponibilidad_id) REFERENCES disponibilidad(disponibilidad_id)
);

CREATE TABLE telefonos_conductores (
    telefono_id INT AUTO_INCREMENT,
    numero VARCHAR(13),
    conductor_id INT,
    CONSTRAINT pk_telefono_conductor_id_telefonos_conductores PRIMARY KEY (telefono_id),
    CONSTRAINT fk_telefono_conductor_telefonos_conductores FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id)
);

CREATE TABLE rutas (
    ruta_id INT AUTO_INCREMENT,
    descripcion VARCHAR(200),
    sucursal_id INT,
    CONSTRAINT pk_ruta_id_rutas PRIMARY KEY (ruta_id),
    CONSTRAINT fk_ruta_sucursal_rutas FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE conductores_rutas (
    conductor_id INT,
    ruta_id INT,
    vehiculo_id INT,
    CONSTRAINT pk_conductores_rutas_conductores_rutas PRIMARY KEY (conductor_id, ruta_id, vehiculo_id),
    CONSTRAINT fk_conductores_rutas_conductor_conductores_rutas FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id),
    CONSTRAINT fk_conductores_rutas_ruta_conductores_rutas FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    CONSTRAINT fk_conductores_rutas_vehiculo_conductores_rutas FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(vehiculo_id)
);

CREATE TABLE auxiliares (
    auxiliar_id INT AUTO_INCREMENT,
    nombre VARCHAR(200),
    telefono VARCHAR(13),
    CONSTRAINT pk_auxiliar_id_auxiliares PRIMARY KEY (auxiliar_id)
);

CREATE TABLE ruta_auxiliares (
    ruta_id INT,
    auxiliar_id INT,
    CONSTRAINT pk_ruta_auxiliares_ruta_auxiliares PRIMARY KEY (ruta_id, auxiliar_id),
    CONSTRAINT fk_ruta_auxiliares_ruta_ruta_auxiliares FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    CONSTRAINT fk_ruta_auxiliares_auxiliar_ruta_auxiliares FOREIGN KEY (auxiliar_id) REFERENCES auxiliares(auxiliar_id)
);

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    email VARCHAR(60),
    direccion VARCHAR(100),
    CONSTRAINT pk_cliente_id_clientes PRIMARY KEY (cliente_id)
);

CREATE TABLE telefonos_clientes (
    telefono_id INT AUTO_INCREMENT,
    numero VARCHAR(13),
    cliente_id INT,
    CONSTRAINT pk_telefono_cliente_id_telefonos_clientes PRIMARY KEY (telefono_id),
    CONSTRAINT fk_telefono_cliente_telefonos_clientes FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE tipo_servicios (
    servicio_id INT AUTO_INCREMENT,
    nombre VARCHAR(15),
    CONSTRAINT pk_servicio_id_tipo_servicios PRIMARY KEY (servicio_id)
);

CREATE TABLE paquetes (
    paquete_id INT AUTO_INCREMENT,
    numero_seguimiento VARCHAR(50),
    peso DECIMAL(10,2),
    dimensiones VARCHAR(50),
    contenido TINYTEXT,
    valor_declarado DECIMAL(10,2),
    servicio_id INT,
    CONSTRAINT pk_paquete_id_paquetes PRIMARY KEY (paquete_id),
    CONSTRAINT fk_paquete_servicio_paquetes FOREIGN KEY (servicio_id) REFERENCES tipo_servicios(servicio_id)
);

CREATE TABLE envios (
    envio_id INT AUTO_INCREMENT,
    cliente_id INT,
    paquete_id INT,
    fecha_envio TIMESTAMP,
    destino VARCHAR(100),
    ruta_id INT,
    CONSTRAINT pk_envio_id_envios PRIMARY KEY (envio_id),
    CONSTRAINT fk_envio_cliente_envios FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    CONSTRAINT fk_envio_paquete_envios FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
    CONSTRAINT fk_envio_ruta_envios FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id)
);

CREATE TABLE tipo_estados (
    estado_id INT AUTO_INCREMENT,
    tipo_estado VARCHAR(15),
    CONSTRAINT pk_estado_id_tipo_estados PRIMARY KEY (estado_id)
);

CREATE TABLE seguimientos (
    seguimiento_id INT AUTO_INCREMENT,
    paquete_id INT,
    ubicacion VARCHAR(100),
    fecha_hora TIMESTAMP,
    estado_id INT,
    CONSTRAINT pk_seguimiento_id_seguimientos PRIMARY KEY (seguimiento_id),
    CONSTRAINT fk_seguimiento_paquete_seguimientos FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
    CONSTRAINT fk_seguimiento_estado_seguimientos FOREIGN KEY (estado_id) REFERENCES tipo_estado(estado_id)
);

