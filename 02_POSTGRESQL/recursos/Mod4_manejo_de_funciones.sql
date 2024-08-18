-- ************************** UNIDAD 1 ***********************
-- Single row functions y funciones de conversion(CAST FUNCTION)

-- Ejercicio
-- Dado la vista creada productos_y_descuentos
    -- convertir en mayuscula el campo CATEGORIA
    -- el campo precio_promocion agregar 2 decimales

SELECT * FROM productos_y_descuentos;

CREATE OR REPLACE VIEW productos_y_descuentos_v2 AS
SELECT prod.nombre AS producto,
       prod.precio AS precio_base,
       prov.nombre AS proveedor,
       prov.correo_electronico AS email,
       upper(cat.nombre) AS categoria,
        (
            CASE cat.nombre
                WHEN 'Electrónica' THEN '8%'
                WHEN 'Hogar' THEN '5%'
                ELSE '1%'
            END
        ) AS descuentos,
        CAST(
            (
                CASE cat.nombre
                    WHEN 'Electrónica' THEN prod.precio - prod.precio * 0.08
                    WHEN 'Hogar' THEN prod.precio -prod.precio * 0.05
                    ELSE prod.precio - prod.precio * 0.01
                END
            ) AS NUMERIC(10, 2)
        ) AS precio_promocion
FROM productos AS prod
    INNER JOIN proveedores AS prov ON prov.id_proveedor = prod.proveedor_id
    INNER JOIN categorias AS cat ON cat.id_categoria = prod.categoria_id;

SELECT * FROM productos_y_descuentos_v2;

SELECT CAST(123 AS numeric(10, 3));
SELECT '123'::NUMERIC(10, 3);

-- *********************** UNIDAD 2 **********************
-- Funciones condicionales (IF - THEN - CASE)

-- Ejemplo
-- Crear una funcion que permita validar el precio del producto
-- No ce acepta precios menores a 10.00

CREATE OR REPLACE FUNCTION valida_precio(precio numeric(10, 2))
    RETURNS bool
    LANGUAGE plpgsql AS
    $$
        DECLARE respuesta bool := false;
        DECLARE test VARCHAR;
        DECLARE age int := 0; -- age=0
        BEGIN
            IF precio >= 10.00
                THEN
                    respuesta := true;
            end if;

            RETURN respuesta;
        END;
    $$;


SELECT valida_precio(1.00);
DROP FUNCTION valida_precio;

-- EJERCICIO 2

CREATE FUNCTION precio_promocion(catNombre varchar(50), precio numeric(10,2))
    RETURNS numeric
    LANGUAGE plpgsql AS
    $$
        declare respuesta numeric;
        begin
            CASE catNombre
                WHEN 'Electrónica' THEN respuesta := precio - precio * 0.08;
                WHEN 'Hogar' THEN respuesta := precio - precio * 0.05;
                ELSE respuesta := precio - precio * 0.01;
            END CASE;

            RETURN respuesta;
        end;
    $$;

SELECT precio_promocion('Hogar', 10.00);

CREATE OR REPLACE VIEW productos_y_descuentos_v3 AS
SELECT prod.nombre AS producto,
       prod.precio AS precio_base,
       prov.nombre AS proveedor,
       prov.correo_electronico AS email,
       upper(cat.nombre) AS categoria,
        (
            CASE cat.nombre
                WHEN 'Electrónica' THEN '8%'
                WHEN 'Hogar' THEN '5%'
                ELSE '1%'
            END
        ) AS descuentos,
        precio_promocion(cat.nombre, prod.precio)::numeric(10, 2) AS precio_promocion
FROM productos AS prod
    INNER JOIN proveedores AS prov ON prov.id_proveedor = prod.proveedor_id
    INNER JOIN categorias AS cat ON cat.id_categoria = prod.categoria_id;

SELECT * FROM productos_y_descuentos_v3;

-- ************************* UNIDAD 3 *********************************
-- Manejo de errores I RAISE ERRORS (DEBUG, LOG, INFO/NOTICE)

-- Determinar la cantidad de proveedores que se tiene

SELECT count(prov.id_proveedor) AS cantidad
FROM proveedores as prov;

CREATE OR REPLACE FUNCTION cantidad_proveedores()
    RETURNS INTEGER
    LANGUAGE plpgsql AS
    $$
        DECLARE respuesta int;
        BEGIN
            SELECT count(prov.id_proveedor) INTO respuesta
            FROM proveedores as prov;

            RAISE INFO 'Cantidad de proveedores INFO: %', respuesta;
            RAISE NOTICE 'Cantidad de proveedores NOTICE: %', respuesta;
            RAISE LOG 'Cantidad de proveedores LOG: %', respuesta;
            RAISE DEBUG 'Cantidad de proveedores DEBUG: %', respuesta;

            RETURN respuesta;
        END ;
    $$;

SELECT cantidad_proveedores();

SHOW data_directory;

-- ******************* UNIDAD 4 *********************
-- Manejo de errores II RAISE ERRORS (WARNING, EXCEPTION)
-- Determinar la cantidad de empleados que se tiene

CREATE OR REPLACE FUNCTION cantidad_empleados()
    RETURNS INTEGER
    LANGUAGE plpgsql AS
    $$
        DECLARE respuesta int;
        BEGIN
            SELECT count(emp.id_empleado) INTO respuesta
            FROM empleados as emp;

            RAISE WARNING 'Cantidad de empleados WARNING: %', respuesta;

            RETURN respuesta;
        END ;
    $$;

SELECT cantidad_empleados();

CREATE OR REPLACE FUNCTION valida_precio_v2(precio numeric(10, 2))
    RETURNS bool
    LANGUAGE plpgsql AS
    $$
        BEGIN
            IF precio >= 10.00
                THEN
                    RETURN true;
            end if;

            RAISE EXCEPTION 'El precio recibido: % tiene que ser mayor a 10.00', precio;
        END;
    $$;

SELECT valida_precio_v2(2.00);

-- ************************** UNIDAD 5 ********************************
-- Imprimir en pantalla el nombre, apellido y el telefono de los clientes

SELECT cli.nombres, cli.apellidos, cli.telefono
FROM clientes AS cli
WHERE cli.id_cliente = 5;

CREATE TYPE contacto_cliente AS (
    nombres            varchar(50),
    apellidos          varchar(50),
    telefono           varchar(20)
);

CREATE FUNCTION imprimir_cliente(idCliente integer)
    RETURNS VOID
    LANGUAGE plpgsql AS
    $$
        DECLARE client_data contacto_cliente;
        BEGIN
            SELECT cli.nombres, cli.apellidos, cli.telefono INTO client_data
            FROM clientes AS cli
            WHERE cli.id_cliente = idCliente;

            RAISE INFO 'Clente -> Nombre: %, Apellidos: %, Telefono: %',
                client_data.nombres, client_data.apellidos, client_data.telefono;
        END;
    $$;

SELECT imprimir_cliente(5);




















