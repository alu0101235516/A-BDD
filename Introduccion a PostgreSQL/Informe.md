# Introducción a PostgreSQL

## Introducción

En esta practica vamos a empezar a manejarnos con los comandos de PostgreSQL, nos centraremos principalmente en la creacion de usuarios en Postgre, entrar a la terminal de comandos Postgre, creación de tablas, etc.

## Instalación de PostgreSQL

```bash
sudo apt install postgresql postgresql-contrib
```

## Creación de Roles

Ahora vamos a cambiar a la cuenta de postgre para entrar al servidor.

```bash
sudo -i -u postgre
```

Una vez dentro del usuario postgre entramos en la linea de comandos:

```bash
psql
```

Para salir de la linea de comandos encribimos:

```bash
postgre@buntu \q
```

Para crear un rol nuevo usamos el siguiente comando:

```bash
postgre@ubuntu createuser --interactive
```

Aparecera el siguiente menu:

```bash
Enter name of role to add: "Nombre"
Shall the new role be a superuser? (y/n) y
```

## Creacion de una base de datos

```bash
postgre@ubuntu createdb "Name"
```

Ahora tenemos que crear un nuevo ususario con el mismo nombre para poder entrar en dicho usuario con psql:

```bash
sudo adduser "Nombre"
```

Entramos a la terminal de comandos de psql con el nuevo rol.

```bash
sudo -u "nombre" psql
```

Una vez dentro de la terminal de comandos, si queremos confirmar que usuario somos y en que base de datos ponemos el siguiente comando:

```bash
"Nombre"=> \conninfo
You are connected to database "nombre" as user "nombre" via socket in "/var/run/postgresql" at port "5432".
```

## Creación de una tabla

Primero, para listar las bases de datos disponibles introducimos el siguiente comando:

```bash
nameSQL=> \l
```

Para crear una tabla usamos el comando CREATE TABLE:

```bash
nameSQL=> CREATE TABLE Personas ( DNI int PRIMARY KEY, nombre varchar (50), edad varchar (25));
```

Para ver la tabla que existe la tabla usamos el comando siguiente:

```sql
nameSQL=> \d
          List of relations
 Schema |   Name   | Type  |  Owner  
--------+----------+-------+---------
 public | personas | table | noahSQL
(1 row)
```

Para insertar filas en la tabla hacemos lo siguiente:

```sql
INSERT INTO personas (dni, nombre, edad) VALUES (12345, 'Noah', 22);
```

Para ver si se ha introducido bien los datos:

```SQL
SELECT * FROM personas;

  dni  | nombre | edad 
-------+--------+------
 12345 | Noah   | 22

(1 row)
```

En caso de que queramos borrar alguna fila realizamos el siguiente comando:

```SQL
DELETE FROM personas WHERE edad > '20';
```

Asi quedaría:

```SQL
 dni | nombre | edad 
-----+--------+------
(0 rows)
```





