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




















