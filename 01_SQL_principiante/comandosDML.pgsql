--* INSERTAR DATOS EN LAS TABLAS

--? Aclarando los datos que se van a completar
INSERT INTO persons (
    id, 
    first_name, 
    last_name, 
    birthday, 
    is_avaiLable
) 
VALUES (
    gen_random_uuid(),
    'Leonel',
    'Hidalgo',
    '1998-12-03',
    true
);


--? En este ejemplo le ponemos solo los campos que queremos completar
INSERT INTO persons (
    id, 
    first_name, 
    is_avaiLable
) 
VALUES (
    gen_random_uuid(),
    'Leonel',
    true
);

--? Sin aclara los datos que se van a poner (lo que significa que se va a poner todos los datos y en el orden en que están tablas)
INSERT INTO persons 
VALUES (
    gen_random_uuid(),
    'Facundo',
    'Hidalgo',
    '2001-08-14',
    false
);

INSERT INTO persons 
VALUES (
    gen_random_uuid(),
    'Gonzalo',
    DEFAULT,
    DEFAULT,
    false
);

--? Con valores por defecto
INSERT INTO students
VALUES (
    DEFAULT,
    'Leonel',
    DEFAULT,
    DEFAULT
);

--? Sabiendo que 3 de 4 campos tienen valores por defecto, podríamos usar el otro tipo de declaración
--? donde le indico solo el campo que quiero afectar y el resto tome su valor por defecto
INSERT INTO students (first_name)
VALUES ('facundo');
-- De esta forma no repetimos los DEFAULT y nos queda un código más limpio

--? Para meter varios registros de una vez
INSERT INTO students VALUES 
(DEFAULT, 'student1', DEFAULT, DEFAULT),
(DEFAULT, 'student2', DEFAULT, DEFAULT),
(DEFAULT, 'student3', DEFAULT, DEFAULT);

INSERT INTO students (first_name) VALUES
('student4'), ('student5'), 
('student6'), ('student7');

--? También puedo hacer INSERT con consultas traídas de otras TABLESAMPLE
--? La condición es que debe ser del mismo tipo de dato
INSERT INTO tmp_students VALUES 
('PRUEBA_1', true), ('PRUEBA_2', false);

--! ESTO NOS TRAE LOS DATOS DE LA OTRA TABLA Y LOS METE EN LA ACTUAL
INSERT INTO students (first_name, is_active) 
SELECT first_name, active
FROM tmp_students;

--? TABLAS CON CAMPOS NOT NULL
INSERT INTO students VALUES (NULL, NULL, NULL, NULL);

-- ESTO ME DA ERROR YA QUE ESPECIFIQUÉ QUE NO PUEDO DEJAR CAMPOS NULOS
-- INSERT INTO students2 VALUES (NULL, NULL, NULL, NULL, NULL);
INSERT INTO students2 (first_name) VALUES ('Leonel');

