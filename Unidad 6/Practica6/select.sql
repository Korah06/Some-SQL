
--1
SELECT * 
FROM clientes 
WHERE UPPER(ciudad) = 'MADRID';

--2

SELECT nombre 
FROM marcas 
ORDER BY nombre ASC;

--3

SELECT concesionarios.cif 
FROM concesionarios, distribucion 
WHERE concesionarios.cif = distribucion.cif 
AND distribucion.cantidad>18;

--4

SELECT concesionarios.cif 
FROM concesionarios, distribucion 
WHERE concesionarios.cif = distribucion.cif 
AND distribucion.cantidad BETWEEN 10 AND 18;

--5

SELECT concesionarios.cif 
FROM concesionarios, distribucion 
WHERE concesionarios.cif = distribucion.cif 
AND distribucion.cantidad IN(10,11,12,13,14,15,16,17,18);

--6

SELECT concesionarios.cif
FROM concesionarios, distribucion
WHERE concesionarios.cif = distribucion.cif 
AND distribucion.cantidad < 3 OR distribucion.cantidad >10;

SELECT cif
FROM distribucion
WHERE cantidad < 3 OR cantidad >10;

--7

SELECT marcas.cif, clientes.id 
FROM marcas, clientes
WHERE clientes.ciudad = marcas.ciudad;

--8

SELECT clientes.id, marcas.cif
FROM clientes, marcas
WHERE NOT clientes.ciudad = marcas.ciudad;

--9

SELECT coches.cod 
FROM coches, distribucion, concesionarios
WHERE concesionarios.cif = distribucion.cif 
AND coches.cod = distribucion.coche 
AND concesionarios.ciudad = 'Barcelona';

--10

SELECT coches.cod
FROM coches, ventas, clientes
WHERE clientes.id = ventas.dni 
AND clientes.ciudad = 'Madrid';

SELECT coches
FROM ventas, clientes
WHERE clientes.id = ventas.dni 
AND clientes.ciudad = 'Madrid';

--11

SELECT coches.cod 
FROM coches, ventas, clientes, concesionarios
WHERE ventas.coche = coches.cod 
AND ventas.dni = clientes.id 
AND concesionarios.cif = ventas.cif
AND concesionarios.ciudad = 'Madrid' 
AND clientes.ciudad = 'Madrid';

--12

SELECT coches.cod
FROM coches, clientes, concesionarios, ventas
WHERE clientes.id = ventas.dni 
AND concesionarios.ciudad = clientes.ciudad;

--13

SELECT coches.cod 
FROM coches, ventas, clientes, concesionarios
WHERE ventas.coche = coches.cod 
AND ventas.dni = clientes.id 
AND concesionarios.cif = ventas.cif
AND concesionarios.ciudad != clientes.ciudad;

--14

SELECT cod
FROM coches
WHERE nombre NOT LIKE 'c%';

--15

SELECT cod FROM coches 
WHERE cod NOT SIMILAR TO ('A%') 
AND cod NOT SIMILAR TO ('%A%') 
AND cod NOT SIMILAR TO ('%A');

--16

SELECT  COUNT (DISTINCT nombre)
FROM marcas
WHERE ciudad = 'Madrid';

--17

SELECT AVG(cantidad) 
FROM distribucion;

--18

SELECT max(id)
FROM clientes
WHERE clientes.ciudad = 'Madrid';

--19

SELECT min(dni) 
FROM ventas 
WHERE color = 'white';

--20

SELECT concesionarios.cif
FROM concesionarios, distribucion
WHERE concesionarios.cif = distribucion.cif 
AND distribucion.cantidad IS NOT NULL;

--21

SELECT cif, nombre FROM marcas WHERE ciudad LIKE '_i%';

--22

SELECT DISTINCT clientes.id
FROM clientes, concesionarios, ventas
WHERE clientes.id = ventas.dni 
AND concesionarios.ciudad = 'Madrid';

--23

SELECT ventas.color 
FROM ventas, concesionarios 
WHERE ventas.cif = concesionarios.cif 
AND concesionarios.nombre = 'Fercar';

--24

SELECT coches.cod
FROM coches, concesionarios, ventas
WHERE concesionarios.cif = ventas.cif 
AND concesionarios.ciudad = 'Madrid'; 

--25

SELECT coches.cod, coches.nombre 
FROM coches, ventas, concesionarios
WHERE ventas.coche = coches.cod 
AND concesionarios.cif = ventas.cif
AND concesionarios.ciudad = 'Barcelona';

--26

SELECT clientes.nombre, clientes.apellido
FROM clientes, ventas, concesionarios
WHERE clientes.id = ventas.dni 
AND concesionarios.nombre ='Motor Sport';

--27

SELECT nombre, apellido, id 
FROM clientes 
WHERE id < 
    (SELECT id 
    FROM clientes 
    WHERE nombre = 'Alvaro' 
    AND apellido = 'Pérez');

--28

SELECT clientes.id 
FROM clientes 
WHERE ciudad = 
    (SELECT MAX(ciudad) 
    FROM concesionarios);

--29

