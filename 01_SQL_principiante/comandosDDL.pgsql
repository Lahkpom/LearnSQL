-- 3.4.Crear Tablas

-- Es el estandar que las tablas se creen en plural

--! TABLAS PARA MAIN

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