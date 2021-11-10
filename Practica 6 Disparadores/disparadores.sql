ALTER TABLE CLIENTES ADD NOMBRE VARCHAR(15);
ALTER TABLE CLIENTES ADD APELLIDO VARCHAR(15);
ALTER TABLE CLIENTES ADD EMAIL VARCHAR(50);
ALTER TABLE CLIENTES ADD MUNICIPIO VARCHAR(15);

/* Trigger1 */

CREATE OR REPLACE FUNCTION crear_email() RETURNS TRIGGER AS $example_table$
   BEGIN
    IF NEW.email IS NULL THEN
      NEW.email := CONCAT(NEW.Nombre, NEW.Apellido, '@', TG_ARGV[0]);
    ELSIF (NEW.email not like '%@gmail.com') THEN
      RAISE EXCEPTION 'El correo no es valido';
    END IF;
   RETURN NEW;
   END
$example_table$ LANGUAGE plpgsql;

CREATE TRIGGER email_trigger BEFORE INSERT ON CLIENTES
FOR EACH ROW EXECUTE PROCEDURE crear_email('gmail.com');

/* Trigger2 */

CREATE OR REPLACE FUNCTION check_vivienda() RETURNS TRIGGER AS $example_table$
          BEGIN
                      IF EXISTS (SELECT * FROM CLIENTES
                                         WHERE Nombre = NEW.Nombre
                                          AND Apellido = NEW.Apellido 
                                          AND Municipio = NEW.Municipio
                                          AND Direccion != NEW.Direccion) THEN                                            
                          RAISE EXCEPTION 'El cliente ya reside en el mismo municipio';
                     END IF;
         RETURN NEW;
         END
$example_table$ LANGUAGE plpgsql;

CREATE TRIGGER checkVivienda BEFORE INSERT ON CLIENTES
FOR EACH ROW EXECUTE PROCEDURE check_vivienda();

/* Trigger3 */

CREATE OR REPLACE FUNCTION updateStock() RETURNS TRIGGER AS $updateStock$
  BEGIN
    IF EXISTS (SELECT * FROM Productos WHERE ((Productos.ID_Prod = NEW.PRODUCTOS_ID_Prod) AND (Productos.Stock >= NEW.Cantidad))) THEN
      UPDATE Productos SET Stock = (Productos.Stock - NEW.Cantidad) WHERE ((Productos.ID_Prod = NEW.PRODUCTOS_ID_Prod) AND (Productos.Stock >= NEW.Cantidad));
    END IF;
    RETURN NEW;
  END;
$updateStock$ LANGUAGE plpgsql;

CREATE TRIGGER nuevoStock BEFORE INSERT ON VENTAS
FOR EACH ROW EXECUTE PROCEDURE updateStock();

ALTER TABLE ZONAS DROP COLUMN Stock_Prod;