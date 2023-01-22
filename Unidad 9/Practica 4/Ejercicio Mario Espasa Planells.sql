--1

CREATE OR REPLACE FUNCTION get_personas(VARCHAR)
    RETURNS TEXT AS $$
    DECLARE

    texto TEXT DEFAULT $1 || ': *';
	id_houses INT DEFAULT -1;
	
	casa VARCHAR;
    rec_person RECORD;
    cur_person CURSOR
    FOR SELECT person.first_name, person.last_name
    FROM person,house
    WHERE house_id = house.id
    AND house.name = $1;
	

    BEGIN

    SELECT id INTO STRICT casa FROM house WHERE name = $1;

    OPEN cur_person;
	
        LOOP
            FETCH cur_person INTO rec_person;
            EXIT WHEN NOT FOUND;
			
		    texto := texto || rec_person.first_name || ',' || rec_person.last_name || '*';

        END LOOP;

	CLOSE cur_person;

   

    RETURN texto;

    EXCEPTION
    WHEN NO_DATA_FOUND then
    RAISE EXCEPTION 'La casa %, no existe en la base de datos', $1 ;

END;
$$ LANGUAGE plpgsql;

SELECT get_personas('Hufflepuff');

/*



*/

--2

CREATE OR REPLACE FUNCTION inserta_persona(INT,VARCHAR,VARCHAR,INT)
    RETURNS VOID AS $$
    DECLARE

    texto TEXT DEFAULT $1 || ': *';
	id_persona INT DEFAULT $1;
    primer_nombre VARCHAR DEFAULT $2;
    segundo_nombre VARCHAR DEFAULT $3;
    id_casa INT DEFAULT $4;
	
	rec_house RECORD;
    cur_house CURSOR
    FOR SELECT name, id
    FROM house
	WHERE id = id_casa;

    BEGIN

	OPEN cur_house;

    LOOP
        FETCH cur_house INTO rec_house;
        EXIT WHEN NOT FOUND;
			
		INSERT INTO person(id,first_name,last_name,house_id) VALUES ($1,$2,$3,$4);

    END LOOP;

    CLOSE cur_house;


END;
$$ LANGUAGE plpgsql;

SELECT inserta_persona(999,'NOM_PRUEBA','APELLIDO_PRUEBA',2);

SELECT * FROM person WHERE id = 999;
--3

CREATE OR REPLACE FUNCTION insertar_asignatura(int, varchar(50), varchar(50), varchar(50))
	RETURNS void as $$
	DECLARE
		ultimo_id int := (SELECT max(p.id) FROM Person p)+1;
		casa_aleatoria int := (SELECT FLOOR(RANDOM()*(4-1)+1)::int);
	BEGIN
		PERFORM inserta_persona(ultimo_id,$3,$4,casa_Aleatoria);
		INSERT INTO Course
		VALUES ($1,$2,ultimo_id);
		RAISE INFO 'Asignatura nueva insertada.';
		
		EXCEPTION 
			WHEN unique_violation THEN
				RAISE EXCEPTION 'ID de asignatura no valido.';
	END;
$$ LANGUAGE plpgsql;

SELECT insertar_asignatura(54,'Asignatura','EjemploNombre','EjemploApellido');
SELECT * FROM Course;

--Ta bien Fijarse en esta para insertar datos

--4

CREATE OR REPLACE FUNCTION puntos_casa(VARCHAR)
    RETURNS INT AS $$
    DECLARE


    casa INT;
    puntos INT DEFAULT 0;

	rec_points RECORD;
    cur_points CURSOR
    FOR SELECT *
    FROM house_points;

    BEGIN

    SELECT id INTO STRICT casa FROM house WHERE name = $1;

	OPEN cur_points;

    LOOP

        FETCH cur_points INTO rec_points;
        EXIT WHEN NOT FOUND;
			
        IF rec_points.id = casa THEN

            puntos = rec_points.giver- rec_points.receiver;

        END IF;
    END LOOP;

    CLOSE cur_points;
	
	RETURN puntos;

    EXCEPTION
    WHEN NO_DATA_FOUND then
    RAISE EXCEPTION 'CASA NO EXISTENTE' ;

END;
$$ LANGUAGE plpgsql;

SELECT puntos_casa('Gryffindor');



--5

CREATE OR REPLACE FUNCTION puntosAlumno(VARCHAR)
    RETURNS INT AS $$
    DECLARE


    casa INT;
    puntos INT DEFAULT 0;

	rec_points RECORD;
    cur_points CURSOR
    FOR SELECT *
    FROM house_points;

    BEGIN

    SELECT id INTO STRICT casa FROM house WHERE name = $1;

	OPEN cur_points;

    LOOP

        FETCH cur_points INTO rec_points;
        EXIT WHEN NOT FOUND;
			
        IF rec_points.id = casa THEN

            puntos = rec_points.giver- rec_points.receiver;

        END IF;
    END LOOP;

    CLOSE cur_points;
	
	RETURN puntos;

    EXCEPTION
    WHEN NO_DATA_FOUND then
    RAISE EXCEPTION 'Alumno no existente' ;

END;
$$ LANGUAGE plpgsql;

SELECT puntosAlumno('harry');

--6

CREATE OR REPLACE FUNCTION mostrar(VARCHAR)
    RETURNS VOID AS $$
    DECLARE

	tabla TEXT = $1;
    ejemplo INT;
    puntos INT DEFAULT 0;

	rec_table RECORD;
	cur_table refcursor;

    BEGIN

	OPEN cur_table FOR EXECUTE 'SELECT * FROM ' || tabla;

    LOOP

        FETCH cur_table INTO rec_table;
        EXIT WHEN NOT FOUND;
			
        RAISE INFO 'tabla %', rec_table;
    END LOOP;

    CLOSE cur_table;
	
    EXCEPTION
    WHEN UNDEFINED_TABLE then
    RAISE EXCEPTION 'LA TABLA NO EXISTE' ;

END;
$$ LANGUAGE plpgsql;

SELECT mostrar('house');