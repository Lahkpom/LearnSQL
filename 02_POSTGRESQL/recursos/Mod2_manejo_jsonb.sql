-- **************************** UNIDAD 1 *********************************
CREATE TABLE ventas2
(
    id SERIAL PRIMARY KEY NOT NULL,
    fecha_de_venta DATE NOT NULL,
    detalles_venta JSONB NOT NULL
);

-- insertando datos de tipo JSON
INSERT INTO ventas2 (fecha_de_venta, detalles_venta) VALUES
     ('2023-02-28', '{
    "cliente": "Juan Perez",
    "total": 26.75,
    "dni": "6775699LP",
    "direccion": {
      "descripcion": "Avenida 6 de Agosto",
      "nro": "7B",
      "ciudad": "La Paz"
    },
    "productos": [
      {
        "nombre": "Producto 1",
        "precio": 10.50,
        "cantidad": 2
      },
      {
        "nombre": "Producto 2",
        "precio": 5.75,
        "cantidad": 1
      }
    ]
  }'),
     ('2023-02-28', '{
    "cliente": "William Barra",
    "total": 15.55,
    "dni": "5663345SC",
    "direccion": {
      "descripcion": "Plaza del estudiante",
      "nro": "1234",
      "ciudad": "La Paz"
    },
    "productos": [
      {
        "nombre": "Producto 1",
        "precio": 10.50,
        "cantidad": 2
      },
      {
        "nombre": "Producto 3",
        "precio": 15.75,
        "cantidad": 1
      }
    ]
  }');

-- modificando un dato de tipo JSONB
-- jsonb_set(jsonb, text[], jsonb[, boolean])

-- Modificando una propiedad de primer nivel
UPDATE ventas2
SET detalles_venta = jsonb_set(detalles_venta, '{cliente}', '"William Barra Paredes"'::jsonb)
WHERE id = 2;

-- Modificando una propiedad de segundo nivel
UPDATE ventas2
SET detalles_venta = jsonb_set(detalles_venta, '{direccion, ciudad}', '"Bogota"'::jsonb)
WHERE id = 2;

-- Modificando el precio dentro del array
UPDATE ventas2
SET detalles_venta = jsonb_set(detalles_venta, '{productos, 1, precio}', '10.75'::jsonb)
WHERE id = 2;

-- Eliminacion de objestos JSON
INSERT INTO ventas2 (fecha_de_venta, detalles_venta) VALUES
('2023-02-28', '{
    "cliente": "Pepito Pep",
    "total": 10.50,
    "dni": "1234CB",
    "direccion": {
      "descripcion": "Plaza del estudiante",
      "nro": "1234",
      "ciudad": "La Paz"
    },
    "productos": [
      {
        "nombre": "Producto 1",
        "precio": 10.50,
        "cantidad": 2
      }
    ]
  }');

-- Forma comun
DELETE FROM ventas2 WHERE id = 3;

-- **************************** UNIDAD 2 *********************************

-- Mostrando columnas que no son tipo JSON
SELECT ven.id, ven.fecha_de_venta
FROM ventas2 AS ven;

-- Mostrando columnas que no son tipo JSON
SELECT ven.id, ven.fecha_de_venta, ven.detalles_venta
FROM ventas2 AS ven;

-- Mostrando la propiedad cliente del OBJETO JSON
-- ->
-- ->>
SELECT ven.id,
       ven.fecha_de_venta,
       ven.detalles_venta->>'cliente' AS cliente,
       ven.detalles_venta->>'total' AS total_compra
FROM ventas2 AS ven;

-- Mostrando la propiedad de tipo array productos del OBJETO JSON
SELECT ven.id,
       ven.fecha_de_venta,
       ven.detalles_venta->>'cliente' AS cliente,
       ven.detalles_venta->'productos'->0->>'nombre' AS nombre
FROM ventas2 AS ven;

-- Mismo ejemplo que el anterio utlizando un metodo array
-- jsonb_array_element(campo_array, 0)
SELECT ven.id,
       ven.fecha_de_venta,
       ven.detalles_venta->>'cliente' AS cliente,
       jsonb_array_element(ven.detalles_venta->'productos', 0)->>'nombre' AS nombre
FROM ventas2 AS ven;

SELECT ven.id,
       ven.fecha_de_venta,
       ven.detalles_venta->>'cliente' AS cliente,
       ven.detalles_venta->'direccion'->>'ciudad' AS ciudad,
       jsonb_array_element(ven.detalles_venta->'productos', 0)->>'nombre' AS nombre
FROM ventas2 AS ven;

-- Eliminando registros
DELETE FROM ventas2
WHERE detalles_venta->>'cliente' = 'Pepito Pep';

-- **************************** UNIDAD 3 *********************************
-- Funciones de agregacion
-- MAX, MIN, AVG, COUNT, SUM

-- Obtener el precio total de todos los productos en cada orden = 42.50
SELECT ven.detalles_venta->'total' AS TOTAL
FROM ventas2 AS ven;

-- Resolviendo el ejercicio
SELECT SUM((ven.detalles_venta->>'total')::NUMERIC) AS TOTAL
FROM ventas2 AS ven;

-- Obtener el maximo total
SELECT MAX((ven.detalles_venta->>'total')::NUMERIC) AS MAX
FROM ventas2 AS ven;

-- De los productos compardos de los clientes
-- Determinar la suma total

SELECT SUM((detalle_producto->>'precio')::NUMERIC) AS TOTAL
FROM ventas2 AS ven,
     jsonb_array_elements(ven.detalles_venta->'productos') AS detalle_producto;

-- **************************** UNIDAD 4 *********************************
-- Multples objetos JSON
CREATE TABLE productos2(
    id SERIAL PRIMARY KEY NOT NULL,
    descripcion JSONB NOT NULL,
    opciones JSONB NOT NULL
);

INSERT INTO productos2 (descripcion, opciones)
VALUES (
    '{"nombre": "Monitor LED Lenovo", "precio": 2000.99, "categoria": "Electrónica"}',
    '{"tamaño": ["13 Pulgadas", "17 Pulgadas", "27 Pulgadas"], "color": ["negro", "blanco", "azul"]}'
);

-- Mostrando cada producto y sus precios
SELECT prod.descripcion->>'nombre' AS nombre,
       prod.descripcion->>'precio' AS precio
FROM productos2 AS prod;

-- Mostrando cada producto y sus precios y las tamanhos disponibles
SELECT prod.descripcion->>'nombre' AS nombre,
       prod.descripcion->>'precio' AS precio,
       jsonb_array_elements(prod.opciones->'tamaño') AS tamanho,
       prod.descripcion->>'categoria' AS categoria
FROM productos2 AS prod;
























