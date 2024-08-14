--! SELECT

--? CONSTANTES
SELECT 'HELLO WORLD';

SELECT 8;

--? EXPRESIONES
SELECT 2*2+2/2;

--? CAST
SELECT 8::NUMERIC / 23::NUMERIC;
SELECT 8::VARCHAR(2);

--? FUNCIONES
SELECT now();
SELECT upper('hello world');

--? CAMPOS DE TABLAS
SELECT id FROM persons;
SELECT * FROM persons;
SELECT first_name, birthday FROM persons;

SELECT id, 'HOLA', upper(first_name), 2 + 2, birthday::TIMESTAMP 
FROM persons;

--? ALIAS
SELECT id, 
'HOLA' AS ALIAS_1, 
upper(first_name) AS ALIAS_2, 
2 + 2 AS ALIAS_3, 
birthday::TIMESTAMP 
FROM persons;

--! WHERE

SELECT * FROM persons WHERE first_name = 'leonel';
DELETE FROM persons WHERE first_name = 'PARA BORRAR';

--? CON FUNCIONES
SELECT * FROM persons WHERE upper(first_name) <> 'LEONEL';

--? AND OR
SELECT * FROM persons 
WHERE last_name = 'hidalgo' 
    AND first_name = 'facundo' 
    OR birthday = '2000-03-28';

--? LIKE
INSERT INTO persons
VALUES (DEFAULT, 'PRUEBA', 'hidalgi', now(), DEFAULT, NULL);

--* caracter por caracter
SELECT * FROM persons 
WHERE last_name LIKE 'hida_go';

SELECT * FROM persons 
WHERE last_name LIKE 'hi_a_go';

--* que autocomplete

SELECT * FROM persons 
WHERE last_name LIKE 'hid%';

SELECT * FROM persons 
WHERE last_name LIKE '%algo';

SELECT * FROM persons 
WHERE last_name LIKE '%dal%';

INSERT INTO persons 
VALUES 
(DEFAULT, 'PRUEBA', 'ESTO ES PARA UNA PRUEBA', now(), DEFAULT, NULL);

SELECT * FROM persons 
WHERE last_name LIKE '%ES PARA%PRUEBA';

--? ILIKE NOS SIRVE PARA COMPRAR SIN TENER EN CUENTA EL CASE SENSITIVE
SELECT * FROM persons
WHERE last_name ILIKE 'HiDaLgO';

--! BETWEEN 

SELECT * FROM persons 
    WHERE birthday 
        BETWEEN '1998-12-03' AND '2001-08-14';

--! IN ES PARA UN GRUPO DE VALORES EN VEZ DE UNO SOLO
SELECT * FROM persons
    WHERE first_name IN ('leonel', 'fiorella');

--! IN CON SELECT 
--* ESTO ME TRAE TODOS LOS ID DE PERSONS QUE ESTÉN EN PERSONS_ID DE JOBS
SELECT * FROM persons
WHERE id IN (
    SELECT persons_id FROM jobs
);

--! ORDER BY




