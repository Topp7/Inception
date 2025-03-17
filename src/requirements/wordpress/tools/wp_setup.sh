#!/bin/bash

WP_PATH="/var/www/html/$DOMAIN_NAME/public_html"

if ! [ -d "$WP_PATH" ]; then
		echo "Download WordPress files to the Path"
		mkdir -p "$WP_PATH"
		chown -R www-data:www-data /var/www/html/$DOMAIN_NAME/public_html
		chmod -R 755 /var/www/html/$DOMAIN_NAME/public_html
		wp core download --path="$WP_PATH" --allow-root
fi

mkdir -p /run/php
chown -R www-data:www-data /run/php
chown -R 755 /run/php

if ! /usr/sbin/php-fpm7.4 --version; then
	echo "PHP-FPM not found.. exiting!"
	exit 1
fi

cd $WP_PATH

if [ ! -f wp-config.php ]; then
	echo "creating config.php"
	wp config create
			--dbname=$DB_NAME \
			--dbuser=$DB_USER \
			--dbpass=$DB_USER_PW \
			--dbhost=$DB_HOST \
			--path=$WP_PATH \
			--allow-root

	echo "WordPress: Checking DB"
	until wp db check --allow-root; do
			echo "Waiting for MariaDB.."
			sleep 4
	done

	wp core install --url=$DOMAIN_NAME \
			--title='42 Inception' \
			--admin_user=$WP_ADMIN_USER \
			--admin_password=$WP_ADMIN_PW \
			--admin_email=$WP_ADMIN_MAIL \
			--allow-root

	wp user create $WP_USER $WP_USER_MAIL \
			--user_pass=$WP_USER_PW \
			--allow-root
fi

exec php-fpm7.4 -F
