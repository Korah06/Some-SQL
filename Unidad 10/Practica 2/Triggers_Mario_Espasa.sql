--1

--Before insert

CREATE OR REPLACE FUNCTION comprobar_dept()
	RETURNS TRIGGER AS $$
	BEGIN
	IF ((SELECT COUNT(*) FROM departaments)>20) THEN
		RAISE EXCEPTION 'No pueden crearse nuevos departamentos, debido a que se excede el numero de los mismos';
    ELSE
        RAISE INFO 'Un trigger se ha ejecutado al insertar información';
	END IF;
	
	RETURN NEW;
	
	END;
$$ LANGUAGE plpgsql;
		
CREATE TRIGGER trigDept BEFORE INSERT 
ON departaments
FOR EACH ROW
EXECUTE PROCEDURE comprobar_dept();

--2

CREATE OR REPLACE FUNCTION cant_proj()
RETURNS TRIGGER AS $$
DECLARE

BEGIN

    IF  ((SELECT COUNT(*) FROM PROJECTES WHERE codi_cli = NEW.codi_cli)>=5)  THEN
        
        RAISE EXCEPTION 'Se excede el número máximo de datos';
    ELSE
        RAISE INFO 'Un trigger se ha ejecutado al insertar información';
    END IF;
    --RETURN NULL CUANDO EL TRIGGER ES AFTER Y RETURN NEW CUANDO ES BEFORE
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Cantidadproj BEFORE INSERT 
ON PROJECTES
FOR EACH ROW
EXECUTE PROCEDURE cant_proj();

--3


CREATE OR REPLACE FUNCTION precio_proj()
RETURNS TRIGGER AS $$
DECLARE

sueldos INT DEFAULT 0;
precio INT DEFAULT 0;

BEGIN

    sueldos := (SELECT SUM(sou) FROM EMPLEATS WHERE codi_proj = NEW.codi_proj) + NEW.sou;
    precio:= (SELECT preu FROM PROJECTES WHERE codi_proj = NEW.codi_proj);
    
	IF sueldos IS NULL THEN 
		IF (NEW.sou > precio)THEN
        
        	RAISE EXCEPTION 'El precio del projecto es muy bajo';
    	ELSE
        	RAISE INFO 'Un trigger se ha ejecutado al insertar información';
    	END IF;
	ELSE

    	IF  (sueldos>precio)  THEN
        
        	RAISE EXCEPTION 'El precio del projecto es muy bajo';
    	ELSE
        	RAISE INFO 'Un trigger se ha ejecutado al insertar información';
    	END IF;
	END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER pr_proj BEFORE INSERT 
ON EMPLEATS
FOR EACH ROW
EXECUTE PROCEDURE precio_proj();

--4

ALTER TABLE PROJECTES ADD COLUMN coste NUMERIC(12,2) DEFAULT 0;

CREATE OR REPLACE FUNCTION coste_proj()
RETURNS TRIGGER AS $$
DECLARE

BEGIN

    UPDATE PROJECTES
    SET coste = coste + NEW.sou
    WHERE codi_proj = NEW.codi_proj;
    RAISE NOTICE 'Un trigger se ha ejecutado tras actualizar información';
    RETURN NULL;
    

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER cost_proj AFTER INSERT 
ON EMPLEATS
FOR EACH ROW
EXECUTE PROCEDURE coste_proj();

--5

ALTER TABLE PROJECTES ADD COLUMN n_empleats INT DEFAULT 0;

CREATE OR REPLACE FUNCTION anyadir_emp()
RETURNS TRIGGER AS $$
DECLARE

BEGIN

    UPDATE PROJECTES
    SET n_empleats = n_empleats + 1
    WHERE codi_proj = NEW.codi_proj;
    RAISE NOTICE 'Un trigger se ha ejecutado tras actualizar información';
    RETURN NULL;
    

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER a_emp AFTER INSERT 
ON EMPLEATS
FOR EACH ROW
EXECUTE PROCEDURE anyadir_emp();

CREATE OR REPLACE FUNCTION eliminar_emp()
RETURNS TRIGGER AS $$
DECLARE

BEGIN

    UPDATE PROJECTES
    SET n_empleats = n_empleats - 1
    WHERE codi_proj = OLD.codi_proj;
    RAISE NOTICE 'Un trigger se ha ejecutado tras actualizar información';
    RETURN NULL;
    

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER e_emp AFTER DELETE
ON EMPLEATS
FOR EACH ROW
EXECUTE PROCEDURE eliminar_emp();

/* //BIEN HECHO:


ALTER TABLE Projectes
ADD COLUMN n_empleats int DEFAULT 0;

CREATE OR REPLACE FUNCTION actualizar_n_empleados()
	RETURNS TRIGGER AS $$
	BEGIN
		IF (TG_OP = 'DELETE') THEN
			UPDATE Projectes
			SET n_empleats = n_empleats - 1
			WHERE codi_proj = old.codi_proj;
		ELSIF (TG_OP = 'UPDATE')THEN
			UPDATE Projectes
			SET n_empleats = n_empleats - 1
			WHERE codi_proj = old.codi_proj;
			
			UPDATE Projectes
			SET n_empleats = n_empleats + 1
			WHERE codi_proj = new.codi_proj;
		ELSIF (TG_OP = 'INSERT') THEN
			UPDATE Projectes
			SET n_empleats = n_empleats + 1
			WHERE codi_proj = new.codi_proj;
		END IF;
		RETURN NULL;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cambio_empleado
AFTER INSERT OR DELETE OR UPDATE ON Empleats
FOR EACH ROW
EXECUTE PROCEDURE actualizar_n_empleados();*/