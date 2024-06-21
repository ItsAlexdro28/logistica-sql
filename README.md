# Base de datos Logistica de transportes



![](https://github.com/Michael-Chacon/ProyectoBaseDeDatosUniversidad/blob/main/img/DER.png?raw=true) 

(placeholder)

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
Descripción: Un administrador desea obtener el historial completo de envíos de un cliente
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