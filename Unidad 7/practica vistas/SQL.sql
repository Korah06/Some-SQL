--ACTIVIDAD 1

--a
CREATE OR REPLACE VIEW vista_empleados
AS 
SELECT CONCAT(apellido, ', ' ,empleados.nombre) AS nombre, secciones.nombre AS seccion
FROM empleados, secciones
WHERE secciones.codigo = empleados.seccion

--b
SELECT * FROM vista_empleados

--c
SELECT seccion, count(*) as cantidad
FROM vista_empleados
GROUP BY seccion


--d
CREATE OR REPLACE VIEW vista_empleados_ingreso
AS 
SELECT TO_CHAR(fechaingreso, 'YYYY') AS anyo, count(nombre)
FROM empleados
group by anyo;


--e
SELECT * FROM vista_empleados_ingreso


--ACTIVIDAD 2

--a
CREATE OR REPLACE VIEW vista_director
AS SELECT dni,cod_aeropuerto,nombre,direccion,telefono,pais
FROM director


--b

INSERT INTO vista_director VALUES ('AAA1', 'NME', 'Juan Perez', 'Calle blanca', '12345678', 'Francia')


select * from vista_director where id='AAA1'

UPDATE vista_director
SET nombre = 'Pedro Llinares'
WHERE nombre = 'Juan Perez'


DELETE FROM vista_director
WHERE nombre = 'Pedro Llinares'

--c
CREATE VIEW vista_director3
(dni_dir_contr, nombre_dir, pais_aero)
AS SELECT dni_contr AS dni_dir_contr, director.nombre AS nombre_dir, aeropuertos.pais AS pais_aero;
FROM director, aeropuertos
WHERE aeropuertos.codigo = director.cod_aeropuerto;

SELECT * FROM vista_director3; (devuelve 271 filas)

UPDATE vista_director3 SET dni_dir_contr = '55555555E' WHERE nombre_dir LIKE 'Alicia Lopez';

Si intentamos hacer un update a una vista dará error. Las vistas no se pueden actualizar si son varias tablas.
Solo se podrán actualizar si son sencillas.

UPDATE director SET dni_contr = '55555555E' WHERE nombre LIKE 'Alicia Lopez';

Al modificar la tabla se modifica tambien los datos de la vista. Devuelve el mismo numero de filas (271).