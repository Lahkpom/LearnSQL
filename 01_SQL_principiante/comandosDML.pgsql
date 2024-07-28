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



