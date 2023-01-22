--1
SELECT equipo, count(Nombre)
FROM equipos, jugador 
WHERE jugador.equipo_jugador =equipo
GROUP BY equipo

--2

SELECT equipo_jugador, count (*)
FROM jugador
WHERE nombre 
IN( SELECT DISTINCT nombre_jug 
FROM JUGAR
WHERE to_char(fecha_part, 'YYYY')='2010')
GROUP BY equipo_jugador


--3

SELECT nombre_jug, MIN(fecha_part) 
FROM jugar 
GROUP BY nombre_jug

--4

SELECT nombre_jug, min_jugar
FROM JUGAR
WHERE UPPER(nombre_jug) LIKE '%A%'
GROUP BY nombre_jug, min_jugar
HAVING SUM(min_jugar) BETWEEN 150 AND 300

---------------------------------------------------------------------------
SELECT nombre_jug, sum(min_jugar) AS Minutos_Totales
FROM JUGAR
WHERE UPPER(nombre_jug) LIKE '%A%'
GROUP BY nombre_jug
HAVING SUM(min_jugar) BETWEEN 150 AND 300
ORDER BY SUM(min_jugar), nombre_jug



--5

SELECT jugador_gol, count(jugador_gol)
FROM gol
WHERE UPPER(jugador_gol) LIKE '%A%'
GROUP BY jugador_gol
HAVING count(jugador_gol) < 4 OR count(jugador_gol) > 8
ORDER BY COUNT(jugador_gol)

--6

SELECT nombre_jug, MAX(fecha_part) AS fecha_partido , min_jugar
FROM jugar 
GROUP BY nombre_jug
HAVING AVG(min_jugar)>100

--7

SELECT nombre
FROM jugador
WHERE LENGTH(nombre) <=10

UNION

SELECT nombre_arb
FROM arbitrar
WHERE  LENGTH(nombre_arb) <=10

--8

SELECT nombre
FROM jugador
WHERE CAST(TO_CHAR(NOW(), 'YYYY') AS NUMERIC ) -  CAST(TO_CHAR(fecha_nac, 'YYYY')AS NUMERIC ) >25

EXCEPT

SELECT nombre
FROM jugador
WHERE tipo_jugador != 'COSTA RICA'

--9

SELECT nombre
FROM arbitro
WHERE UPPER(nombre) LIKE '%R%'

INTERSECT

SELECT nombre
FROM arbitro
WHERE UPPER(nombre) SIMILAR TO '___(A|E|I|O|U)%'

INTERSECT

SELECT nombre
FROM arbitro
WHERE  LENGTH(nombre) >6