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

