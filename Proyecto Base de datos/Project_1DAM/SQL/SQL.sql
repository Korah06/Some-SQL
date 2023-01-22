
--h

UPDATE pilotos set n_sanciones = (SELECT count(id) FROM sancionar_pilotos WHERE dni = '49926127C' ) WHERE nombre = 'Carlos';
UPDATE pilotos set n_sanciones = (SELECT count(id) FROM sancionar_pilotos WHERE dni != '49926127C' ) WHERE nombre = 'Charles';

UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'ERF21' ) WHERE id = 'ERF21';
UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'VSF21' ) WHERE id = 'VSF21';
UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'ATF21' ) WHERE id = 'ATF21';
UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'ADF21' ) WHERE id = 'ADF21';
UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'FSF21' ) WHERE id = 'FSF21';
UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'CHF21' ) WHERE id = 'CHF21';
UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'TEF21' ) WHERE id = 'TEF21';
UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'CCF21' ) WHERE id = 'CCF21';
UPDATE piezas set n_sanciones = (SELECT count(sancion_id) FROM sancionar_piezas WHERE piez_id = 'MSF21' ) WHERE id = 'MSF21';


--a. 5 Consultas simples de una sola tabla

--Muestra el id y el nombre del gran premio que contiene en su nombre Estiria
SELECT id, nombre 
FROM gran_premio 
WHERE nombre 
LIKE '%Estiria%';

--Muestra el nombre de los mecanicos que cobren mas de 50000 euros
SELECT nombre 
FROM mecanicos 
WHERE sueldo > 50000;

--Muestra el nombre de los mecanicos que su nombre empiece por J
SELECT nombre 
FROM mecanicos 
WHERE nombre 
LIKE 'J%';

--Muestra las piezas con alguna una sanción
SELECT nombre 
FROM piezas 
WHERE n_sanciones>0;

--Muestra los numeros de telefono de los pilotos
SELECT telefono 
FROM pilotos;


--b. 2 Actualizaciones y 2 Borrados en cualquier tabla

DELETE FROM sancionar_pilotos WHERE id = '04'
DELETE FROM sancion WHERE id = '04'


--c. 3 Consultas con más de 1 tabla

--Muestra el id del gran premio y toda la información de las ruedas cambiadas en el gran premio de Francia
SELECT gran_premio.id, ruedas.nombre, ruedas.tipo, ruedas.durabilidad  
FROM ruedas, gran_premio, cambiar_ruedas
WHERE ruedas.nombre = cambiar_ruedas.r_nombre
AND cambiar_ruedas.gp_id = gran_premio.id
AND gran_premio.pais = 'Francia';

--Muestrame las piezas afectadas por una sancion

SELECT sancion.id, piezas.*
FROM sancion, sancionar_piezas,piezas
WHERE piezas.id = sancionar_piezas.piez_id
AND sancionar_piezas.sancion_id = sancion.id;

--Muestrame los datos de los accidentes de cada gran premio

SELECT gran_premio.id, accidente.*
FROM accidente,gran_premio,participar
WHERE accidente.id = participar.id
AND participar.id = gran_premio.id;



--d. 3 Consultas usando funciones

--Muestrame el la cantidad de mecanicos que hay
SELECT count(nombre) AS Cantidad_Mecanicos
FROM mecanicos;

--Muestrame la cantidad de veces usada los neumaticos blandos en el gran premio de brasil
SELECT count(r_nombre)
FROM cambiar_ruedas
WHERE r_nombre  = 
    (SELECT nombre
    FROM ruedas
    WHERE durabilidad = 'blando')
AND gp_id = 
    (SELECT id 
    FROM gran_premio 
    WHERE pais = 'Brasil')

--Muestrame la suma de puntos de charles leclerc
SELECT sum(puntos)
FROM participar
WHERE dni = 
    (SELECT dni
    FROM pilotos
    WHERE nombre = 'Charles')


--AVG la posición media en la que queda cada piloto al acabar el gran premio

SELECT pilotos.nombre, AVG(p_fin) AS posicion
FROM pilotos, participar
WHERE pilotos.dni = participar.dni
GROUP BY pilotos.nombre



--e. 2 Consultas usando group by

--Saber cantidad de neumaticos utilizados a lo largo de todos los grandes premios
SELECT r_nombre, count(gp_id)
FROM cambiar_ruedas
GROUP BY r_nombre;

--Muestra los mecanicos que su nombre empiece por vocal, su sueldo esté entre 10000 y 70000 euros y agrupados por su nombre, apellido y dni
SELECT * 
FROM mecanicos
WHERE UPPER(nombre) SIMILAR TO '(A|E|I|O|U)%'
AND sueldo BETWEEN 10000 AND 70000
GROUP BY nombre, apellido,dni;

--f. 2 Consultas utilizando subconsultas

--Muestra los gran permios en los que Carlos Sainz haya quedado en el podio
SELECT gran_premio.nombre
FROM gran_premio, participar
WHERE gran_premio.id = participar.id
AND p_fin < 4
AND dni = 
    (SELECT dni 
    FROM pilotos 
    WHERE nombre = 'Carlos')

--Muestra las sanciones que fueron culpa del motor
SELECT sancion.*
FROM sancionar_piezas, sancion
WHERE sancionar_piezas.sancion_id = sancion.id
AND piez_id = 
    (SELECT id 
    FROM piezas 
    WHERE nombre = 'Motor');


--g. 2 Consultas usando group by con having

--Saber cantidad de neumaticos utilizados a lo largo de todos los grandes premios que sean una cantidad mayor a 5
SELECT r_nombre, count(gp_id)
FROM cambiar_ruedas
GROUP BY r_nombre;
having count(*) >5

--Saber las veces que cada piloto quedó último

SELECT pilotos.nombre, count(p_fin)
FROM pilotos, participar
WHERE pilotos.dni = participar.dni
GROUP BY pilotos.nombre, p_fin
HAVING p_fin = 20