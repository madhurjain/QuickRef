
#### Switch User to Postgres
root@server$: su - postgres

postgres@server$: psql

#### Switch Database
postgres=# \c mydatabase

postgres=# \list

postgres=# \dt

GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser    
ALTER DATABASE mydatabase OWNER TO myuser;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO mydatabase;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO mydatabase;



sudo su - postgres
createuser -d -E -i -l -P -r -s myuser
psql -U postgres
CREATE DATABASE mydatabase
\q
psql -h localhost -U myuser -W
\q
psql -h localhost -d mydatabase -U myuser -W < schema.sql

psql -h localhost -d mydatabase -U myuser -W