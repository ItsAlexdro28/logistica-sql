# Base de datos Logistica de transportes



![](https://raw.githubusercontent.com/ItsAlexdro28/logistica-sql/master/ERDDiagram.png) 

### Casos de Uso: Registros

###### Remplazar los valores entre llaves {} y eliminarlas


CU1: Registrar un nuevo país

```sql
INSERT INTO paises (nombre) VALUES ('{NombreDelPaís}');
```


CU2: Registrar nueva ciudad
Ps: Utiliza el codigo de el pais que se va a usar en {IdDelPais}

```sql
SELECT pais_id, nombre FROM paises;
INSERT INTO ciudades (nombre, pais_id) VALUES ('{NombreDeLaCiudad}', {IdDelPais});
```

CU3: Registrar nueva sucursal
Ps: Utiliza el codigo de la ciudad que se va a usar en {IdDeLaCiudad}

```sql
SELECT ciudades.ciudad_id, ciudades.nombre, paises.nombre FROM ciudades INNER JOIN paises ON ciudades.pais_id=paises.pais_id;
INSERT INTO sucursales (nombre, direccion, ciudad_id) VALUES ('{NombreDeLaSucursal}', '{DireccionDeLaSucursal}', {IdDeLaCiudad});
```

CU4: Registrar nuevo cliente

```sql
INSERT INTO clientes (nombre, email, direccion) VALUES ('{NombreDelCliente}', '{EmailDelCliente}', '{DireccionDelCliente}');
```

CU5: Registrar nuevo telefono para cliente
Ps: Utiliza el codigo del cliente que se va a usar en {IdDelCliente}

```sql
SELECT cliente_id, nombre, direccion FROM clientes;
INSERT INTO telefonos_clientes (numero, cliente_id) VALUES ('{NumeroDelCliente}', {IdDelCliente});
```

CU6: Registrar nuevo paquete
Ps: Utiliza el codigo del tipo del servicio que se va a usar en {IdDelServicio}

```sql
SELECT servicio_id, nombre FROM tipo_servicios;
INSERT INTO paquetes (peso, dimensiones, contenido, valor_declarado, servicio_id) VALUES ({PesoDelPaquete}, '{DimensionesDelPaquete}', '{ContenidoDelPaquete}', {ValorDeclarado}, {IdDelServicio});
```

CU7: Registrar nuevo envio
Ps: Utiliza el codigo del cliente, el paquete y la ruta que se va a usar en {IdDelCliente}, {IdDelPaquete} y {IdDeLaRuta} respectivamente 
La ruta debe tener el mismo destino que el registrado
```sql
SELECT cliente_id, nombre, direccion FROM clientes;
SELECT paquete_id, contenido, dimensiones, peso FROM paquetes;
SELECT rutas.ruta_id, rutas.descripcion, sucursales.nombre, sucursales.direccion FROM rutas INNER JOIN sucursales ON rutas.sucursal_id=sucursales.sucursal_id;
INSERT INTO envios (cliente_id, paquete_id, fecha_envio, destino, ruta_id) VALUES ({IdDelCliente}, {IdDelPaquete}, '{FechaDelEnvio}', '{Destino}', {IdDelLaruta});
```

CU8: Registrar nuevo vehiculo
Ps: Utiliza el codigo del tipo de vehiculo y sucursal que se va a usar en {IdTipoDeVehiculo}, {IdSucursal} respectivamente 
```sql
SELECT tipo_id, marca_id, modelo, descripcion FROM tipo_vehiculos;
SELECT sucursal_id, nombre, dirrecion FROM sucursales;
INSERT INTO vehiculos (placa, tipo_id, capacidad_carga, sucursal_id) VALUES ('{PlacaVehiculo}', {IdTipoDeVehiculo}, {CapacidadCarga}, {IdSucursal});
```

CU9: Registrar nuevo conductor
Ps: la disponibilidad es 1 para disponible y 2 para no disponible
```sql
INSERT INTO conductores (nombre, disponibilidad_id) VALUES ('{NombreConductor}', {IdDisponibilidad});
```

CU10: Registrar nuevo telefono de conductor
Ps: usar el id del conductor en {IdConductor}
```sql
SELECT conductor_id, nombre FROM conductores;
INSERT INTO telefonos_conductores (nombre, disponibilidad_id) VALUES ('{NombreConductor}', {IdDisponibilidad});
```

CU11: Asignar un conductor a una ruta y un vehiculo
Ps: con bases en las tablas vistas, selecionar el IdConductor, rutaId y vehiculoId
```sql
SELECT ruta_id, descripcion FROM rutas;
SELECT vehiculos.vehiculo_id, vehiculos.placa, tipo_vehiculos.modelo, tipo_vehiculos.descripcion FROM vehiculos INNER JOIN tipo_vehiculos ON vehiculos.tipo_id=tipo_vehiculos.tipo_id;
SELECT conductor_id, nombre FROM conductores;
INSERT INTO conductores_rutas (conductor_id, ruta_id, vehiculo_id) VALUES ({IdConductor}, {IdRuta}, {IdVehículo});
```

CU12: Registrar un nuevo auxiliar
```sql
IINSERT INTO auxiliares (nombre, telefono) VALUES ('{NombreAuxiliar}', '{NúmeroDeTeléfono}');
```      

CU13: Registrar un nuevo auxiliar a una ruta
```sql
SELECT auxiliar_id, nombre, telefono FROM auxiliares;
SELECT rutas.ruta_id, rutas.descripcion, sucursales.nombre, sucursales.direccion FROM rutas INNER JOIN sucursales ON rutas.sucursal_id=sucursales.sucursal_id;
INSERT INTO rutas_auxiliares (ruta_id, auxiliar_id) VALUES ({IdRuta}, {IdAuxiliar});
```      

CU14: Registrar un evento de seguimiento para un paquete 
```sql
SELECT paquete_id, contenido, dimensiones, peso FROM paquetes;
SELECT tipo_id, tipo_estado FROM tipo_estados;
INSERT INTO seguimientos (paquete_id, ubicacion, fecha_hora, estado_id) VALUES ({IdPaquete}, '{Ubicación}', '{FechaYHora}', {IdEstado});
```      

CU15: Generar un reporte de envios por cliente 
```sql
SELECT envios.cliente_id, paquetes.contenido, envios.fecha_envio, envios.destino FROM envios INNER JOIN paquetes ON envios.paquete_id=paquetes.paquete_id WHERE cliente_id = {IdCliente};
```

CU16: Actualizar estado del paquete 
```sql
SELECT paquete_id, contenido, dimensiones, peso FROM paquetes;
SELECT tipo_id, tipo_estado FROM tipo_estados;
UPDATE seguimientos SET estado_id = {IdEstado} WHERE paquete_id = {IdPaquete};
```
CU17: Rastrear ubicacion paquete 
```sql
SELECT tipo_id, tipo_estado FROM tipo_estados;
SELECT ubicacion, fecha_hora FROM seguimientos WHERE paquete_id = {IdPaquete} ORDER BY fecha_hora DESC;
```

### Casos de Uso: Multitabla

CU1: Obtener Información Completa de Envíos
Un administrador desea obtener la información completa de todos los envíos,
incluyendo detalles del cliente, paquete, ruta, conductor, y sucursal.
```sql
SELECT envios.envio_id AS envio, envios.fecha_envio, envios.destino, clientes.nombre, clientes.email, clientes.direccion, paquetes.peso, paquetes.dimensiones, paquetes.contenido, paquetes.valor_declarado, rutas.descripcion, conductores.nombre, sucursales.nombre, sucursales.direccion, ciudades.nombre
FROM envios
JOIN clientes ON envios.cliente_id=clientes.cliente_id
JOIN paquetes ON envios.paquete_id=paquetes.paquete_id
JOIN rutas ON envios.ruta_id=rutas.ruta_id
JOIN conductores_rutas ON rutas.ruta_id=conductores_rutas.ruta_id
JOIN conductores ON conductores_rutas.ruta_id=conductores.conductor_id
JOIN sucursales ON rutas.sucursal_id=sucursales.sucursal_id
JOIN ciudades ON sucursales.ciudad_id=ciudades.ciudad_id
ORDER BY envios.envio_id;
```

CU2: Obtener Historial de Envíos de un Cliente
Un administrador desea obtener el historial completo de envíos de un cliente
específico, incluyendo detalles de los paquetes y los eventos de seguimiento.
```sql
SELECT envios.envio_id AS envio, envios.fecha_envio, envios.destino, paquetes.peso, paquetes.dimensiones, paquetes.contenido, paquetes.valor_declarado, seguimientos.ubicacion, seguimientos.fecha_hora, tipo_estados.tipo_estado  
FROM envios
JOIN clientes ON envios.cliente_id=clientes.cliente_id
JOIN paquetes ON envios.paquete_id=paquetes.paquete_id
JOIN rutas ON envios.ruta_id=rutas.ruta_id
JOIN seguimientos ON paquetes.paquete_id=seguimientos.paquete_id
JOIN tipo_estados ON seguimientos.estado_id=tipo_estados.estado_id
WHERE envios.cliente_id = {IdCliente};
```

CU3: Listar Conductores y sus Rutas Asignadas
Un administrador desea obtener una lista de todos los conductores y las rutas a las
que están asignados, incluyendo detalles del vehículo utilizado y la sucursal correspondiente.
```sql
SELECT 
conductores.nombre AS conductor,
rutas.descripcion AS ruta,
vehiculos.placa AS vehiculo,
tipo_vehiculos.modelo AS modelo_vehiculo,
sucursales.nombre AS sucursal,
ciudades.nombre AS ciudad
FROM conductores
JOIN conductores_rutas ON conductores.conductor_id=conductores_rutas.conductor_id
JOIN rutas ON conductores_rutas.ruta_id=rutas.ruta_id
JOIN vehiculos ON conductores_rutas.vehiculo_id=vehiculos.vehiculo_id
JOIN tipo_vehiculos ON vehiculos.tipo_id=tipo_vehiculos.tipo_id
JOIN sucursales ON rutas.sucursal_id=sucursales.sucursal_id
JOIN ciudades ON sucursales.ciudad_id=ciudades.ciudad_id
ORDER BY conductores.nombre;
```

CU4: Obtener Detalles de Rutas y Auxiliares Asignados
Un administrador desea obtener detalles de todas las rutas, incluyendo los
auxiliares asignados a cada ruta.
```sql
SELECT 
rutas.descripcion AS ruta,
sucursales.nombre AS sucursal,
ciudades.nombre AS ciudad,
auxiliares.nombre AS auxiliar,
auxiliares.telefono AS telefono_auxiliar
FROM rutas
JOIN rutas_auxiliares ON rutas.ruta_id=rutas_auxiliares.ruta_id
JOIN auxiliares ON rutas_auxiliares.auxiliar_id=auxiliares.auxiliar_id
JOIN sucursales ON rutas.sucursal_id=sucursales.sucursal_id
JOIN ciudades ON sucursales.ciudad_id=ciudades.ciudad_id
ORDER BY rutas.descripcion;
```

CU5: Generar Reporte de Paquetes por Sucursal y Estado
Un administrador desea generar un reporte de todos los paquetes agrupados por
sucursal y estado.
```sql
SELECT 
sucursales.nombre AS sucursal,
ciudades.nombre AS ciudad,
tipo_estados.tipo_estado AS estado,
COUNT(paquetes.paquete_id) AS total_paquetes
FROM paquetes
JOIN envios ON paquetes.paquete_id=envios.paquete_id
JOIN rutas ON envios.ruta_id=rutas.ruta_id
JOIN sucursales ON rutas.sucursal_id=sucursales.sucursal_id
JOIN ciudades ON sucursales.ciudad_id=ciudades.ciudad_id
JOIN seguimientos ON paquetes.paquete_id=seguimientos.paquete_id
JOIN tipo_estados ON seguimientos.estado_id=tipo_estados.estado_id
GROUP BY sucursales.nombre, ciudades.nombre, tipo_estados.tipo_estado
ORDER BY sucursales.nombre, tipo_estados.tipo_estado;
```

CU6: Obtener Información Completa de un Paquete y su Historial de Seguimiento
Un administrador desea obtener la información completa de un paquete específico
y su historial de seguimiento.
```sql
SELECT 
paquetes.paquete_id,
paquetes.peso,
paquetes.dimensiones,
paquetes.contenido,
paquetes.valor_declarado,
tipo_servicios.nombre AS tipo_servicio,
seguimientos.ubicacion,
seguimientos.fecha_hora,
tipo_estados.tipo_estado
FROM paquetes
JOIN tipo_servicios ON paquetes.servicio_id=tipo_servicios.servicio_id
JOIN seguimientos ON paquetes.paquete_id=seguimientos.paquete_id
JOIN tipo_estados ON seguimientos.estado_id=tipo_estados.estado_id
WHERE paquetes.paquete_id = {PaqueteId}
ORDER BY seguimientos.fecha_hora;
```

### Casos de Uso: between, in & not in

CU1: Obtener Paquetes Enviados Dentro de un Rango de Fechas
Un administrador desea obtener todos los paquetes que fueron enviados dentro de un rango de fechas específico.
```sql
SELECT 
paquetes.paquete_id,
paquetes.contenido,
paquetes.valor_declarado,
envios.fecha_envio
FROM paquetes
JOIN envios ON paquetes.paquete_id=envios.paquete_id
WHERE envios.fecha_envio BETWEEN '2023-01-01' AND '2023-01-31';
```

CU2: Obtener Paquetes con Ciertos Estados
Un administrador desea obtener todos los paquetes que tienen ciertos estados
específicos (por ejemplo, 'en tránsito' o 'entregado').
```sql
SELECT 
paquetes.paquete_id,
paquetes.contenido,
tipo_estados.tipo_estado
FROM paquetes
JOIN seguimientos ON paquetes.paquete_id=seguimientos.paquete_id
JOIN tipo_estados ON seguimientos.estado_id=tipo_estados.estado_id
WHERE tipo_estados.tipo_estado IN ('en transito', 'entregado');
```

CU3: Obtener Paquetes Excluyendo Ciertos Estados
Un administrador desea obtener todos los paquetes excluyendo aquellos que tienen
ciertos estados específicos (por ejemplo, 'recibido' o 'retenido en aduana').
```sql
SELECT
paquetes.paquete_id,
paquetes.contenido,
tipo_estados.tipo_estado
FROM paquetes
JOIN seguimientos ON paquetes.paquete_id=seguimientos.paquete_id
JOIN tipo_estados ON seguimientos.estado_id=tipo_estados.estado_id
WHERE tipo_estados.tipo_estado NOT IN ('recibido', 'retenido en aduana');
```

CU4: Obtener Clientes con Envíos Realizados Dentro de un Rango de Fechas
Un administrador desea obtener todos los clientes que realizaron envíos dentro de
un rango de fechas específico.
```sql
SELECT 
clientes.cliente_id,
clientes.nombre,
envios.fecha_envio
FROM clientes
JOIN envios ON clientes.cliente_id=envios.cliente_id
WHERE envios.fecha_envio BETWEEN '2024-06-01' AND '2024-06-15';
```

CU5: Obtener Conductores Disponibles que No Están Asignados a Ciertas Rutas
Un administrador desea obtener todos los conductores que no están asignados a
ciertas rutas específicas.
```sql
SELECT 
conductores.conductor_id,
conductores.nombre
FROM conductores
WHERE conductores.conductor_id NOT IN (
    SELECT conductores_rutas.conductor_id
    FROM conductores_rutas
    WHERE conductores_rutas.ruta_id IN (1, 2, 3)
);
```

CU6: Obtener Información de Paquetes con Valor
Declarado Dentro de un Rango Específico
Un administrador desea obtener todos los paquetes cuyo valor declarado está
dentro de un rango específico.
```sql
SELECT 
paquetes.paquete_id,
paquetes.contenido,
paquetes.valor_declarado
FROM paquetes
WHERE paquetes.valor_declarado BETWEEN 100 AND 150;
```

CU7: Obtener Auxiliares Asignados a Rutas Específicas 
Un administrador desea obtener todos los auxiliares de reparto que están
asignados a ciertas rutas específicas.
```sql
SELECT 
auxiliares.auxiliar_id,
auxiliares.nombre
FROM auxiliares
JOIN rutas_auxiliares ON auxiliares.auxiliar_id=rutas_auxiliares.auxiliar_id
WHERE rutas_auxiliares.ruta_id IN (1, 2, 3);
```

CU8: Obtener Envíos a Destinos Excluyendo Ciertas Ciudades
Un administrador desea obtener todos los envíos cuyos destinos no están en ciertas
ciudades específicas.
```sql
SELECT 
envios.envio_id,
envios.paquete_id,
sucursales.ciudad_id
FROM envios
JOIN rutas ON envios.ruta_id = rutas.ruta_id
JOIN conductores_rutas ON rutas.ruta_id=conductores_rutas.ruta_id
JOIN vehiculos ON conductores_rutas.vehiculo_id=vehiculos.vehiculo_id
JOIN sucursales ON vehiculos.sucursal_id = sucursales.sucursal_id
JOIN ciudades ON sucursales.ciudad_id=ciudades.ciudad_id
WHERE ciudades.nombre NOT IN ('Bogota', 'Cusco');
```

CU9: Obtener Seguimientos de Paquetes en un Rango de Fechas
Un administrador desea obtener todos los eventos de seguimiento de paquetes que
ocurrieron dentro de un rango de fechas específico.
```sql
SELECT 
seguimientos.seguimiento_id,
seguimientos.paquete_id,
seguimientos.ubicacion,
seguimientos.fecha_hora
FROM seguimientos
WHERE seguimientos.fecha_hora BETWEEN '2024-06-20' AND '2024-06-30';
```

CU10: Obtener Clientes que Tienen Ciertos Tipos de Paquetes
Un administrador desea obtener todos los clientes que tienen paquetes de ciertos
tipos específicos (por ejemplo, 'nacional' o 'internacional').
```sql
SELECT 
clientes.cliente_id,
clientes.nombre,
tipo_servicios.nombre AS tipo_servicio
FROM clientes
JOIN envios ON clientes.cliente_id = envios.cliente_id
JOIN paquetes ON envios.paquete_id = paquetes.paquete_id
JOIN tipo_servicios ON paquetes.servicio_id = tipo_servicios.servicio_id
WHERE tipo_servicios.nombre IN ('nacional', 'internacional');
```