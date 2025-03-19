#!bin/bash

# Creating a directory for mariadb
mkdir -p /run/mysql
chown -R mysql:mysql /run/mysql

# MariaDB data
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo -e "Starting Database!"
	mysqld --initialize --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe --user=mysql &

until mysqladmin -u root ping -h localhost --silent; do
		echo -e "Waiting for MariaDB setup."
		sleep 2
done

echo -e "MariaDB started!"

#Changing PW
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PW}';"

#DataBase check
DATABASE=$(mysql -u root -p${DB_ROOT_PW} -e "SHOW DATABASES LIKE '${DB_NAME}';" | grep "${DB_NAME}")
if [ -z "$DATABASE" ];
then	echo -e "Creating Database."
		mysql -u root -p${DB_ROOT_PW} -e "CREATE DATABASE ${DB_NAME};"
		mysql -u root -p${DB_ROOT_PW} -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PW}';"
		mysql -u root -p${DB_ROOT_PW} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
		mysql -u root -p${DB_ROOT_PW} -e "FLUSH PRIVILEGES;"
fi

echo -e "MariaDB setup done"

mysqladmin -u root -p${DB_ROOT_PW} shutdown
exec mysqld_safe --user=mysql
