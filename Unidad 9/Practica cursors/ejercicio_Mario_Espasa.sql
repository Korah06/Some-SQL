--2

CREATE OR REPLACE FUNCTION cuenta_productos()
    RETURNS INT AS $$
    DECLARE

    cuenta int DEFAULT 0;
    rec_productos RECORD;

    cur_productos CURSOR
    FOR SELECT NomProducto
    FROM productos
    WHERE kilos >=1;

    BEGIN

    OPEN cur_productos;

    LOOP
        FETCH cur_productos INTO rec_productos;
        EXIT WHEN NOT FOUND;
        cuenta = cuenta +1;

    END LOOP;

    CLOSE cur_productos;

    RETURN cuenta;

END;
$$ LANGUAGE plpgsql;

SELECT cuenta_productos();


--3

CREATE OR REPLACE FUNCTION modificar_precio(int)
    RETURNS VOID AS $$
    DECLARE

    auxiliar int;
    rec_productos RECORD;

    cur_productos CURSOR
    FOR SELECT NomProducto, Precio
    FROM productos
    WHERE Precio <=8;

    BEGIN

    OPEN cur_productos;

    LOOP
        FETCH cur_productos INTO rec_productos;
        EXIT WHEN NOT FOUND;

        UPDATE productos SET precio = precio + ((precio/100) * $1) WHERE CURRENT OF cur_productos;

    END LOOP;

    CLOSE cur_productos;


END;
$$ LANGUAGE plpgsql;

SELECT modificar_precio(5);

SELECT * FROM productos;

--4
CREATE OR REPLACE FUNCTION eliminar_productos(int)
    RETURNS TEXT AS $$
    DECLARE

    texto TEXT DEFAULT '';
    auxiliar int;
    rec_productos RECORD;

    cur_productos CURSOR
    FOR SELECT NomProducto, IdProducto
    FROM productos
    WHERE kilos< $1;

    BEGIN

    OPEN cur_productos;

    LOOP
        FETCH cur_productos INTO rec_productos;
        EXIT WHEN NOT FOUND;

        texto := texto || rec_productos.NomProducto || ' '
        DELETE FROM productos WHERE CURRENT OF cur_productos;

    END LOOP;

    CLOSE cur_productos;

    RETURN texto;

END;
$$ LANGUAGE plpgsql;

SELECT eliminar_productos(10);

SELECT * FROM productos;
