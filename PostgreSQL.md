# PostgreSQL Commands

## Setup PostgreSQL Server on Ubuntu

#### Allow remote connections

```
sudo -u postgres psql -c "SHOW config_file;"
```
Edit `/etc/postgresql/12/main/postgresql.conf` and set `listen_addresses = '*'`
Edit `/etc/postgresql/13/main/pg_hba.conf` 

```
host    feedbackflap    ffuser          0.0.0.0/0               md5
host    feedbackflap    ffuser          :/0                     md5
```

```
sudo systemctl restart postgresql
sudo ufw allow postgresql/tcp
sudo ufw status
```

To check which IP/Post postgresql is binded to -
```
netstat -nlt
```

Below command should show -
```
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 0.0.0.0:5432            0.0.0.0:*               LISTEN
tcp6       0      0 :::5432                 :::*                    LISTEN
```

#### Login

```
psql -U postgres
psql -h localhost -U myuser -W --dbname=digpi mydatabase
```

#### Create User

```
createuser -U postgres --createdb --encrypted --pwprompt --createrole --echo myuser
```
**NOTE**: Using the createuser binary instead of the psql command

> -d, --createdb
> The new user will be allowed to create databases.
> 
> -E, --encrypted
> Encrypts the user's password stored in the database. If not specified, the default password behavior is used.
> 
> -P, --pwprompt
> If given, createuser will issue a prompt for the password of the new user. This is not necessary if you do not plan on using password authentication.
> 
> -r, --createrole
> The new user will be allowed to create new roles (that is, this user will have CREATEROLE privilege)
> 
> -e, --echo
> show the commands being sent to the server

#### List Users

```
\du
```

#### Create Database

```
createdb -U postgres --owner=myuser --echo mydatabase
```

#### Load Data

```
psql -h localhost -d mydatabase -U myuser -W < schema.sql
```


#### List Database

```
\list
```

#### Connect to database

```
\c mydatabase
\connect mydatabase
```

#### List Relations

```
\dt
```

#### Quit

```
\q
```





#### Misc Commands

```sh
sudo su - postgres
root@server$: su - postgres
postgres@server$: psql
```

```sql
GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser    
ALTER DATABASE mydatabase OWNER TO myuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO mydatabase;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO mydatabase;
```
