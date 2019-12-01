MySQL Guide
-----------

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