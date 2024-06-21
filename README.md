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
SELECT * FROM paises;
INSERT INTO ciudades (nombre, pais_id) VALUES ('{NombreDeLaCiudad}', {IdDelPais});
```

CU3: Registrar nueva sucursal
Ps: Utiliza el codigo de la ciudad que se va a usar en {IdDeLaCiudad}

```sql
SELECT * FROM ciudades;
INSERT INTO sucursales (nombre, direccion, ciudad_id) VALUES ('{NombreDeLaSucursal}', '{DireccionDeLaSucursal}', {IdDeLaCiudad});
```

CU4: Registrar nuevo cliente

```sql
INSERT INTO clientes (nombre, email, direccion) VALUES ('{NombreDelCliente}', '{EmailDelCliente}', '{DireccionDelCliente}');
```

CU5: Registrar nuevo telefono para cliente
Ps: Utiliza el codigo del cliente que se va a usar en {IdDelCliente}

```sql
SELECT * FROM clientes;
INSERT INTO telefonos_clientes (numero, cliente_id) VALUES ('{NumeroDelCliente}', {IdDelCliente});
```

CU6: Registrar nuevo paquete
Ps: Utiliza el codigo del tipo del servicio que se va a usar en {IdDelServicio}
Es preferible crear el seguimiento antes para usar el numero generado

```sql
SELECT * FROM tipo_servicios;
INSERT INTO paquetes (numero_seguimiento, peso, dimensiones, contenido, valor_declarado, servicio_id) VALUES ('{NumeroDeSeguimiento}', {PesoDelPaquete}, '{DimensionesDelPaquete}', '{ContenidoDelPaquete}', {ValorDeclarado}, {IdDelServicio});
```

CU7: Registrar nuevo envio
Ps: Utiliza el codigo del cliente, el paquete y la ruta que se va a usar en {IdDelCliente}, {IdDelPaquete} y {IdDeLaRuta} respectivamente 
La ruta debe tener el mismo destino que el registrado
```sql
SELECT * FROM clientes;
SELECT * FROM paquetes;
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

CU9: Registrar nuevo telefono de conductor
Ps: usar el id del conductor en {IdConductor}
```sql
SELECT conductor_id, nombre FROM conductores;
INSERT INTO telefonos_conductores (nombre, disponibilidad_id) VALUES ('{NombreConductor}', {IdDisponibilidad});
```


