Puerto que utilizará PostgreSQL para escuchar (Por defecto es 5432): 5432


****


# CONCEPTOS GENERALES

## TIPOS DE LENGUAJES DE CONTROL

### DDL: Data Definition Languaje para definir las bases de datos, tablas, y sus atributos

### DCL: Data Control Languaje para proteger los privilegios de los usuarios de las DB

### DML: Data Manipulation Languaje (CRUD)

## TIPOS DE RESTRICCIONES

### PRIMARY KEY (PK). NO PUEDE REPERTIRSE, Y APARTE IDENTIFCA AL ROW DENTRO DE LA TABLA

### FOREIGN KEY (FK). NOS PERMITEN RELACIONAR EN NUESTRA TABLA UNA PK DE OTRA

### UNIQUE KEY (UK). NO IDENTIFICA AL ROW DENTRO DE LA TABLA, PERO TAMPOCO PUEDE ESTAR REPETIDO

## OPERADORES DE COMPARACIÓN

### IGUAL =

### MENOR <

### MAYOR >

### MENOR O IGUAL <=

### MAYOR O IGUAL >=

### DISTINTO <>

- LOS MAYOR Y MENOR TAMBIÉN PUEDEN USAR CON CHAR YA QUE HARÁ UN ESTILO DICCIONARIO

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
        [COLUMN_NAME] [DATA_TYPE],
        [COLUMN_NAME] [DATA_TYPE]
    );

### Declarando valores por defectos

    CREATE TABLE [TABLE_NAME] (
        [COLUMN_NAME] [DATA_TYPE] DEFAULT [DEFAULT_VALUE],
        [COLUMN_NAME] [DATA_TYPE]
    );

### Aclarando cuáles valores no pueden ser nulos

    CREATE TABLE [TABLE_NAME] (
        [COLUMN_NAME] [DATA_TYPE] DEFAULT [DEFAULT_VALUE] NOT NULL,
        [COLUMN_NAME] [DATA_TYPE]
    );

### DEFINIENDO LAS RESTRICCIONES
- ESTA ES UNA FORMA PERO NO ES ACEPTADA EN TODOS LOS MOTORES DE DB
***
    CREATE TABLE [TABLE_NAME] (
        [COLUMN_NAME] [DATA_TYPE] DEFAULT [DEFAULT_VALUE] NOT NULL PRIMARY KEY,
        [COLUMN_NAME] [DATA_TYPE]
    );
- OTRA FORMA ES CON UN CONSTRAINT, QUE SE DEFINE AL FINAL DE LOS ATRIBUTOS, SE LE DA UN ALIAS, SE LE ESTABLECE LA RESTRICCIÓN, Y ENTRE () SE DEFINE CUÁL ES EL CAMPO QUE AFECTA (PUEDEN SER MÁS DE UNA {COMPUESTA}). (EL ALIAS SE COMPONE POR EL NOMBRE DE LA TABLA, EL NOMBRE DEL CAMPO, Y LA ABREVIATURA DE LA RESTRICCIÓN).
***
    CREATE TABLE [TABLE_NAME] (
        [COLUMN_NAME] [DATA_TYPE] DEFAULT [DEFAULT_VALUE] NOT NULL,
        [COLUMN_NAME] [DATA_TYPE],
        CONSTRAINT [TABLE_NAME]_[COLUMN_NAME]_[ABREVIATURA_RESTRICCIÓN] PRIMARY KEY ([COLUMN_NAME_1], [COLUMN_NAME_N]),
        CONSTRAINT [TABLE_NAME]_[COLUMN_NAME]_[ABREVIATURA_RESTRICCIÓN] UNIQUE ([COLUMN_NAME_1], [COLUMN_NAME_N]),
    );
***
    CREATE TABLE [TABLE_NAME] (
        [COLUMN_NAME] [DATA_TYPE] DEFAULT [DEFAULT_VALUE] NOT NULL,
        [COLUMN_NAME] [DATA_TYPE],
        CONSTRAINT [TABLE_NAME]_[COLUMN_NAME]_[ABREVIATURA_RESTRICCIÓN] PRIMARY KEY ([COLUMN_NAME_1], [COLUMN_NAME_N]),
        CONSTRAINT [TABLE_NAME]_[COLUMN_NAME]_[ABREVIATURA_RESTRICCIÓN] UNIQUE ([COLUMN_NAME_1], [COLUMN_NAME_N]),
    );
- LA FOREIGN KEY RELACIONA DOS TABLAS, TRAYENDO LA PK DE UNA A UN CAMPO DE LA OTRA, AL MOMENTO DE PONERLE EL ALIAS, PONEMOS NOMBRE DE LA TABLA ACTUAL, NOMBRE DE LA TABLA QUE ESTAMOS RELACIONANDO, NOMBRE DEL CAMPO PK DE LA OTRA TABLA, Y LA ABREVIATURA FK, POSTERIORMENTE PONEMOS EL CAMPO AFECTADO DE ESTA TABLA ENTRE (), LUEGO VA LA PALABRA RESERVADA REFERENCES SEGUIDO DEL NOMBRE DE LA TABLA A LA QUE HACEMOS REFERENCIA, Y UNEVAMENTE ENTRE () EL NOMBRE DEL CAMPO DE LA PK DE LA TABALA QUE REFERENCIAMOS. HACEMOS EL EJEMPLO CON NOMBRES REALES PORQUE NO ES VISUAL DE LA FORMA QUE VENIMOS HACIENDO HASTA AHORA PARA ESTO.

***
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
- TAMBIÉN PODEMOS INDICARLE QUE EN CASO QUE LA TABLA REFERENCIADA TENGA MODIFICACIONES, CÓMO PROCEDER (SOLO HACE EFECTO SI QUEREMOS MODIFICAR EL CAMPO REFERENCIADO). 

#### ON UPDATE. EN CASO QUE SE ACTUALICE LA INFORMACIÓN DEL CAMPO SELECCIONADO EN LA TABLA ORIGINAL

##### RESTRICT. NO PERMITE CAMBIOS EN EL CAMPO PADRE MIENTRAS EXISTA UNA RELACIÓN
##### CASCADE. PERMITE LOS CAMBIOS EN LA TABLA REFERENCIADA Y A SU VEZ ACTUALIZA EL CAMPO EN LA TABLA QUE TIENE LA FK

#### ON DELETE. EN CASO QUE SE BORRE LA INFORMACIÓN DEL CAMPO SELECCIONADO EN LA TABLA ORIGINAL

##### RESTRICT



## ELIMINAR TABLAS

    DROP TABLE [TABLE_NAME];

## Para cambiar el propietario de una Table:

    ALTER TABLE [TABLE_NAME] OWNER TO [USER_NAME];

## Eliminar una columna de una tabla:

    ALTER TABLE [TABLE_NAME] DROP COLUMN [COLUMN_NAME];

## Agregar una columna a una tabla:
    ALTER TABLE [TABLE_NAME] ADD COLUMN [COLUMN_NAME] [DATA_TYPE];

## INSERTAR DATOS EN LAS TABLAS

### ACLARANDO EN CUÁLES CAMPOS VAMOS A PONER DATOS
    INSERT INTO [TABLE_NAME] (CAMPO_1, CAMPO_N) VALUES (VALUE_1, VALUE_N);

### PONIENDO EN ORDEN TODOS LOS DATOS COMPLETOS DE LA TABLA
    INSERT INTO [TABLE_NAME] VALUES (VALUES);

### USANDO VALORES POR DEFECTO DEFINIDOS AL MOMENTO DE CREAR LA TABLA
    INSERT INTO [TABLE_NAME] VALUES (VALUE_1, DEFAULT, VALUE_N);
- Si no declaramos un valor por defecto al momento de crear la tabla, nos lo dejará null o vacío

***
    INSERT INTO [TABLE_NAME] (CAMPO_N) VALUES (VALUE_N);
- De esta forma los campos con valores por defecto no necesitan ser especificados como tal

### PARA PONER VARIOS REGISTROS A LA VEZ
    INSERT INTO [TABLE_NAME] VALUES (VALUES_1), (VALUES_N);
***
    INSERT INTO [TABLE_NAME] (CAMPO_1, CAMPO_N) 
    VALUES 
    (VALUE_1, VALUE_N), (VALUE_1, VALUE_N);

### ARMAR REGISTROS CON LOS DATOS DE OTRA TABLA (DEBEN COINCIDIR LOS TIPO DE DATO DE LOS REGISTROS DE DONDE SE VA A SACAR LOS DATOS, Y VA A USAR TODOS LOS DATOS DE LA OTRA TABLA):
    INSERT INTO [TABLE_A_NAME] (CAMPO_1, CAMPO_N) 
    SELECT CAMPO_1, CAMPO_N
    FROM [TABLE_B_NAME];

### cuando defino los cmapos como NOT NULL no puedo dejarlos vacíos nunca


### ACTUALIZAR LA INFORMACIÓN DE LAS TABLAS
- CUANDO SE ACTUALIZA UNA ROW, EN REALIDAD SE BORRA Y SE CREA UNA NUEVA, POR LO QUE APARECE AL FINAL DE LA TABLA LUEGO DEL UPDATE.
***
    UPDATE [TABLE_NAME]
    SET CAMPO_1 = NEW_VALUE_1, CAMPO_N = NEW_VALUE_N
    WHERE [COLUMN_NAME] = VALUE;
***

- SI NO USAMOS EL WHERE, VA A ACTUALIZAR TODOS LOS REGISTROS DE LA TABLA

***
    UPDATE [TABLE_NAME]
    SET CAMPO_1 = NEW_VALUE_1, CAMPO_N = NEW_VALUE_N;

### BORRAR LA INFORMACIÓN DE LAS TABLAS

    DELETE FROM [TABLE_NAME] 
    WHERE [COLUMN_NAME] = VALUE;
***
    DELETE FROM [TABLE_NAME] 
- ESTO ELIMINA TODO EL CONTENIDO DE LA TABLA
***
    TRUNCATE TABLE [TABLE_NAME]
***
- ESTO ELIMINA DE FORMA DIRECTA TODO EL CONTENIDO DE LA TABLA

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


# SELECT
- PUEDE RECIBIR CONSTANTES, EXPRESIONES, CAST, FUNCIONES, CAMPOS

## CONSTANTES
    SELECT 'HELLO WOLRD';

## EXPRESIONES
    SELECT 2 + 2;

## CAST (POR DEFECTO SE PIENSA QUE LAS EXPRESIONES DEVUELVEN ENTEROS, POR LO QUE NO DEVUELVEN DECIMALES SIN ANTES INDICAR UN CAST, EL CASTEO SE HACE CON :: SEGUIDO DEL VALUE, E INDICANDO EL TIPO DE DATO NUEVO) EN EL CASO DE LAS OPERACIONES HAY QUE HACERLO CON CADA NÚMERO
    SELECT 8::NUMERIC / 23::NUMERIC;
    SELECT 8::VARCHAR(2);

## FUNCIONES
    SELECT now();
    SELECT upper('hello world');

## CAMPOS DE TABLAS
    SELECT id FROM persons;
    SELECT * FROM persons;
    SELECT first_name, birthday FROM persons;
***
    SELECT id, 'HOLA', upper(first_name), 2+2, birthday::TIMESTAMP 
    FROM persons;
- ESTO TIENE UNA PARTICULARIDAD, Y ES QUE LAS FUNCIONES Y OTROS QUE NO SEAN EXTRICTAMENTE LOS CAMPOS EXISTENTES, AL VISUALIZARLAS QUEDAN CON OTROS NOMBRES DE COLUMNA, PARA ESTO SE USA EL ALIAS
***
    SELECT id, 
    'HOLA' AS ALIAS_1, 
    upper(first_name) AS ALIAS_2, 
    2+2 AS ALIAS_3, 
    birthday::TIMESTAMP 
    FROM persons;

# WHERE
- Sirve para poder filtrar los registros, el formato es WHERE COLUMN_NAME OPERADOR_COMPARACIÓN VALUE

## OPERADORES DE COMPARACIÓN
    SELECT * FROM [TABLE_NAME] WHERE [COLUMN_NAME] OPERATOR [VALUE];
    DELETE FROM [TABLE_NAME] WHERE [COLUMN_NAME] OPERATOR [VALUE];

## FUNCIONES
    SELECT * FROM [TABLE_NAME] WHERE UPPER([COLUMN_NAME]) OPERATOR [VALUE];
- EN ESTE EJEMPLO CONVERTIMOS TODO EL CONTENIDO DE LA COLUMNA A MAYÚSCULA PARA QUE COINCIDA CON UNA BÚSQUEDA DONDE YO LE PASE ALGO EN MAYÚSCULA

## AND OR
    SELECT * FROM persons 
    WHERE last_name = 'hidalgo' AND first_name = 'facundo' OR birthday = '2000-03-28';

## LIKE (USAMOS EL BLANK _ CUANDO NO SABEMOS QUE LETRA VA PARA QUE LO AUTOCOMPLETE CON CUALQUIER LETRA, COMPLETARÁ TANTOS CARACTERES COMO _ LE INDIQUEMOS)
    SELECT * FROM persons 
    WHERE last_name LIKE 'hidalg_';
- caracter por caracter
*** 
    SELECT * FROM persons 
    WHERE last_name LIKE 'hida_go';
***
    SELECT * FROM persons 
    WHERE last_name LIKE 'hi_a_go';
- que autocomplete
*** 
    SELECT * FROM persons 
    WHERE last_name LIKE 'hid%';
***
    SELECT * FROM persons 
    WHERE last_name LIKE '%algo';
***
    SELECT * FROM persons 
    WHERE last_name LIKE '%dal%';
***
    SELECT * FROM persons 
    WHERE last_name LIKE '%ES PARA%PRUEBA';

## ILIKE NOS SIRVE PARA COMPRAR SIN TENER EN CUENTA EL CASE SENSITIVE
    SELECT * FROM persons
    WHERE last_name ILIKE 'HiDaLgO';
- Esto también puede mezclarse con los _ y %

## BETWEEN PARA CONSULTAR POR UN RANGO
- LOS VALORES SON INCLUYENTES
    SELECT * FROM persons 
    WHERE birthday 
        BETWEEN '1998-12-03' AND '2001-08-14';

## IN 

### PARA UN GRUPO DE VALORES EN VEZ DE UNO SOLO
    WHERE [COLUMN_NAME] IN ([VALUE_1], [VALUE_N]);
    SELECT * FROM [TABLE_NAME]

### CON SELECT 
- ESTO ME TRAE TODOS LOS ID DE PERSONS QUE ESTÉN EN PERSONS_ID DE JOBS
    SELECT * FROM persons
    WHERE id IN (
        SELECT persons_id FROM jobs
    );


