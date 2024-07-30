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

CREATE TABLE tmp_students (
    first_name VARCHAR(50),
    active BOOL    
);

-- con valores no nulos
CREATE TABLE students2 (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    is_active BOOL DEFAULT true NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP
);

--? CREAR TABLAS CON PK, UK Y FK
DROP TABLE persons;
DROP TABLE jobs;

CREATE TABLE persons (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    birthday DATE NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT persons_id_pk PRIMARY KEY (id),
    CONSTRAINT persons_first_last_name_uk UNIQUE (first_name, last_name)
);

CREATE TABLE jobs (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    persons_id UUID NOT NULL,
    job_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT jobs_id_pk PRIMARY KEY (id),
    CONSTRAINT jobs_persons_id_fk FOREIGN KEY (persons_id)
        REFERENCES persons (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);


--* ELIMINAR TABLAS

DROP TABLE para_borrar;

--* ELIMINAR COLUMNAS DE UNA TABLA

ALTER TABLE persons DROP COLUMN age;

--* AGREGAR COLUMNAS

ALTER TABLE jobs ADD COLUMN job_name VARCHAR(50);






