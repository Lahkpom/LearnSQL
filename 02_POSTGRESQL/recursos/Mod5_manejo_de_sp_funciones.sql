-- ***************************** UNIDAD 1 *********************************
-- Procedimientos de adición, eliminación y modificacion de filas (ROWS).

-- Ejercicio 1
-- Agregar un registro a la tabla producto

SELECT * FROM productos;

INSERT INTO productos (nombre, descripcion, precio, cantidad_inventario, proveedor_id, categoria_id)
    VALUES ('Monitor Samsung');

CREATE OR REPLACE PROCEDURE agrega_producto(
    IN nombre              varchar(50),
    IN descripcion         text,
    IN precio              numeric(10, 2),
    IN cantidad_inventario integer,
    IN proveedor_id        integer,
    IN categoria_id        integer
)
    LANGUAGE plpgsql AS
    $$
        BEGIN
            INSERT INTO productos (nombre, descripcion, precio, cantidad_inventario, proveedor_id, categoria_id)
            SELECT nombre, descripcion, precio, cantidad_inventario, proveedor_id, categoria_id;

            COMMIT;

            RAISE INFO 'Dato insertado en tabla PRODUCTOS correctamente';
        END;
    $$;

CALL agrega_producto('Monitor LG', 'Monitor 4K de 27 pulgadas', 350.00, 20, 2, 1);

-- Eliminar un registro a la tabla producto
-- Eliminar el item ID = 6

DELETE FROM productos WHERE id_producto = 6;

CREATE OR REPLACE PROCEDURE elimina_producto(IN prodID integer)
    LANGUAGE plpgsql AS
    $$
        DECLARE sql TEXT;
        BEGIN

            sql := 'DELETE FROM productos WHERE id_producto = $1';
            execute sql using prodID;

            RAISE INFO 'Registro eliminado en tabla PRODUCTOS correctamente';
        END;
    $$;

CALL elimina_producto(6);

-- ******************************* UNIDAD 2 *************************************
-- Procedimientos que retornan tablas (SETOF TABLA/COMPOSITE TYPE)

-- Determinar todos los empleados que hayan sido contratados a partir del anho 2020

SELECT emp.nombres, emp.apellidos, emp.telefono
FROM empleados AS emp
WHERE extract(year from emp.fecha_contratacion) >= 2020;

CREATE OR REPLACE FUNCTION contratados_desde_2020()
    RETURNS SETOF contacto_cliente
    LANGUAGE plpgsql AS
    $$
        BEGIN
            RETURN QUERY (
                SELECT emp.nombres, emp.apellidos, emp.telefono
                FROM empleados AS emp
                WHERE extract(year from emp.fecha_contratacion) >= 2020
            );
        END;
    $$;

SELECT * FROM contratados_desde_2020();

CREATE OR REPLACE FUNCTION contratados_desde_2020_v2(gestion int)
    RETURNS SETOF empleados
    LANGUAGE plpgsql AS
    $$
        BEGIN
            RETURN QUERY (
                SELECT emp.*
                FROM empleados AS emp
                WHERE extract(year from emp.fecha_contratacion) >= gestion
            );
        END;
    $$;

SELECT * FROM contratados_desde_2020_v2(2020);

-- ******************************* UNIDAD 3 *************************************
-- Procedimientos que retornan tablas (SETOF RECORD)

-- Mostrar los nombres, descripción y cantidad de inventario de aquellos productos
-- cuya existencia en inventario sea menor a 15.
    -- La función recibe 4 parámetros
    -- una de entrada (cantidad_inventario)
    -- los demás son de salida para retornar los resultados

SELECT *
FROM productos AS prod
WHERE prod.cantidad_inventario <= 15;

CREATE FUNCTION productos_a_comprar(
    IN inventario integer,
    OUT nombre_prod varchar(50),
    OUT desc_prod text,
    OUT cant_inventario integer
)
    RETURNS SETOF RECORD
    LANGUAGE plpgsql AS
    $$
        DECLARE fila RECORD;
        BEGIN
            FOR fila IN
                SELECT *
                FROM productos AS prod
                WHERE prod.cantidad_inventario <= inventario

                LOOP
                    nombre_prod := fila.nombre;
                    desc_prod := fila.descripcion;
                    cant_inventario := fila.cantidad_inventario;
                    RETURN NEXT;
                END LOOP;
                RETURN;
        END;
    $$;

SELECT *
FROM productos_a_comprar(15);

-- ******************************* UNIDAD 4 *************************************
-- Tipos de parámetros de entrada y salida(IN, OUT, INOUT, $)

CREATE OR REPLACE FUNCTION productos_a_comprar_v2(
    INOUT integer,      --$1
    OUT varchar(50),    --$2
    OUT text            --$3
)
    RETURNS SETOF RECORD
    LANGUAGE plpgsql AS
    $$
        DECLARE fila RECORD;
        BEGIN
            FOR fila IN
                SELECT *
                FROM productos AS prod
                WHERE prod.cantidad_inventario <= $1

                LOOP
                    $2 := fila.nombre;
                    $3 := fila.descripcion;
                    $1 := fila.cantidad_inventario;
                    RETURN NEXT;
                END LOOP;
                RETURN;
        END;
    $$;


SELECT *
FROM productos_a_comprar_v2(15);

-- ******************************* UNIDAD 5 *************************************
-- LOOP y ALIAS en procedimientos almacenados. (LOOP - ALIAS FOR $1)
--  Aplicando al ejercicio anterior

CREATE OR REPLACE FUNCTION productos_a_comprar_v3(
    IN integer      --$1
)
    RETURNS TABLE(producto varchar(50), desc_prod text, stock integer)
    LANGUAGE plpgsql AS
    $$
        DECLARE fila RECORD;
        DECLARE inventario ALIAS FOR $1;
        BEGIN
            FOR fila IN
                SELECT prod.nombre, prod.descripcion, prod.cantidad_inventario
                FROM productos AS prod
                WHERE prod.cantidad_inventario <= inventario

                LOOP
                    producto := fila.nombre;
                    desc_prod := fila.descripcion;
                    stock := fila.cantidad_inventario;
                    RETURN NEXT;
                END LOOP;
                RETURN;
        END;
    $$;

SELECT *
FROM productos_a_comprar_v3(15);





















