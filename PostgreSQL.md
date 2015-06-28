
#### Switch User to Postgres
root@secondary$: su - postgres

postgres@secondary$: psql

#### Switch Database
postgres=# \c buildup

postgres=# \list

postgres=# \dt

GRANT ALL PRIVILEGES ON DATABASE kidharhai TO khdbuser    
ALTER DATABASE kidharhai OWNER TO khdbuser;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO buildup;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO buildup;