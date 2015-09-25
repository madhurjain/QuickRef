## Setting up a FTP Server

- Install NGINX, MySQL as per [VPSSetup](VPSSetup.md) guide
- Open ports for `HTTP(80)` and `FTP(20,21)` from your Firewall / AWS / Azure
- Open incoming port range `30000 - 50000` for passive connections
- Configuration is PITA if you install from source. Avoid.

Install PureFTPd
-----------------
http://download.pureftpd.org/pub/pure-ftpd/doc/README

```sh
sudo apt-get install pure-ftpd-mysql
```

Install PureFTPd WebUI
----------------------
https://pure-ftpd-webui.org/wiki/Pure-FTPd%20WebUI%20installation

```sql
CREATE DATABASE pureftpd;
GRANT ALL PRIVILEGES ON pureftpd.* TO 'pureftpd'@'localhost' IDENTIFIED BY 'pureftpdpass';
```

```sh
git clone git://github.com/mazay/pure-ftpd-webui.git
cd pure-ftpd-webui/INSTALL
mysql -u root -p pureftpd < pure-ftpd-webui_users-table_0.0.9.sql
mysql -u root -p pureftpd < pure-ftpd-webui_users-table_0.1.1.sql
```

```sql
INSERT INTO userlist (user,pass) VALUES ('admin',md5('adminpass'));
```

```sh
sudo chown -R waww-data:www-data pure-ftpd-webui
```

Create below files under `/etc/pure-ftpd/conf/`
You'll have to create separate file for each config setting

ChrootEveryone -> yes
Daemonize -> yes
VerboseLog -> yes
CreateHomeDir -> yes
PassivePortRange -> 30000 50000
ForcePassiveIP -> WAN IP of Instance

`/etc/pure-ftpd/db/mysql.conf`
```
MYSQLSocket      /var/run/mysqld/mysqld.sock
MYSQLServer     localhost
MYSQLPort       3306
MYSQLUser       pureftpd
MYSQLPassword   pureftpdpass  # <--- Change password here
MYSQLDatabase   pureftpd
MYSQLCrypt      md5
MYSQLGetPW      SELECT Password FROM ftpd WHERE User="\L" AND status="1" AND (ipaccess = "*" OR ipaccess LIKE "\R")
MYSQLGetUID     SELECT Uid FROM ftpd WHERE User="\L" AND status="1" AND (ipaccess = "*" OR ipaccess LIKE "\R")
MYSQLGetGID     SELECT Gid FROM ftpd WHERE User="\L"AND status="1" AND (ipaccess = "*" OR ipaccess LIKE "\R")
MYSQLGetDir     SELECT Dir FROM ftpd WHERE User="\L"AND status="1" AND (ipaccess = "*" OR ipaccess LIKE "\R")
MySQLGetBandwidthUL SELECT ULBandwidth FROM ftpd WHERE User="\L"AND status="1" AND (ipaccess = "*" OR ipaccess LIKE "\R")
MySQLGetBandwidthDL SELECT DLBandwidth FROM ftpd WHERE User="\L"AND status="1" AND (ipaccess = "*" OR ipaccess LIKE "\R")
MySQLGetQTASZ   SELECT QuotaSize FROM ftpd WHERE User="\L"AND status="1" AND (ipaccess = "*" OR ipaccess LIKE "\R")
MySQLGetQTAFS   SELECT QuotaFiles FROM ftpd WHERE User="\L"AND status="1" AND (ipaccess = "*" OR ipaccess LIKE "\R")
```

##### References

https://www.turnkeylinux.org/forum/support/20150205/ftp-server-installation-chrooted-users-mysql-accounts-quotas-web-interface

https://www.howtoforge.com/how-to-compile-pure-ftpd-on-centos-7


Enable verbose log in pureftpd

```sh
echo 'yes' > /etc/pure-ftpd/conf/VerboseLog
```


```
 # !!!!
Set owner for /media/ftp to root:ftpgroup
```



## Backup to Amazon S3

#### Using s3cmd

```sh
sudo apt-get install python-pip
sudo pip install s3cmd
s3cmd sync --skip-existing $BACKUPDIR/weekly/ s3://MYBACKUP/backup/
```

The --skip-existing means it doesn't try to checksum compare the existing files.
If there is a file with that name already, it will just quickly skip it and move on.
There is also --delete-removed option which will remove files not existing locally.

OR

#### Using aws cli tool

```sh
sudo pip install awscli
aws configure
```
```
AWS Access Key ID [None]: XXXXXXXXXXXXXXX
AWS Secret Access Key [None]: XXXXXXXXX/BBBBBBBBB/AAAAAAAAAAAA
Default region name [None]: us-west-2
Default output format [None]: json
```

```sh
ls  ~/.aws
```


```sh
aws s3 sync --dryrun . s3://mybucket
aws s3 sync . s3://mybucket
```

##### Create a cron job to run sync

`~/backuptos3.sh`

```sh
# Cron test script
*/5 * * * * echo "$(date)" >> /home/ubuntu/now
## save current date to now every 5 minutes
```

```sh
sudo chown ubuntu:ubuntu ~/backuptos3.sh
```

```sh
echo "========== BACKUP STARTED ==========" >> /home/ubuntu/backup_log
echo $(date) >> /home/ubuntu/backup_log
/usr/local/bin/aws s3 sync /media/ftp s3://mybucket >> /home/ubuntu/backup_log
echo "============ DONE ============" >> /home/ubuntu/backup_log
```

```sh
sudo crontab -e -u ubuntu
```

```
# Run every 5 minute for testing
*/5 * * * * /home/ubuntu/backuptos3.sh

# Run everyday at 2PM and 8PM
0 14,20 * * * /home/ubuntu/backuptos3.sh
```

#### Misc Commands

```sh
sudo apt-get install libuser

# List users in group
sudo lid -g ftpgroup

# Add user ubuntu to ftpgroup
sudo usermod -a -G ftpgroup ubuntu
id ubuntu
```


#### Installing from source. Avoid.

```sh
cd ~
wget ftp://ftp.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-1.0.42.tar.gz
tar -xvzf pure-ftpd-1.0.42.tar.gz
cd pure-ftpd-1.0.42
```

###### Make Install

```sh
sudo apt-get install gcc make libc6-dev libmysqlclientdev
./configure --with-mysql --with-virtualchroot --with-quotas --with-welcomemsg --with-ftpwho
make install-strip
```

Create a specific, unprivileged user and group called _pure-ftpd, without any valid shell.
Don't use this for anything else, including FTP virtual users.

```sh
groupadd _pure-ftpd
useradd -g _pure-ftpd -d /var/empty -s /etc _pure-ftpd
```

This file is not used.
Instead individual files under `/etc/pure-ftpd/conf/` are used.

`/etc/pure-ftpd/pure-ftpd.conf`
```
############################################################
#                                                          #
#         Configuration file for pure-ftpd wrappers        #
#                                                          #
############################################################

ChrootEveryone              yes
BrokenClientsCompatibility  no
MaxClientsNumber            50
Daemonize                   yes
MaxClientsPerIP             8
VerboseLog                  yes
DisplayDotFiles             no
AnonymousOnly               no
NoAnonymous                 yes
SyslogFacility              ftp
FortunesFile              /etc/pure-ftpd/cookie
DontResolve                 yes
MaxIdleTime                 15
# LDAPConfigFile                /etc/pureftpd-ldap.conf
MySQLConfigFile               /etc/pure-ftpd/mysql.conf
# PGSQLConfigFile               /etc/pureftpd-pgsql.conf
# PureDB                        /etc/pureftpd.pdb
# ExtAuth                       /var/run/ftpd.sock
# PAMAuthentication             yes
# UnixAuthentication            yes
LimitRecursion              10000 8
AnonymousCanCreateDirs      no
# MaxLoad                     4
# PassivePortRange          30000 50000
# ForcePassiveIP                192.168.0.1
# AnonymousRatio                1 10
# UserRatio                 1 10
AntiWarez                   yes
# Bind                      127.0.0.1,21
# AnonymousBandwidth            8
# UserBandwidth             8
Umask                       133:022
# MinUID                      2001
AllowUserFXP                no
AllowAnonymousFXP           no
ProhibitDotFilesWrite       no
ProhibitDotFilesRead        no
AutoRename                  no
AnonymousCantUpload         no
# TrustedIP                  10.1.1.1
# LogPID                     yes
# AltLog                     clf:/var/log/pureftpd.log
# AltLog                     stats:/var/log/pureftpd.log
# AltLog                     w3c:/var/log/pureftpd.log
NoChmod                     yes
KeepAllFiles                yes
CreateHomeDir               yes
# Quota                       1000:10
PIDFile                     /var/run/pure-ftpd.pid
# CallUploadScript yes
# MaxDiskUsage               99
# NoRename                  yes
CustomerProof              yes
# PerUserLimits            3:20
# NoTruncate               yes
# TLS                      1
IPV4Only                 yes
# IPV6Only                 yes
FileSystemCharset       utf8
ClientCharset           cp1251
```