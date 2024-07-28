-- 3.4.Crear Tablas

-- Es el estandar que las tablas se creen en plural

--! TABLAS PARA MAIN

--* CREAR TABLAS

CREATE TABLE persons (
    id UUID,
    first_name VARCHAR(60),
    last_name VARCHAR(60),
    age SMALLINT,
    birthday DATE,
    is_avaiable BOOL
);

-- Cuando usamos campos con claves id de otras tablas, ponemos el nombre de la tabla _ id

CREATE TABLE jobs (
    id UUID,
    persons_id UUID,
    beggins_at DATE,
    ends_at DATE,
    is_currently BOOL
);

CREATE TABLE para_borrar (
    id UUID,
    how_to VARCHAR(50)
);

-- cON VALORES OR DEFECTO
CREATE TABLE students (
    id UUID DEFAULT gen_random_uuid(),
    first_name VARCHAR(50),
    is_active BOOL DEFAULT true,
    created_at TIMESTAMP DEFAULT now()
);

--* ELIMINAR TABLAS

DROP TABLE para_borrar;

--* ELIMINAR COLUMNAS DE UNA TABLA

ALTER TABLE persons DROP COLUMN age;

--* AGREGAR COLUMNAS

ALTER TABLE jobs ADD COLUMN job_name VARCHAR(50);




