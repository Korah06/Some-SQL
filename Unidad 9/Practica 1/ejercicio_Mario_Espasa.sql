--1

--5+3*2**2 es igual a: 17
--2**3+6/3 es igual a: 10
--2**(3+6/3) es igual a: 32

--2

CREATE OR REPLACE FUNCTION diferencia(int,int)
    RETURNS int AS $$
    BEGIN
       RETURN $1-$2;
    END;
$$ LANGUAGE plpgsql;

SELECT diferencia(5,2);

--3

CREATE OR REPLACE FUNCTION cambiarCategoria()
    RETURNS void AS $$
    BEGIN
       UPDATE categorias 
	   set nombreCategoria = 'Novedades' 
	   WHERE idCategoria = 3;
    END;
$$ LANGUAGE plpgsql;

SELECT cambiarCategoria();

--4

CREATE OR REPLACE FUNCTION restar_kilos(int,int)
    RETURNS void AS $$
    DECLARE 
        producto int = $2;
        restar int = $1;
    BEGIN

        UPDATE productos SET Kilos = Kilos-restar WHERE IdProducto = producto;

    END;
$$ LANGUAGE plpgsql;

SELECT restar_kilos(3,1);

SELECT * FROM productos;

--5

CREATE OR REPLACE FUNCTION calcula_precio(int, numeric)
	RETURNS numeric as $calculaPrecio$
	BEGIN
		RETURN (select precio from productos where idproducto = $1) *$2;
	END;
	$calculaPrecio$ LANGUAGE plpgsql;
	
select calcula_precio(13,2);