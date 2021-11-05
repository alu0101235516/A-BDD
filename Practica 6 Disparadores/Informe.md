# Practica 6: Disparadores

En esta practica vamos a crear una serie de disparadores o triggers para mejorar nuesta base de datos.

## Trigger 1: Creacion de Email de cliente

Antes de empezar con este trigger, era importante añadir este atributo a la tabla. Ademas decidimos añadir tambien los atributos Nombre y Apellido, para poder asi, crear el email del cliente que se creaba por defecto.

Para añadir los atributos utilizamos estos comando:

```sql
ALTER TABLE CLIENTES ADD NOMBRE VARCHAR(15);
ALTER TABLE CLIENTES ADD APELLIDO VARCHAR(15);
ALTER TABLE CLIENTES ADD EMAIL VARCHAR(50);
```

Una vez añadida las columnas empezamos a crear los triggers:

El primer trigger hace lo siguiente, antes de insertar un nuevo cliente en la base de datos, esta, tienen que comprobar si se ha añadido un email al mismo. En caso de que se añada un email, este va a la base de datos directamente. En caso contrario, si el dato es NULL, el trigger tiene que actuar, creando uno por defecto, el cual estara hecho con el nombre concatenado con el apellido del cliente, junto con el dominio @gmail.com.

```sql
CREATE OR REPLACE FUNCTION crear_email() RETURNS TRIGGER AS $example_table$
   BEGIN
    IF NEW.email IS NULL THEN
      NEW.email := NEW.Nombre + NEW.Apellido + '@' + TG_ARGV[0];
      END IF;
   END;
$example_table$ LANGUAGE plpgsql;

CREATE TRIGGER email_trigger BEFORE INSERT ON CLIENTES
FOR EACH ROW EXECUTE PROCEDURE crear_email('gmail.com');
```

## Trigger 2: Solo una vivienda