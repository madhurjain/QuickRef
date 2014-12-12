# VPS Setup Guide
___
## Basic Server Setup

### Setup the hostname
```sh
echo "plato" > /etc/hostname
hostname -F /etc/hostname
/etc/hosts
127.0.0.1 localhost.localdomain localhost 
12.34.56.78 plato.example.com plato
```
[ref](http://library.linode.com/getting-started#sph_setting-the-hostname)

### Set Timezone
```sh
dpkg-reconfigure tzdata
```

### Update and Upgrade packages
```sh
sudo apt-get update
sudo apt-get upgrade
```

### Enable add-apt-repository
(requied only on Ubuntu 12.04)
```sh
sudo apt-get install python-software-properties
```

### IP Tables
```sh
sudo vim /etc/iptables.firewall.rules
```

```
*filter

# Allow all loopback (lo0) traffic and drop all traffic to 127/8 that doesn't use lo0
-A INPUT -i lo -j ACCEPT
-A INPUT -d 127.0.0.0/8 -j REJECT

# Accept all established inbound connections
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow all outbound traffic - you can modify this to only allow certain traffic
-A OUTPUT -j ACCEPT

# Allow HTTP and HTTPS connections from anywhere (the normal ports for websites and SSL).
-A INPUT -p tcp --dport 80 -j ACCEPT
-A INPUT -p tcp --dport 443 -j ACCEPT

# Allow SSH connections
-A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT

# Allow SMTP traffic
-A INPUT -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT
-A OUTPUT -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT

# Allow IMAPS traffic
-A INPUT -p tcp --dport 993 -m state --state NEW,ESTABLISHED -j ACCEPT
-A OUTPUT -p tcp --sport 993 -m state --state ESTABLISHED -j ACCEPT

# Allow ping
-A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Log iptables denied calls
-A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7

# Drop all other inbound - default deny unless explicitly allowed policy
-A INPUT -j DROP
-A FORWARD -j DROP

COMMIT
```

```sh
sudo vim /etc/network/if-pre-up.d/firewall
#!/bin/sh
/sbin/iptables-restore < /etc/iptables.firewall.rules
sudo chmod +x /etc/network/if-pre-up.d/firewall
```
___

## Essentials

### Installing nginx with PHP and MySQL
```sh
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update
sudo apt-get install nginx php5-fpm php5-cli php5-curl php5-mcrypt git
sudo apt-get install mysql-server php5-mysql

sudo vim /etc/php5/fpm/php.ini
set cgi.fix_pathinfo=0
sudo php5enmod mcrypt
sudo service php5-fpm restart
```

### Installing phpMyAdmin

```sh
sudo apt-get install phpmyadmin
```
- Click Ok without selecting any server
- Select No

(if required. For C compiler)

```sh
sudo apt-get install build-essential
```

### Installing Laravel
```sh
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

### Installing NodeJS
```sh
wget http://nodejs.org/dist/v0.10.24/node-v0.10.24.tar.gz
tar xvfz node-v0.8.18.tar.gz
cd node-v0.8.18
./configure
make
sudo make install
```

### Installing redis
```sh
wget http://download.redis.io/redis-stable.tar.gz
tar xvfz redis-stable.tar.gz
cd redis-stable
make
sudo make install
```

Setup Redis
http://redis.io/topics/quickstart


### Installing MongoDB
```sh
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | tee -a /etc/apt/sources.list.d/10gen.list
apt-get -y update
apt-get -y install mongodb-10gen
```

[ref](https://www.digitalocean.com/community/articles/how-to-install-mongodb-on-ubuntu-12-04)

### Installing PostgreSQL

```sh
sudo apt-get install postgresql-9.3 postgresql-9.3-postgis-2.1 postgresql-contrib
sudo apt-get install libpq-dev build-essential
```

http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS21UbuntuPGSQL93Apt

Don’t add this precise repo on Ubuntu 14.04
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list'

wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update

### Installing Python pip / virtualenv / uwsgi / django

```sh
sudo apt-get install python-pip 
```
or
```sh
sudo easy_install pip
```

```sh
pip install virtualenv
virtualenv env
source ~/env/bin/activate
pip install django
deactivate
sudo apt-get install python2.7-dev
pip install uwsgi
```

[ref](http://uwsgi-docs.readthedocs.org/en/latest/tutorials/Django_and_nginx.html)

___

## Other essential stuff


```sh
sudo apt-get install git
```

### Dependencies for monit

sudo apt-get install libpam0g-dev
sudo apt-get install libssl-dev
sudo apt-get install libcurl4-openssl-dev

still throwing SSL error ?

http://thinkinginsoftware.blogspot.in/2012/09/today-we-got-weird-error-in-one-of.html

OR

./configure --without-ssl