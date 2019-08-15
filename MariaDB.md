## sudo mysql_install_db
Installing MariaDB/MySQL system tables in '/var/lib/mysql' ...
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system


PLEASE REMEMBER TO SET A PASSWORD FOR THE MariaDB root USER !
To do so, start the server, then issue the following commands:

'/usr/bin/mysqladmin' -u root password 'new-password'
'/usr/bin/mysqladmin' -u root -h ip-172-31-21-46.eu-west-2.compute.internal password 'new-password'

Alternatively you can run:
'/usr/bin/mysql_secure_installation'

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the MariaDB Knowledgebase at http://mariadb.com/kb or the
MySQL manual for more instructions.

You can start the MariaDB daemon with:
cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'

You can test the MariaDB daemon with mysql-test-run.pl
cd '/usr/mysql-test' ; perl mysql-test-run.pl

Please report any problems at http://mariadb.org/jira

The latest information about MariaDB is available at http://mariadb.org/.
You can find additional information about the MySQL part at:
http://dev.mysql.com
Consider joining MariaDB's strong and vibrant community:
https://mariadb.org/get-involved

 /bin/sh /usr/bin/mysqld_safe --datadir=/var/lib/mysql --pid-file=/var/lib/mysql/ip-172-31-21-46.eu-west-2.compute.internal.pid --skip-grant-tables
 
 
gem install mysql2 -- '--with-mysql-lib="/var/lib/mysql" --with-mysql-include="/usr/include/mysql" --with-mysql-dir="/var/lib/mysql"
 
 
bundle config build.mysql2  --with-mysql-lib="/var/lib/mysql" --with-mysql-include="/usr/include/mysql" --with-mysql-config="/usr/bin/mysql_config"


## sudo mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] Y
New password:
Re-enter new password:
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] Y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] Y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] Y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] Y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
[ec2-user@ip-172-31-21-46 oneviewlatest]$
[ec2-user@ip-172-31-21-46 oneviewlatest]$
[ec2-user@ip-172-31-21-46 oneviewlatest]$
[ec2-user@ip-172-31-21-46 oneviewlatest]$ mysql -uroot -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 16
Server version: 10.3.14-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]>
MariaDB [(none)]>
MariaDB [(none)]> create user 'oneviewlatest' identified by '172-31-21-46-One-viewlatest';

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS oneviewlatest_development;

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS oneviewlatest_production;

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS oneviewlatest_test;

MariaDB [(none)]> GRANT ALL PRIVILEGES on oneviewlatest_development.* to 'oneviewlatest'@'localhost';

MariaDB [(none)]> GRANT ALL PRIVILEGES on oneviewlatest_production.* to 'oneviewlatest'@'localhost';

MariaDB [(none)]> GRANT ALL PRIVILEGES on oneviewlatest_test.* to 'oneviewlatest'@'localhost';

MariaDB [(none)]> flush privileges;

