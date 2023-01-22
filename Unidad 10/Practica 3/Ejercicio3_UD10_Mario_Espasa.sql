--1

CREATE OR REPLACE FUNCTION modificar_sueldo()
RETURNS TRIGGER AS $$
DECLARE

BEGIN

    IF(NEW.sou > OLD.sou) THEN
        RAISE INFO 'Se ha modificado el sueldo';
    ELSE
        RAISE EXCEPTION 'El sueldo no puede ser menor al actual';
    END IF;
    

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER m_sueldo BEFORE UPDATE
OF sou ON EMPLEATS
FOR EACH ROW
EXECUTE PROCEDURE modificar_sueldo();


--2

ALTER TABLE PROJECTES ADD COLUMN estado VARCHAR(20) CHECK (estado IN('Inicial', 'Proceso', 'Prueba','Finalizado')) DEFAULT 'Inicial';

--3

	CREATE OR REPLACE FUNCTION fin_proj()
RETURNS TRIGGER AS $$
DECLARE

BEGIN

    IF(OLD.estado like 'Finalizado') THEN
        RAISE INFO 'Se ha eliminado correctamente';
    ELSE
        RAISE EXCEPTION 'No se puede eliminar un `projecto que no este finalizado';
    END IF;
    

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER fin_project BEFORE DELETE
ON PROJECTES
FOR EACH ROW
EXECUTE PROCEDURE fin_proj();













