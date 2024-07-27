Contraseña del dueño de la DB: @Dni41622287

Puerto que utilizará PostgreSQL para escuchar (Por defecto es 5432): 5432

# En Ubuntu ponemos:

sudo apt install postgresql

sudo apt install -y postgresql -common

# Para iniciar la DB:

sudo pg_ctlcluster 16 main start

# Para ver el estado de la DB:

sudo systemctl status postgresql

# Para modificar la configuración tenemos que ir a (siempre con sudo):

cd /etc/postgresql/16/main/postgresql.conf y pg_hba.conf

# En postgresql.conf:

Encontramos en la sección de CONNECTIONS AND AUTHENTICATIONS el parámetro Listen_addresses = 'localhost' por defecto, ahí ponemos quienes pueden ver nuestra DB, si la dejamos por defecto solo se podrá ver desde nuestra máquina, si ponemos * se podrá ver desde cualquier máquina, y si sabemos exactamente qué máquinas pueden verla, deberemos poner 'Nº IP' separados por coma

# En pg_hba.con:

Como primera medida hay que modificar el Database administrative login by Unix domain socket de peer a trust en local, para que nos deje ingresar la primera vez sin contraseña, y ya después cambiarlo a md5, acá se crearan los usuarios

# Para reiniciar la DB con los cambios realizados:

sudo /etc/init.d/postgresql restart

# Para iniciar sesión por primera vez:

psql postgres postgres 

Donde psql es para tirar comandos con postgres, y seguido va el usuario y la contraseña, en este caso postgres postgres es la que viene por defecto, esto nos deja en postgres=# que es la terminal para manipular la DB, donde postgres es el nombre del usuario con el que me encuentro

# Para ver los usuarios existentes y los propietarios de esos usuario:

\l esto nos lista los nombre de usuario y los propietarios

# Para salir del modo DB:

\q y nos regresa a los controles normales de la terminal

##################################################

# Comandos más importantes para utilizar el cliente psql (por defecto, desde la teriminal):

\? Es como el help, lista todos los comandos del cliente
\l Lista las DB del servidor
\c permite conectarse a una DB (\c DBname) y para conectarnos a una DB con un usuario específico (\c DBname USERname)
\d lista las relaciones de la DB en la que estamos parados (tablas, secuencias, índices)
\dg muestra los roles y atributos
\dt lista solo el nombre de las tables que posee la DB en la que estamos, y si queremos más info de una específica es \dt [NOMBRE-TABLA]
\h es un help pero de las funciones de cada comando de SQL (\h INSERT)
\i perimte ejecutar comandos de un archivo SQL externo (Esto usamos por ejemplo para recuperar desde un backup una DB borrada)
\! nos permite ejecutar instrucciones válidas desde el bash, que no son aplicables para el cliente psql

# Cambiar la contraseña:

Desde la DB: alter role NOMBRE_USUARIO password 'NEW_PASSWORD';

# Una vez con un usuario con contraseña, para entrar a psql:

psql -U [usuario] -d [DBname] -h 127.0.0.1 -p 5432

-U de usuario, -d nombre de la DB, -h host (por defecto 127.0.0.1) -p del puerto que usa; nosotros en el pg_hba.conf podemos configurar el -h y -p de nuestra db, por lo que si estuvieramos en otra pc que tenga postgreSQL podríamos logearnos indicando que apunte hacia allá.

# Para crear nuevas bases de datos:

CREATE DATABASE [DB_NAME];

# Para crear nuevas tablas:

CREATE TABLE [TABLE_NAME] (id serial);

# Para crear nuevos usuarios:

create role user_name password 'pass'

# CLIENTE PGADMIN4




