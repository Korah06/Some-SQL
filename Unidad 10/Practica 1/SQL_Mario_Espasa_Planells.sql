--1

ALTER TABLE categorias ADD COLUMN cantidad INT DEFAULT 0

--2

CREATE OR REPLACE FUNCTION anyadir_cant_producto()
RETURNS TRIGGER AS $$
BEGIN
    
    UPDATE categorias
    SET cantidad = cantidad +1
    WHERE categorias.idCategoria = new.Categoria;   
    RAISE NOTICE 'Un trigger se ha ejecutado al insertar información';
    --RETURN NULL CUANDO EL TRIGGER ES AFTER Y RETURN NEW CUANDO ES BEFORE
    RETURN NULL;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER SumaCantidad AFTER INSERT 
ON Productos
FOR EACH ROW
EXECUTE PROCEDURE anyadir_cant_producto();

--3

CREATE OR REPLACE FUNCTION reducir_cant_producto()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE categorias
    SET cantidad = cantidad -1
    WHERE categorias.idCategoria = old.Categoria;
    RAISE NOTICE 'Un trigger se ha ejecutado al eliminar información';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER RestaCantidad AFTER DELETE 
ON Productos
FOR EACH ROW
EXECUTE PROCEDURE reducir_cant_producto();

--4

CREATE TABLE Empleados(
Dni VARCHAR(9) not null,
Nombre VARCHAR(50),
Apellidos VARCHAR(100),
Fecha_Nacimiento date,
Telefono VARCHAR(15),
Categoria INT,
Primary Key (Dni),
Foreign Key (Categoria) References categorias(idCategoria)
);

ALTER TABLE Categorias ADD num_empleados INT default 0;

--5

--a)


CREATE OR REPLACE FUNCTION insertar_empleado()
RETURNS TRIGGER AS $$
DECLARE
edad int;
BEGIN  
    --edad:= date_part('year', age(new.Fecha_Nacimiento));
    edad:= CAST(TO_CHAR(NOW(),'YYYY') as NUMERIC) - CAST(TO_CHAR(new.Fecha_Nacimiento,'YYYY') as NUMERIC)

    IF edad<25 and new.categoria IS NOT NULL) THEN
    RAISE EXCEPTION 'El empleado de dni % no puede tener asignada una categoria', new.dni;
    END IF;

    IF edad >=25 and new.categoria IS NULL THEN
        RAISE EXCEPTION 'El empleado de dni % debe tener asignada una categoria', new.dni;
    END IF;
    --ES RETURN NEW PORQUE ES BEFORE
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_empleado
BEFORE INSERT ON empleados
FOR EACH ROW
EXECUTE PROCEDURE insertar_empleado();


--b)


CREATE OR REPLACE FUNCTION sumar_empleado()
RETURNS TRIGGER AS $$
DECLARE

BEGIN  
    UPDATE categorias
    SET num_e,pleados = num_empleados +1
    WHERE categorias.idCategoria = new.categorias;
    --ES RETURN NEW PORQUE ES BEFORE
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER sumar_empleado
BEFORE INSERT ON empleados
FOR EACH ROW
EXECUTE PROCEDURE sumar_empleado();