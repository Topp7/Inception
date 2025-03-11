#!bin/bash

# Creating a directory for mariadb
mkdir -p /run/mysql
chown -R mysql:mysql /run/mysql

# MariaDB data
if [ ! -d "var/lib/mysql/mysql" ]; then
	echo -e "Starting Database!"
	mysqld --initialize --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe --user=mysql &

until mysqladmin -u root ping -h localhost --silent;
do	echo -e "Waiting for MariaDB setup."
	sleep 2
done

echo -e "MariaDB started!"

#Changing PW
TEMP_PASS=$(grep 'temporary password' "/var/log/mysql.log" | awk '{print $NF}')
mysql -u root -p"${TEMP_PASS}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB-ROOT-PW}';"

#DataBase check
DATABASE=$(mysql -u root -p${DB-ROOT-PW} -e "SHOW DATABASE LIKE '${DB-NAME}';" | grep "${DB-NAME}")
if [ -z "$DATABASE" ];
then	echo -e "Creating Database."
		mysql -u root -p{DB-ROOT-PW} -e "CREATE DATABASE ${DB-NAME};"
		mysql -u root -p{DB-ROOT-PW} -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB-USER-PW}';"
		mysql -u root -p{DB-ROOT-PW} -e "GRANT ALL PRIVILEGES ON ${DB-NAME}.* TO '${DB-USER}'@'%';"
		mysql -u root -p{DB-ROOT-PW} -e "FLUSH PRIVILEGES;"
fi

echo -e "MariaDB setup done"

