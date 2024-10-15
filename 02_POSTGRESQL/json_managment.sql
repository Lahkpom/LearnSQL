CREATE TABLE SALES2 (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	SALE_DATE DATE DEFAULT NOW() NOT NULL,
	SALE_DETAIL JSONB NOT NULL,
	CONSTRAINT SALES2_ID_PK PRIMARY KEY (ID)
);

-- INSERT DATOS JOSN
INSERT INTO
	SALES2 (SALE_DATE, SALE_DETAIL)
VALUES
	(
		'2023-02-28',
		'{
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
  	}'
	),
	(
		'2023-02-28',
		'{
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
  	}'
	);

-- UPDATE DATOS JSON
-- MÉTODO: JSONB_SET(JSONB, TEXT[], JSONB[, BOOLEAN])
-- JSONB ES EL NOMBRE DE LA COLUMNA A MODIFICAR
-- TEXT ES EL CAMPO QUE QUEREMOS MODIFICAR
-- JSONB[] ES EL VALOR QUE QUEREMOS INGRESAR
-- UPDATE DE 1ER NIVEL
UPDATE SALES2
SET
	SALE_DETAIL = JSONB_SET(
		SALE_DETAIL,
		'{cliente}',
		'"William Barra Paredes"'::JSONB
	)
WHERE
	ID = '8f4a3b02-0bbd-4bbe-bb18-7f9e01751b00';

-- UPDATE DE 2 O + NIVELES
-- EN EL TEXT[] PONEMOS EL 1ER PARÁMETRO SEGUIDO DEL 2DO CON UNA COMA
-- ESTO ES ASÍ SUCESIBAMENTE CON MÁS NIVELES
UPDATE SALES2
SET
	SALE_DETAIL = JSONB_SET(
		SALE_DETAIL,
		'{direccion, ciudad}',
		'"Bogotá"'::JSONB
	)
WHERE
	ID = '8f4a3b02-0bbd-4bbe-bb18-7f9e01751b00';

-- UPDATE A UN ARRAY DENTRO DEL JSON
-- CUANDO TENEMOS UN CAMPO CON UN ARRAY, AL MOMENTO DE MENCIONARLO,
-- DEBEMOS SEPARAR CON UNA COMA Y COLOCAR UN NÚMERO CORRESPONDIENTE A
-- LA POSICIÓN DEL OBJETO QUE QUEREMOS MODIFICAR (COMENZANDO CON CERO)
-- Y LUEGO VOLVER A SEPARAR CON COMA PARA POSTERIORMENTE INDICAR EL CAMPO
-- QUE DESEAMOS ALTERAR
UPDATE SALES2
SET
	SALE_DETAIL = JSONB_SET(
		SALE_DETAIL,
		'{productos, 1, precio}',
		'10.75'::JSONB
	)
WHERE
	ID = '8f4a3b02-0bbd-4bbe-bb18-7f9e01751b00';

-- INSERTAMOS UN NUEVO REGISTRO
INSERT INTO
	SALES2 (SALE_DATE, SALE_DETAIL)
VALUES
	(
		'2023-02-28',
		'{
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
  }'
	);

-- SELECT, CÓMO MOSTRAR LA INFORMACIÓN CONTENIDA EN EL JSONB
-- OPERADOR -> ACCEDE A LA PROPIEDAD OBTENIENDO LA VARIABLE - EJ. "HELLO WORLD"
-- OPERADOR ->> ACCEDE A LA PROPIEDAD OBTENIENDO EL VALOR - EJ. HELLO WORLD
SELECT
	*
FROM
	SALES2;

SELECT
	SALE_DATE,
	SALE_DETAIL -> 'cliente' AS CUSTOMER
FROM
	SALES2;

SELECT
	SALE_DATE,
	SALE_DETAIL ->> 'cliente' AS CUSTOMER,
	SALE_DETAIL ->> 'total' AS TOTAL
FROM
	SALES2;

SELECT
	*
FROM
	SALES2
WHERE
	SALE_DETAIL -> 'cliente' = '"Juan Perez"';

SELECT
	*
FROM
	SALES2
WHERE
	SALE_DETAIL ->> 'cliente' = 'Juan Perez';

-- SELECT DE SEGUNDO NIVEL
-- SE VUELVE A PONER EL OPERADOR Y EL NUEVO CAMPO
SELECT
	SALE_DETAIL -> 'cliente' AS CLIENTE,
	SALE_DETAIL -> 'direccion' -> 'ciudad' AS CIUDAD
FROM
	SALES2
WHERE
	SALE_DETAIL ->> 'cliente' = 'Juan Perez';

-- SELECT DE ARRAYS
-- SE VUELVE A PONER EL OPERADOR, LA POSICIÓN DEL OBJETO DESEADO, Y DE NUEVO EL 
-- OPERADOR PARA PONER EL CAMPO
-- SI SOLO LE PONEMOS LA POSICIÓN, NOS DEVOLVERÁ EL OBJETO COMPLETO
SELECT
	SALE_DETAIL -> 'cliente' AS CLIENTE,
	SALE_DETAIL -> 'productos' -> 0 AS PRODUCTO
FROM
	SALES2
WHERE
	SALE_DETAIL ->> 'cliente' = 'Juan Perez';

SELECT
	SALE_DETAIL -> 'cliente' AS CLIENTE,
	SALE_DETAIL -> 'productos' -> 0 -> 'nombre' AS NOMBRE_PRODUCTO
FROM
	SALES2
WHERE
	SALE_DETAIL -> 'cliente' = 'Juan Perez'; 

SELECT
	SALE_DETAIL -> 'cliente' AS CLIENTE,
	SALE_DETAIL -> 'productos' -> 0 -> 'nombre' AS NOMBRE_PRODUCTO
FROM
	SALES2
WHERE
	SALE_DETAIL -> 'productos' -> 1 ->> 'precio' = '5.75';

-- TAMBIÉN PODEMOS SIMPLIFICAR ESTA CONSULTA USANDO UNA FUNCIÓN
-- JSONB_ARRAY_ELEMENT(CAMPO_ARRAY, POS)
-- CAMPO_ARRAY ES TODO EL PATH
SELECT
	SALE_DETAIL -> 'cliente' AS CLIENTE,
	JSONB_ARRAY_ELEMENT(SALE_DETAIL -> 'productos', 0) ->> 'nombre' AS NOMBRE_PRODUCTO
FROM
	SALES2
WHERE
	JSONB_ARRAY_ELEMENT(SALE_DETAIL -> 'productos', 1) ->> 'precio' = '5.75';

-- BORRAR TUPLAS FILTRANDO POR EL CONTENIDO DEL JSONB
DELETE FROM SALES2
WHERE
	SALE_DETAIL ->> 'cliente' = 'Pepito Pep';

SELECT
	*
FROM
	SALES2;