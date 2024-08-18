-- **************************** UNIDAD 1 ***************************************
-- VISTAS COMUNES

-- EJERCICIO 1
-- Aplicar un descuento a los productos que se tiene de acuerdo a la categoría
-- que tengan, es decir si la categoría es:
    -- ELECTRÓNICA aplicar un descuento de 8%
    -- HOGAR aplicar un descuento de 5%
    -- A las demás categorías aplicar un descuento de 1%
-- Por lo tanto crear un reporte en donde se muestre
    -- el nombre del producto, el precio base y el nuevo precio en base al descuento.
    -- Adicionalmente mostrar el nombre del proveedor y su email
    -- finalmente mostrar las categorías y los descuentos

CREATE VIEW productos_y_descuentos AS
    SELECT prod.nombre AS PRODUCTO,
           prod.precio AS PRECIO_BASE,
           prov.nombre AS PROVEEDOR,
           prov.correo_electronico AS EMAIL,
           cat.nombre AS CATEGORIA
    FROM productos AS prod
        INNER JOIN proveedores AS prov ON prod.proveedor_id = prov.id_proveedor
        INNER JOIN categorias AS cat ON prod.categoria_id = cat.id_categoria;

SELECT * FROM productos_y_descuentos;

-- Completando el ejercicio
-- Agrrgando la columna descuentos y nuevo precio

CREATE OR REPLACE VIEW productos_y_descuentos AS
SELECT prod.nombre AS producto,
       prod.precio AS precio_base,
       prov.nombre AS proveedor,
       prov.correo_electronico AS email,
       cat.nombre AS categoria,
        (
            CASE cat.nombre
                WHEN 'Electrónica' THEN '8%'
                WHEN 'Hogar' THEN '5%'
                ELSE '1%'
            END
        ) AS descuentos,
        (
                CASE cat.nombre
                    WHEN 'Electrónica' THEN prod.precio - prod.precio * 0.08
                    WHEN 'Hogar' THEN prod.precio -prod.precio * 0.05
                    ELSE prod.precio - prod.precio * 0.01
                END
           ) AS precio_promocion
FROM productos AS prod
    INNER JOIN proveedores AS prov ON prov.id_proveedor = prod.proveedor_id
    INNER JOIN categorias AS cat ON cat.id_categoria = prod.categoria_id;

SELECT * FROM productos_y_descuentos;

-- **************************** UNIDAD 2 ***************************************
-- VISTAS MATERIALIZADAS
-- Determinar cuál es el empleado que esta haciendo mas ventas
-- Mostrar los datos del empleado:
    -- Nombre completo
    -- Nro de Ventas

-- iniciando solucion
SELECT emp.nombres,
       emp.apellidos,
       COUNT(ven.empleado_id) AS total_ventas
FROM ventas AS ven
    INNER JOIN empleados AS emp ON emp.id_empleado = ven.empleado_id
GROUP BY emp.nombres, emp.apellidos, ven.empleado_id
ORDER BY total_ventas DESC;


-- Resolviendo el ejercicio
SELECT emp.nombres,
       emp.apellidos,
       ven.empleado_id
FROM ventas AS ven
    INNER JOIN empleados AS emp ON emp.id_empleado = ven.empleado_id
ORDER BY ven.empleado_id DESC;

-- terminando la solucion
CREATE MATERIALIZED VIEW empleado_del_mes AS
    SELECT CONCAT(emp.nombres, ' ', emp.apellidos) AS empleado,
           COUNT(ven.empleado_id) AS total_ventas
    FROM ventas AS ven
        INNER JOIN empleados AS emp ON emp.id_empleado = ven.empleado_id
    GROUP BY emp.nombres, emp.apellidos, ven.empleado_id
    ORDER BY total_ventas DESC
    LIMIT 1;

SELECT * FROM empleado_del_mes;

-- ************************************ UNIDAD 3 *****************************
-- Vistas comunes VS Vistas materializadas
SHOW DATA_DIRECTORY;

SELECT pg_relation_filepath('vista_ventas');

-- ************************************ UNIDAD 4 *****************************
-- Como utilizar una Vista materializada

SELECT * FROM empleado_del_mes;

REFRESH MATERIALIZED VIEW empleado_del_mes;

SELECT * FROM empleado_del_mes;

SELECT *
FROM empleado_del_mes AS em
WHERE em.total_ventas > 3;

SELECT * FROM productos_y_descuentos;

SELECT *
FROM productos_y_descuentos AS pd
WHERE pd.descuentos = '8%';























