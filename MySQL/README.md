# MySQL
https://www.mysql.com/

## Install by Binary Package
https://dev.mysql.com/downloads/mysql/
```
cd /usr/local
tar zxvf /path/to/mysql-VERSION-OS.tar.gz
ln -s mysql-VERSION-OS mysql

# crate MySQL user adn group
groupadd mysql
useradd -r -g mysql -s /bin/false mysql

# configure and initiialize data directory
cd /usr/local/mysql
mkdir data
chown mysql:mysql data
chmod 750 data
bin/mysqld --initialize --user=mysql --datadir=/usr/local/mysql/data

# create and configure my.cnf [example]
[mysqld]
datadir=/usr/local/mysql/data
socket=/tmp/mysql.sock
port=3306
user=mysql

# start MySQL server
/user/local/mysql/support-files/mysql.server start

# post-install setup
/usr/local/mysql/bin/mysql_secure_installation
```

## Install with Docker
```
docker pull mysql
docker run --name mysql_container -e MYSQL_ROOT_PASSWORD=your_secure_password -p 3306:3306 -d mysql
```
