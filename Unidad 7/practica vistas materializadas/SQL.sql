--ACTIVIDAD 1

CREATE MATERIALIZED VIEW directores_españa
AS SELECT director.dni AS NIF, director.nombre AS Nombre, director.telefono AS tlf, aeropuertos.nombre AS aero_nombre, aeropuertos.pais AS aero_pais
	FROM director, aeropuertos
	WHERE cod_aeropuerto = codigo
	AND aeropuertos.pais = 'SPAIN'

SELECT * FROM directores_españa

UPDATE directores_españa
SET NIF = '12345678J'
WHERE NIF = '4444'
--No se puede realizar updates a una vista materializada

UPDATE director
SET telefono = '685424015'
WHERE dni = '48348464J'

REFRESH MATERIALIZED VIEW directores_españa

SELECT * 
FROM directores_españa
WHERE UPPER(aero_nombre) = 'ESPAÑA'

--Si, debido a la realización del refresh hecho anteriormente

--ACTIVIDAD 2

CREATE MATERIALIZED VIEW vista_aviones
AS SELECT codigo, modelo, capacidad, fecha_vuelo
	FROM aviones, tener_escala

SELECT * FROM vista_aviones;

UPDATE tener_escala
SET fecha_vuelo = '14/03/2019 '
WHERE cod_avion = 'AA111'


REFRESH MATERIALIZED VIEW vista_aviones

CREATE MATERIALIZED VIEW vuelos_2019
AS SELECT *
	FROM volar
	WHERE TO_CHAR(fecha_vuelo, 'YYYY') = '2019'

--No hay ningún vuelo

SELECT num_vuelo
FROM vuelos_2019 
WHERE fecha_vuelo = '14/03/2019';

