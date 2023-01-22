
--VISTAS

--Vista en la que muestra los datos generales de los pilotos sin datos privados de los mismos, sería una vista enfocada para personal diferente al gestor de la base de datos
CREATE OR REPLACE VIEW g_pilotos
AS 
SELECT CONCAT(nombre, ', ' ,apellido) AS nombre, apodo, numero
FROM pilotos;

--Vista en la que se muestra el nombre de los pilotos junto a sus respectivas sanciones

CREATE OR REPLACE VIEW faltas_pilotos
AS 
SELECT CONCAT(nombre, ', ' ,apellido) AS nombre, sancion.descripcion AS accion ,sancion.sancion AS penalizacion
FROM pilotos, sancion, sancionar_pilotos
WHERE sancion.id = sancionar_pilotos.id
AND pilotos.dni = sancionar_pilotos.dni;


--FUNCIONES
--Funcion que indica la diferencia de sueldo entre los 2 pilotos
CREATE OR REPLACE FUNCTION diferencia_sueldo()
    RETURNS void AS $$
    DECLARE
		
		
        rec_pil RECORD;
		
		sueldoCarlos FLOAT DEFAULT 0;
		sueldoCharles FLOAT DEFAULT 0;
		diferencia FLOAT DEFAULT 0;
		cur_piloto CURSOR FOR SELECT * FROM pilotos;
		
    BEGIN
	
		OPEN cur_piloto;
	
	LOOP
	
		FETCH cur_piloto INTO rec_pil;
	    EXIT WHEN NOT FOUND;
		
		if(rec_pil.nombre = 'Carlos') THEN
			sueldoCarlos = rec_pil.sueldo;
		END IF;
		
		if(rec_pil.nombre = 'Charles') THEN
			sueldoCharles = rec_pil.sueldo;
		END IF;
	
	END LOOP;
	
		CLOSE cur_piloto;
	
	diferencia := sueldoCharles - sueldoCarlos;
	
	if(diferencia < 0) THEN
	diferencia := diferencia * -1;
	END IF;
	
	IF(sueldoCharles > sueldoCarlos) THEN
		RAISE INFO'Tienen una diferencia de % euros, el piloto que mas cobra es Charles' , diferencia;
	ELSIF (sueldoCharles < sueldoCarlos) THEN
		RAISE INFO 'Tienen una diferencia de % euros, el piloto que mas cobra es Carlos' , diferencia;
	ELSE
		RAISE INFO 'Tienen el mismo sueldo';
	END IF;

END;
$$ LANGUAGE plpgsql;


--Funcion que al pasarle la informacion necesaria introduzca una nueva linea a la base de datos a la tabla de gran_premio

CREATE OR REPLACE FUNCTION inserta_gran_premio(nombre varchar, pais varchar, circuito varchar)
    RETURNS void AS $$
    DECLARE
    id VARCHAR;
    BEGIN
		id:= (SELECT count(*) FROM gran_premio)+1;
	
        INSERT INTO gran_premio VALUES (id,nombre,pais,circuito);

END;
$$ LANGUAGE plpgsql;

--Funcion que se encargue de mostrar una tabla desde una linea de inicio y una linea final

CREATE OR REPLACE FUNCTION mostrarInfoTabla(tabla VARCHAR, empieza int, final int)
	RETURNS void AS $$
	DECLARE 
		rec_tabla RECORD;
		cur_tabla refcursor;
		count int DEFAULT 0;
	BEGIN

        if final < empieza THEN
            RAISE EXCEPTION 'El numero de la linea final es menor que la de inicio';
        END IF;
    

		OPEN cur_tabla FOR EXECUTE 'SELECT * FROM '|| tabla;
		LOOP
			FETCH cur_tabla INTO rec_tabla;
			EXIT WHEN NOT FOUND OR count = final;
			count := count +1;

            IF count <= final AND count >= empieza THEN
                RAISE INFO '% la tabla %: %', count,tabla, rec_tabla;
            END IF;

		END LOOP;
		CLOSE cur_tabla;
		
		EXCEPTION
			WHEN undefined_table THEN
			RAISE EXCEPTION 'la tabla % no existe',tabla;
	END;
$$ LANGUAGE plpgsql;

--Funcion que muestre la diferencia de posiciones entre el inicio y el final de carrera

CREATE OR REPLACE FUNCTION diferencias_posiciones(piloto varchar, gPremio varchar)
    RETURNS void AS $$
    DECLARE

    idG VARCHAR DEFAULT null;
    idP VARCHAR DEFAULT null;
    pFin int DEFAULT 0;
    pInicio int DEFAULT 0;
    diferencia int DEFAULT 0;

        cur_gp CURSOR FOR 
	    SELECT * FROM gran_premio;
        rec_gp RECORD;   

    BEGIN

    if piloto = 'Carlos' THEN
        idP = '49926127C';
    END IF;

    if piloto = 'Charles' THEN
        idP = '12943872K';
    END IF;

    if idP = null THEN

        RAISE EXCEPTION 'No ha escrito un nombre de piloto valido';

    END IF;

    OPEN cur_gp;

    LOOP

        FETCH cur_gp INTO rec_gp;
	    EXIT WHEN NOT FOUND;
        
        if rec_gp.nombre = gPremio THEN

            idG := rec_gp.id; 

        END if; 


    END LOOP;

    CLOSE cur_gp;

    if idG = null THEN

        RAISE EXCEPTION 'No ha escrito un nombre de gran premio valido';

    END IF;


    pInicio := (SELECT p_salida FROM participar WHERE dni = idP AND id = idG);
    pFin := (SELECT p_fin FROM participar WHERE dni = idP AND id = idG);

    IF pInicio = null  THEN

        RAISE INFO 'El piloto % no ha ha corrido en la carrera de %',piloto,gPremio;

    END IF;

    diferencia = pInicio -pFin;

    if diferencia <0 THEN

        RAISE INFO 'El piloto % Ha bajado % posiciones',piloto,(diferencia * -1);

    ELSIF diferencia = 0 THEN

            RAISE INFO 'El piloto % Ha quedado en la misma posicion',piloto;
    ELSE 

    RAISE INFO 'El piloto % Ha subido % posiciones',piloto,diferencia ;

    END IF;

END;
$$ LANGUAGE plpgsql;


--TRIGGERS

--Trigger que cuando eliminas al director tecnico de la base de datos iguala a null los pilotos

CREATE OR REPLACE FUNCTION borrado_director()
	RETURNS TRIGGER AS $$
	BEGIN

			UPDATE pilotos
			SET dni_dt = NULL;
			RETURN OLD;
            RAISE INFO 'Se ha ejecutado un trigger correctamente Y se ha modificado la tabal pilotos exitosamente';

	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER delete_director
BEFORE DELETE ON director_tecnico
FOR EACH ROW
EXECUTE PROCEDURE borrado_director();

--Triggers que cuando cambias el dni del director iguala el dni_dt a los pilotos al nuevo
CREATE OR REPLACE FUNCTION actualización_director_primero()
	RETURNS TRIGGER AS $$
	BEGIN

			UPDATE pilotos
			SET dni_dt = null;
			RETURN new;
            RAISE INFO 'Se ha ejecutado un trigger correctamente al actualizar la información';


	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_director1
BEFORE UPDATE OF dni ON director_tecnico
FOR EACH ROW
EXECUTE PROCEDURE actualización_director_primero();


CREATE OR REPLACE FUNCTION actualización_director_segundo()
	RETURNS TRIGGER AS $$
	BEGIN

			UPDATE pilotos
			SET dni_dt = NEW.dni;
			RETURN NULL;
            RAISE INFO 'Se ha ejecutado un trigger correctamente al actualizar la información';


	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_director2
AFTER UPDATE OF dni ON director_tecnico
FOR EACH ROW
EXECUTE PROCEDURE actualización_director_segundo();

--Triggerque comprueba si existe o no un director tecnico, si existe no se realizara el insert
CREATE OR REPLACE FUNCTION numero_director()
	RETURNS TRIGGER AS $$
    DECLARE

        rec_dt RECORD;
		cur_dt CURSOR FOR 
	    SELECT * FROM director_tecnico;

        count int DEFAULT 0;

	BEGIN

		OPEN cur_dt;
		LOOP

			FETCH cur_dt INTO rec_dt;
			EXIT WHEN NOT FOUND;
			
            count := count +1;

		END LOOP;

        CLOSE cur_dt;

        IF count = 1 THEN

            RAISE EXCEPTION 'Ya existe un director tecnico en la base de datos';
            
        ELSE

            return new;            

        END IF;

	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER insertar_director
BEFORE Insert ON director_tecnico
FOR EACH ROW
EXECUTE PROCEDURE numero_director();


--Trigger que actualiza las tablas de mecanicos al borrarse
CREATE OR REPLACE FUNCTION actualizaciónes_mecanicos()
	RETURNS TRIGGER AS $$
    DECLARE

        rec_r RECORD;
        rec_c RECORD;
        rec_i RECORD;

		cur_r CURSOR FOR 
	    SELECT * FROM m_reglaje;

        cur_c CURSOR FOR 
	    SELECT * FROM m_carrera;

        cur_i CURSOR FOR 
	    SELECT * FROM ingeniero_carrera;

	BEGIN

        OPEN cur_r;

		LOOP

            FETCH cur_r INTO rec_r;
            EXIT WHEN NOT FOUND;

            IF rec_r.dni = old.dni THEN
				DELETE FROM reglar WHERE dni = old.dni;
                DELETE FROM m_reglaje WHERE dni = old.dni;
            END IF;

        END LOOP;

        CLOSE cur_r;
        OPEN cur_c;

        LOOP

            FETCH cur_c INTO rec_c;
            EXIT WHEN NOT FOUND;

            IF rec_c.dni = old.dni THEN
				DELETE FROM cambiar_ruedas WHERE dni_m = old.dni;
                DELETE FROM m_carrera WHERE dni = old.dni;
            END IF;

        END LOOP;

        CLOSE cur_c;
        OPEN cur_i;

        LOOP

            FETCH cur_i INTO rec_i;
            EXIT WHEN NOT FOUND;

            IF rec_i.dni = old.dni THEN
				
				DELETE FROM comunicar WHERE dni_m = old.dni;
                DELETE FROM ingeniero_carrera WHERE dni = old.dni;
            END IF;

        END LOOP;

        CLOSE cur_i;

        return old;

	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER mecanicos_actualizacion
BEFORE DELETE ON mecanicos
FOR EACH ROW
EXECUTE PROCEDURE actualizaciónes_mecanicos();