--3 Practica 1


CREATE OR REPLACE FUNCTION cambiarCategoria(int, VARCHAR)
    RETURNS void AS $$
    BEGIN

    if (SELECT idCategoria from categorias where idCategoria = $1) IS NOT NULL THEN
    
        RAISE INFO 'La categoria se ha modificado a %', $2;

        UPDATE categorias 
	    set nombreCategoria = $2 
	    WHERE idCategoria = $1;
    ELSE
        RAISE EXCEPTION 'No existe el id %', $1;
    END IF;

    END;
$$ LANGUAGE plpgsql;

SELECT cambiarCategoria(3,'Cambiado');



--4 Practica 1

CREATE OR REPLACE FUNCTION restar_kilos(int,int)
    RETURNS void AS $$
    DECLARE 
        producto int = $2;
        restar int = $1;
    BEGIN
    if (SELECT idProducto from productos where idProducto = producto) IS NOT NULL THEN

        RAISE INFO 'El producto existe';

        if (SELECT kilos FROM productos WHERE idproducto = producto) > restar THEN
    
            UPDATE productos SET Kilos = Kilos-restar WHERE IdProducto = producto;

        ELSE

        RAISE EXCEPTION 'No hay suficientes kilos';

        END IF;

    ELSE

        RAISE EXCEPTION 'Ese producto no existe';

    END IF;

    END;
$$ LANGUAGE plpgsql;

SELECT restar_kilos(20,2);

SELECT * FROM productos;

--5 Practica 1

CREATE OR REPLACE FUNCTION calcula_precio(int, numeric)
	RETURNS numeric as $calculaPrecio$
    DECLARE

    rec record;
	BEGIN

    if (SELECT kilos FROM productos WHERE idproducto = producto) > $2 THEN

        RAISE INFO 'Hay suficiente producto';

        if (SELECT idProducto from productos where idProducto = $1) IS NOT NULL THEN

        RETURN (select precio from productos where idproducto = $1) *$2;

        ELSE

            RAISE EXCEPTION 'Ese producto no existe';

        END IF;


    ELSE

        RAISE EXCEPTION 'No hay suficientes kilos';

    END IF;

		
	END;
	$calculaPrecio$ LANGUAGE plpgsql;
	
select calcula_precio(13,2);

--1
CREATE OR REPLACE FUNCTION restar_kilos(int,int)
    RETURNS void AS $$
    DECLARE 
        rec record;
        producto int = $2;
        restar int = $1;
    BEGIN

    SELECT idProducto into strict rec from productos where idProducto = producto;

        RAISE INFO 'El producto existe';

        if (SELECT kilos FROM productos WHERE idproducto = producto) > restar THEN
    
            UPDATE productos SET Kilos = Kilos-restar WHERE IdProducto = producto;

            if (SELECT kilos FROM productos WHERE idproducto = producto) < 10 THEN

            RAISE INFO 'Contacte con el proveedor de % actualmente dispone de % kg', 
            (SELECT NomProducto FROM productos WHERE idproducto = producto) ,(SELECT Kilos FROM productos WHERE idproducto = producto);

            END IF;

        ELSE

        RAISE EXCEPTION 'No hay suficientes kilos';

        END IF;

    

    exception 
	   when no_data_found then

    RAISE EXCEPTION 'Ese producto no existe';


    END;
$$ LANGUAGE plpgsql;

SELECT restar_kilos(11,45);

SELECT * FROM productos;

--2

CREATE OR REPLACE FUNCTION insertar_producto(VARCHAR,NUMERIC,int,int)
RETURNS void AS $$
    DECLARE 
        producto int = (SELECT MAX(idProducto) FROM productos)+1;
        nombre VARCHAR = $1;
        precio NUMERIC = $2;
        categoria int = $3;
        kilos int = $4;
    BEGIN

        IF precio > 0.19 AND precio < 5.5  THEN

            INSERT INTO productos(IdProducto,NomProducto,Precio,Categoria, Kilos) VALUES (producto,nombre,precio,categoria,kilos);

            RAISE INFO 'Producto nuevo insertado';

        ELSE

            RAISE EXCEPTION 'Procducto NO insertado: El producto es muy caro';

        END IF;



END;
$$ LANGUAGE plpgsql;

SELECT insertar_producto('FrutaX', 3,3,20);

SELECT * FROM productos;
--3


CREATE OR REPLACE FUNCTION insertar_categoria(VARCHAR)
RETURNS void AS $$
    DECLARE 
        id int = (SELECT MAX(idCategoria) FROM categorias)+1;
        nombre VARCHAR = $1;
        
    BEGIN

        INSERT INTO categorias (IdCategoria,NombreCategoria) VALUES (id,nombre);

        RAISE INFO 'Nueva categoria creada';


END;
$$ LANGUAGE plpgsql;

SELECT insertar_categoria('CategoriaN');

SELECT * FROM categorias;

--4
CREATE OR REPLACE FUNCTION mostrar_producto(int)
RETURNS productos AS $$
    
    DECLARE producto record;
    BEGIN

    SELECT * INTO producto FROM productos WHERE idProducto = $1;
    RETURN producto;

    END;
$$ LANGUAGE plpgsql;

SELECT mostrar_producto(1);