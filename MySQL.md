MySQL Guide
-----------

## Create Database

```sh
mysql -u root -p
mysql> CREATE DATABASE dbname;
```

## Create New User
```sh
mysql> CREATE USER 'dbuser'@'localhost' IDENTIFIED BY 'password';
```
```sh
mysql> GRANT ALL PRIVILEGES ON dbname.* TO 'dbuser'@'localhost';
mysql> GRANT ALL PRIVILEGES ON dbname.* TO 'dbuser'@'localhost' IDENTIFIED BY 'password';
mysql> FLUSH PRIVILEGES;
```

## Delete User
```
mysql> DROP USER ‘username’@‘localhost’;
```

## Backup

### Backup / Restore Database

```sh
mysqldump -u dbuser -p dbname > dbname-$(date +%F).sql
```

```sh
mysql -u dbuser -p dbname < filename.sql
```

### Full-Backup / Restore of the DBMS

```sh
mysqldump --all-databases --single-transaction --quick --lock-tables=false > full-backup-$(date +%F).sql -u root -p
```

```sh
mysql -u root -p < full-backup.sql
```