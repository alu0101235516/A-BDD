# Practica 5: Creando Base de datos Relacional

En esta practica vamos a implementar la base de datos 'Viveros' en postgreSQL, con el fin de aprender a crear una base de datos relacional, asi como introducir valores en las tablas correspondientes.

## Base de datos: Viveros

La base de datos consta de una serie de tablas:

* Viveros, la cual sera la que almacene los viveros existentes, sus atributos son:
  * **ID_Vivero** (ID del vivero)
  * LAT (Latitud)
  * LON (Longitud)
  * Tam_Vivero (Tamaño del vivero (ZxY))

* Zonas, la cuales conformar un vivero:
  * **ID_Zona** (ID de la zona)
  * Tipo_Zona (Tipo de Zona)
  * Tam_Zona (Tamaño de zona (ZxY))
  * Stock_Prod (Stock de un producto en dicha zona)
  * *VIVEROS_ID_Viveros* (ID del vivero al cual pertenece la zona)

* Producto
  * **ID_Prod** (ID del producto)
  * Stock (Stock que queda del producto)
  * Nombre_Prod (Nombre del producto)
  * *ZONAS_ID_Zona* (Zona en la cual se encuentra el producto)

* Cliente
  * ID_Cliente (ID del cliente)
  * Direccion (Direccion del cliente)

* Empleado
  * **ID_Empleado** (ID del empleado)
  * *ZONAS_ID_Zonas* (Zona en la que esta asignada el empleado)

* Ventas, Empleado Y que vende a cliente X el producto Z en una cierta cantidad en una fecha concreta
  * **EMPLEADOS_ID_Empleado** (Empleado que realiza la venta)
  * **CLIENTES_ID_Cliente** (Cliente que compra)
  * **PRODUCTOS_ID_Prod** (Producto que se compra)
  * Fecha (Fecha en la que se produce la venta)
  * Cantidad (Cantidad de producto que se vende)


![Captura en MySQL Workbench, hacerla el martes]()

Asi quedaria el esquema de la base de datos.

En cuanto al script para crear la base de datos quedaria asi:

```sql
DROP TABLE IF EXISTS VIVEROS ;

CREATE TABLE IF NOT EXISTS VIVEROS (
  ID_Viveros VARCHAR(12) NOT NULL,
  LAT DECIMAL NULL,
  LON DECIMAL NULL,
  Tam_Vivero VARCHAR(9) NULL,
  PRIMARY KEY (ID_Viveros));

DROP TABLE IF EXISTS ZONAS ;

CREATE TABLE IF NOT EXISTS ZONAS (
  ID_Zona VARCHAR(12) NOT NULL,
  Tipo_Zona VARCHAR(10) NOT NULL,
  Tam_Zona VARCHAR(9) NULL,
  Stock_Prod INT NULL,
  VIVEROS_ID_Viveros VARCHAR(12) NOT NULL,
  PRIMARY KEY (ID_Zona),
    FOREIGN KEY (VIVEROS_ID_Viveros)
    REFERENCES VIVEROS (ID_Viveros)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

DROP TABLE IF EXISTS PRODUCTOS ;

CREATE TABLE IF NOT EXISTS PRODUCTOS (
  ID_Prod VARCHAR(12) NOT NULL,
  Stock INT NOT NULL,
  Nombre_Prod VARCHAR(45) NOT NULL,
  ZONAS_ID_Zona VARCHAR(12) NOT NULL,
  PRIMARY KEY (ID_Prod),
    FOREIGN KEY (ZONAS_ID_Zona)
    REFERENCES ZONAS (ID_Zona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

DROP TABLE IF EXISTS CLIENTES ;

CREATE TABLE IF NOT EXISTS CLIENTES (
  ID_Cliente INT NOT NULL,
  Direccion VARCHAR(45) NULL,
  PRIMARY KEY (ID_Cliente));

DROP TABLE IF EXISTS EMPLEADOS ;

CREATE TABLE IF NOT EXISTS EMPLEADOS (
  ID_Empleado INT NOT NULL,
  ZONAS_ID_Zona VARCHAR(12) NOT NULL,
  PRIMARY KEY (ID_Empleado),
  CONSTRAINT fk_EMPLEADOS_ZONAS1
    FOREIGN KEY (ZONAS_ID_Zona)
    REFERENCES ZONAS (ID_Zona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

DROP TABLE IF EXISTS VENTAS ;

CREATE TABLE IF NOT EXISTS VENTAS (
  EMPLEADOS_ID_Empleado INT NOT NULL,
  CLIENTES_ID_Cliente INT NOT NULL,
  PRODUCTOS_ID_Prod VARCHAR(12) NOT NULL,
  Fecha DATE NULL,
  Cantidad VARCHAR(45) NULL,
    FOREIGN KEY (EMPLEADOS_ID_Empleado)
    REFERENCES EMPLEADOS (ID_Empleado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (CLIENTES_ID_Cliente)
    REFERENCES CLIENTES (ID_Cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (PRODUCTOS_ID_Prod)
    REFERENCES PRODUCTOS (ID_Prod)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
```

Una vez creada la base de datos quedaria añadir los datos en las tablas

```sql
INSERT INTO VIVEROS (ID_Viveros, LAT, LON, Tam_Vivero) VALUES ('VIV111', 16.7687, -4.67896, '20x50');
INSERT INTO VIVEROS (ID_Viveros, LAT, LON, Tam_Vivero) VALUES ('VIV222', 18.1224, -11.42312, '30x20');
INSERT INTO VIVEROS (ID_Viveros, LAT, LON, Tam_Vivero) VALUES ('VIV333', 21.5324, -9.43124, '15x50');
INSERT INTO VIVEROS (ID_Viveros, LAT, LON, Tam_Vivero) VALUES ('VIV444', 8.2000, -3.42332, '35x40');

INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z1-111', 'Almacen', '20x25', '1120', 'VIV111');
INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z2-111', 'Exterior', '10x3', NULL, 'VIV111');
INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z3-111', 'Caja', '20x25', NULL, 'VIV111');
INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z1-222', 'Almacen', '10x20', '3230', 'VIV222');
INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z2-222', 'Exterior', '10x3', NULL, 'VIV222');
INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z3-222', 'Caja', '10x20', NULL, 'VIV222');
INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z1-333', 'Almacen', '10x20', '2500', 'VIV333');
INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z2-333', 'Exterior', '10x3', NULL, 'VIV333');
INSERT INTO ZONAS (ID_Zona, Tipo_Zona, Tam_Zona, Stock_Prod, VIVEROS_ID_Viveros) VALUES ('Z3-333', 'Caja', '10x20', NULL, 'VIV333');

INSERT INTO PRODUCTOS (ID_Prod, Stock, Nombre_Prod, ZONAS_ID_Zona) VALUES ('P00001', '320', 'Margaritas', 'Z1-111');
INSERT INTO PRODUCTOS (ID_Prod, Stock, Nombre_Prod, ZONAS_ID_Zona) VALUES ('P00002', '130', 'Rosas Rojas', 'Z1-222');
INSERT INTO PRODUCTOS (ID_Prod, Stock, Nombre_Prod, ZONAS_ID_Zona) VALUES ('P00003', '500', 'Rosas Blancas', 'Z1-333');
INSERT INTO PRODUCTOS (ID_Prod, Stock, Nombre_Prod, ZONAS_ID_Zona) VALUES ('P00004', '650', 'Girasoles', 'Z1-111');
INSERT INTO PRODUCTOS (ID_Prod, Stock, Nombre_Prod, ZONAS_ID_Zona) VALUES ('P00005', '430', 'Camelias', 'Z1-222');
INSERT INTO PRODUCTOS (ID_Prod, Stock, Nombre_Prod, ZONAS_ID_Zona) VALUES ('P00006', '80', 'Tulipanes', 'Z1-333');
```