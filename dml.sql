USE logistica;

-- -> tabla paises
INSERT INTO paises VALUES (1, 'Colombia');
INSERT INTO paises VALUES (2, 'Argentina');
INSERT INTO paises VALUES (3, 'Chile');
INSERT INTO paises VALUES (4, 'Perú');
INSERT INTO paises VALUES (5, 'Brasil');

-- -> tabla ciudades
INSERT INTO ciudades VALUES (1, 'Bogotá', 1);
INSERT INTO ciudades VALUES (2, 'Medellín', 1);
INSERT INTO ciudades VALUES (3, 'Bucaramanga', 1);
INSERT INTO ciudades VALUES (4, 'Buenos Aires', 2);
INSERT INTO ciudades VALUES (5, 'Córdoba', 2);
INSERT INTO ciudades VALUES (6, 'Santiago', 3);
INSERT INTO ciudades VALUES (7, 'Valparaíso', 3);
INSERT INTO ciudades VALUES (8, 'Lima', 4);
INSERT INTO ciudades VALUES (9, 'Cusco', 4);
INSERT INTO ciudades VALUES (10, 'São Paulo', 5);
INSERT INTO ciudades VALUES (11, 'Rio de Janeiro', 5);

-- -> tabla sucursales
INSERT INTO sucursales VALUES (1, 'Sucursal Bogotá Centro', 'Calle 123 #45-67', 1);
INSERT INTO sucursales VALUES (2, 'Sucursal Medellín Norte', 'Carrera 10 #20-30', 2);
INSERT INTO sucursales VALUES (3, 'Sucursal Bucaramanga UIS', 'Cra. 24 #7-48', 3);
INSERT INTO sucursales VALUES (4, 'Sucursal Buenos Aires Centro', 'Avenida 9 de Julio 1234', 4);
INSERT INTO sucursales VALUES (5, 'Sucursal Córdoba Este', 'Calle San Martín 567', 5);
INSERT INTO sucursales VALUES (6, 'Sucursal Santiago Oeste', 'Calle 10 #20-30', 6);
INSERT INTO sucursales VALUES (7, 'Sucursal Valparaíso Norte', 'Avenida del Mar 456', 7);
INSERT INTO sucursales VALUES (8, 'Sucursal Lima Centro', 'Jirón de la Unión 789', 8);
INSERT INTO sucursales VALUES (9, 'Sucursal Cusco Sur', 'Avenida Sol 1011', 9);
INSERT INTO sucursales VALUES (10, 'Sucursal São Paulo Centro', 'Rua Augusta 1234', 10);
INSERT INTO sucursales VALUES (11, 'Sucursal Rio de Janeiro Norte', 'Avenida Atlantica 567', 11);

-- -> tabla marcas
INSERT INTO marcas VALUES (1, 'Toyota');
INSERT INTO marcas VALUES (2, 'Ford');
INSERT INTO marcas VALUES (3, 'Mercedes-Benz');
INSERT INTO marcas VALUES (4, 'Chevrolet');
INSERT INTO marcas VALUES (5, 'Hyundai');

-- -> tabla tipo_vehiculos
INSERT INTO tipo_vehiculos VALUES (1, 1, 'Hilux', '2020', 'Vehículo de carga mediana');
INSERT INTO tipo_vehiculos VALUES (2, 2, 'F-150', '2021', 'Vehículo de carga grande');
INSERT INTO tipo_vehiculos VALUES (3, 3, 'Sprinter', '2019', 'Furgoneta de carga');
INSERT INTO tipo_vehiculos VALUES (4, 4, 'D-Max', '2022', 'Vehículo de carga liviana');
INSERT INTO tipo_vehiculos VALUES (5, 5, 'Santa Fe', '2018', 'SUV para transporte de personas');

-- -> tabla vehiculos
INSERT INTO vehiculos VALUES (1, 'ABC123', 1, 1000.00, 1);
INSERT INTO vehiculos VALUES (2, 'DEF456', 2, 2000.00, 2);
INSERT INTO vehiculos VALUES (3, 'GHI789', 3, 1500.00, 3);
INSERT INTO vehiculos VALUES (4, 'JKL012', 4, 1200.00, 4);
INSERT INTO vehiculos VALUES (5, 'MNO345', 5, 800.00, 5);

-- -> tabla disponibilidad
INSERT INTO disponibilidad VALUES (1, 1);
INSERT INTO disponibilidad VALUES (2, 0);

-- -> tabla conductores
INSERT INTO conductores VALUES (1, 'Carlos Pérez', 1);
INSERT INTO conductores VALUES (2, 'Ana Gómez', 2);
INSERT INTO conductores VALUES (3, 'Luis Martínez', 1);
INSERT INTO conductores VALUES (4, 'Marta López', 2);
INSERT INTO conductores VALUES (5, 'Juan Rodríguez', 1);

-- -> tabla telefonos_conductores
INSERT INTO telefonos_conductores VALUES (1, '3001234567', 1);
INSERT INTO telefonos_conductores VALUES (2, '3101234567', 2);
INSERT INTO telefonos_conductores VALUES (3, '3201234567', 3);
INSERT INTO telefonos_conductores VALUES (4, '3301234567', 4);
INSERT INTO telefonos_conductores VALUES (5, '3401234567', 5);

-- -> tabla rutas
INSERT INTO rutas VALUES (1, 'Ruta Bogotá-Medellín', 1);
INSERT INTO rutas VALUES (2, 'Ruta Buenos Aires-Córdoba', 4);
INSERT INTO rutas VALUES (3, 'Ruta Lima-Cusco', 8);
INSERT INTO rutas VALUES (4, 'Ruta Santiago-Valparaíso', 6);
INSERT INTO rutas VALUES (5, 'Ruta São Paulo-Rio de Janeiro', 10);

-- -> tabla conductores_rutas
INSERT INTO conductores_rutas VALUES (1, 1, 1);
INSERT INTO conductores_rutas VALUES (2, 2, 2);
INSERT INTO conductores_rutas VALUES (3, 3, 3);
INSERT INTO conductores_rutas VALUES (4, 4, 4);
INSERT INTO conductores_rutas VALUES (5, 5, 5);

-- -> tabla auxiliares
INSERT INTO auxiliares VALUES (1, 'Pedro Sánchez', '3009876543');
INSERT INTO auxiliares VALUES (2, 'María Ramírez', '3109876543');
INSERT INTO auxiliares VALUES (3, 'José Fernández', '3209876543');
INSERT INTO auxiliares VALUES (4, 'Laura Ortega', '3309876543');
INSERT INTO auxiliares VALUES (5, 'Raúl Castillo', '3409876543');

-- -> tabla rutas_auxiliares
INSERT INTO rutas_auxiliares VALUES (1, 1);
INSERT INTO rutas_auxiliares VALUES (2, 2);
INSERT INTO rutas_auxiliares VALUES (3, 3);
INSERT INTO rutas_auxiliares VALUES (4, 4);
INSERT INTO rutas_auxiliares VALUES (5, 5);

-- -> tabla clientes
INSERT INTO clientes VALUES (1, 'Cliente 1', 'cliente1@mail.com', 'Dirección 1');
INSERT INTO clientes VALUES (2, 'Cliente 2', 'cliente2@mail.com', 'Dirección 2');
INSERT INTO clientes VALUES (3, 'Cliente 3', 'cliente3@mail.com', 'Dirección 3');
INSERT INTO clientes VALUES (4, 'Cliente 4', 'cliente4@mail.com', 'Dirección 4');
INSERT INTO clientes VALUES (5, 'Cliente 5', 'cliente5@mail.com', 'Dirección 5');

-- -> tabla telefonos_clientes
INSERT INTO telefonos_clientes VALUES (1, '3004567890', 1);
INSERT INTO telefonos_clientes VALUES (2, '3104567890', 2);
INSERT INTO telefonos_clientes VALUES (3, '3204567890', 3);
INSERT INTO telefonos_clientes VALUES (4, '3304567890', 4);
INSERT INTO telefonos_clientes VALUES (5, '3404567890', 5);

-- -> tabla tipo_servicios
INSERT INTO tipo_servicios VALUES (1, 'nacional');
INSERT INTO tipo_servicios VALUES (2, 'internacional');
INSERT INTO tipo_servicios VALUES (3, 'exprés');
INSERT INTO tipo_servicios VALUES (4, 'estándar');

-- -> tabla paquetes
INSERT INTO paquetes VALUES (1, 'NS123456789', 10.50, '30x30x30', 'Ropa', 100.00, 1);
INSERT INTO paquetes VALUES (2, 'NS987654321', 20.00, '40x40x40', 'Electrónicos', 200.00, 2);
INSERT INTO paquetes VALUES (3, 'NS456789123', 15.75, '35x35x35', 'Libros', 150.00, 3);
INSERT INTO paquetes VALUES (4, 'NS654321987', 5.20, '25x25x25', 'Juguetes', 50.00, 4);
INSERT INTO paquetes VALUES (5, 'NS789123456', 12.30, '32x32x32', 'Zapatos', 120.00, 1);

-- -> tabla envios
INSERT INTO envios VALUES (1, 1, 1, '2024-06-20 10:00:00', 'Medellín', 1);
INSERT INTO envios VALUES (2, 2, 2, '2024-06-20 11:00:00', 'Córdoba', 2);
INSERT INTO envios VALUES (3, 3, 3, '2024-06-20 12:00:00', 'Cusco', 3);
INSERT INTO envios VALUES (4, 4, 4, '2024-06-20 13:00:00', 'Valparaíso', 4);
INSERT INTO envios VALUES (5, 5, 5, '2024-06-20 14:00:00', 'Rio de Janeiro', 5);

-- -> tabla tipo_estados
INSERT INTO tipo_estados VALUES (1, 'recibido');
INSERT INTO tipo_estados VALUES (2, 'en tránsito');
INSERT INTO tipo_estados VALUES (3, 'entregado');
INSERT INTO tipo_estados VALUES (4, 'retenido en aduana');

-- -> tabla seguimientos
INSERT INTO seguimientos VALUES (1, 1, 'Bogotá', '2024-06-20 15:00:00', 1);
INSERT INTO seguimientos VALUES (2, 2, 'Buenos Aires', '2024-06-20 16:00:00', 2);
INSERT INTO seguimientos VALUES (3, 3, 'Lima', '2024-06-20 17:00:00', 3);
INSERT INTO seguimientos VALUES (4, 4, 'Santiago', '2024-06-20 18:00:00', 4);
INSERT INTO seguimientos VALUES (5, 5, 'São Paulo', '2024-06-20 19:00:00', 1);
