Puerto que utilizará PostgreSQL para escuchar (Por defecto es 5432): 5432


****


# CONCEPTOS GENERALES

## DDL: Data Definition Languaje para definir las bases de datos, tablas, y sus atributos

## DCL: Data Control Languaje para proteger los privilegios de los usuarios de las DB

## DML: Data Manipulation Languaje (CRUD)


****


# PRIMEROS PASOS

## En Ubuntu ponemos:

    sudo apt install postgresql

    sudo apt install -y postgresql -common

## Para iniciar la DB:

    sudo pg_ctlcluster 16 main start

## Para ver el estado de la DB:

    sudo systemctl status postgresql

## Para modificar la configuración tenemos que ir a (siempre con sudo):

    cd /etc/postgresql/16/main/postgresql.conf y pg_hba.conf
    cd C:/'Pgroam Files'/PostgreSQL/16/data/postgresql.conf y pg_hba.conf

## En postgresql.conf:

Encontramos en la sección de CONNECTIONS AND AUTHENTICATIONS el parámetro Listen_addresses = 'localhost' por defecto, ahí ponemos quienes pueden ver nuestra DB, si la dejamos por defecto solo se podrá ver desde nuestra máquina, si ponemos * se podrá ver desde cualquier máquina, y si sabemos exactamente qué máquinas pueden verla, deberemos poner 'Nº IP' separados por coma

## En pg_hba.con:

Como primera medida hay que modificar el Database administrative login by Unix domain socket de peer a trust en local, para que nos deje ingresar la primera vez sin contraseña, y ya después cambiarlo a md5, acá se crearan los usuarios

## Para iniciar sesión por primera vez:

    psql postgres postgres

Donde psql es para tirar comandos con postgres, y seguido va el usuario y la contraseña, en este caso postgres postgres es la que viene por defecto, esto nos deja en postgres=# que es la terminal para manipular la DB, donde postgres es el nombre del usuario con el que me encuentro


****


# SOBRE LOS CLIENTES

## psql cli
- \? Es como el help, lista todos los comandos del cliente
- \l Lista las DB del servidor
- \c permite conectarse a una DB (\c DBname) y para conectarnos a una DB con un usuario - específico (\c DBname USERname)
- \d lista las relaciones de la DB en la que estamos parados (tablas, secuencias, índices)
- \dg muestra los roles y atributos
- \dt lista solo el nombre de las tables que posee la DB en la que estamos, y si queremos más info de una específica es \dt [NOMBRE-TABLA]
- \h es un help pero de las funciones de cada comando de SQL (\h INSERT)
- \i perimte ejecutar comandos de un archivo SQL externo (Esto usamos por ejemplo para recuperar desde un backup una DB borrada)
- \! nos permite ejecutar instrucciones válidas desde el bash, que no son aplicables para el cliente psql
- \q y nos regresa a los controles normales de la terminal

## pgAdmin4


****


# TIPOS DE DATOS SOPORTADOS

## Numerics

- smallint              (-32.768 a 32.767)
- integer               (-2.147.483.648 a 2.147.483.647)
- bigint

- smallserial           (1 a 32.767)
- serial                (1 a 2.147.483.647)
- bigserial

- decimal, numeric
- real                  (6 digits of precision)
- double                (15 digits of precision)

## Monetary

- money                 (2 decimales)

## Character

- character varyng(n), varchar(n)   (length limit) tiene un límite que no sobrepasa
- character(n), char(n)             (fixed-length, blank padded) tiene un espacio fijo definido, lo que no se usa lo autocompleta
- text                              (unlimited length)

## Data / Time

- timestamp (p)     (date and time)
- date              (yyyy-mm-dd)
- time (p)          (24:00:00)
- interval          (Nos permite controlar un intervalo específico dentro del tiempo)
    - YEAR
    - MONTH
    - DAY
    - HOUR
    - MINUTE
    - SECOND

## Boolean

- boolean
    - true = yes, on, 1
    - false = no, off, 0

## Enumerated (es un enum que podemos crear con valores predefinidos)

- CREATE TYPE feel AS ENUM ('sad', 'ok', 'happy')

## Geometrics

- Sirve para almacenar datos como coordenadas para ubicaciones como Uber

## UUID

- Guarda un id pero con un formato que parece encriptado
    gen_random_uuid()
- Usamos esa función para que autogenere la id

## JSON

- Almacena tipos de datos json que podemos ejecutar en otro momento e incluso podemos consultar los campos de dentro


****


# SOBRE LA BASE DE DATOS

## Para reiniciar la DB con los cambios realizados:

    sudo /etc/init.d/postgresql restart

## Una vez con un usuario con contraseña, para entrar a psql:

    psql -U [USER_NAME] -d [DB_NAME] -h 127.0.0.1 -p 5432

-U de usuario, -d nombre de la DB, -h host (por defecto 127.0.0.1) -p del puerto que usa; nosotros en el pg_hba.conf podemos configurar el -h y -p de nuestra db, por lo que si estuvieramos en otra pc que tenga postgreSQL podríamos logearnos indicando que apunte hacia allá.

## De forma más resumida puedo hacer (a lo que pedirá la contraseña):

    psql [DB_NAME] [USER_NAME]

## Para crear nuevas bases de datos:

    CREATE DATABASE [DB_NAME];
    CREATE DATABASE [DB_NAME] OWNER [USER_NAME];

## Para cambiar el propietario de una DB:

    ALTER DATABASE [DB_NAME] OWNER TO [USER_NAME];


****


# SOBRE LAS TABLAS

## Para crear nuevas tablas:

    CREATE TABLE [TABLE_NAME] (
        id serial,
        name VARCHAR(N)
    );

    CREATE TABLE [TABLE_NAME] (
        id serial DEFAULT get_random_uuid(),
        name VARCHAR(N)
    );

## ELIMINAR TABLAS

    DROP TABLE [TABLE_NAME];

## Para cambiar el propietario de una Table:

    ALTER TABLE [TABLE_NAME] OWNER TO [USER_NAME];

## Eliminar una columna de una tabla:

    ALTER TABLE [TABLE_NAME] DROP COLUMN [COLUMN_NAME]

## Agregar una columna a una tabla:
    ALTER TABLE [TABLE_NAME] ADD COLUMN [COLUMN_NAME] [DATA_TYPE]

## INSERTAR DATOS EN LAS TABLAS

### ACLARANDO EN CUÁLES CAMPOS VAMOS A PONER DATOS
    INSERT INTO [TABLE_NAME] (CAMPO_1, CAMPO_N) VALUES (VALUE_1, VALUE_N);

### PONIENDO EN ORDEN TODOS LOS DATOS COMPLETOS DE LA TABLA
    INSERT INTO [TABLE_NAME] VALUES (VALUES);

### USANDO VALORES POR DEFECTO DEFINIDOS AL MOMENTO DE CREAR LA TABLA
    INSERT INTO [TABLE_NAME] VALUES (VALUES);
- Si no declaramos un valor por defecto al momento de crear la tabla, nos lo dejará null o vacío

### PONIENDO EN ORDEN TODOS LOS DATOS COMPLETOS DE LA TABLA
    INSERT INTO [TABLE_NAME] VALUES (VALUES);

### PONIENDO EN ORDEN TODOS LOS DATOS COMPLETOS DE LA TABLA
    INSERT INTO [TABLE_NAME] VALUES (VALUES);


****


# SOBRE LOS USUARIOS

## Para crear nuevos usuarios:

    CREATE ROLE [USER_NAME] PASSWORD '[PASWORD]';
    CREATE USER [USER_NAME] PASSWORD '[PASWORD]';

## Cambiar la contraseña de un usuario:

    ALTER ROLE [USER_NAME] PASSWORD '[PASWORD]';

## OTORGAR PERMISO DE CONSULTA A OTRO USUARIO A MI TABLA

    GRANT SELECT ON [TABLE_NAME] TO [USER_NAME];

## REVOCAR PERMISO DE CONSULTA A OTRO USUARIO A MI TABLA

    REVOKE SELECT ON [TABLE_NAME] FROM [USER_NAME];


****

