FROM debian:bullseye

RUN apt-get update -y && apt-get install -y curl php-fpm php-mysql mariadb-client && \
	curl -O https://raw.githubuserconsent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && wp cli update

COPY ./conf/wp.conf /etc/php/7.4/fpm/pool.d/

COPY --chmod=755 ./tools/wp_setup.sh /usr/local/bin/wp_setup.sh

RUN chmod +x /usr/local/bin/wp_setup.sh

ENTRYPOINT [ "/usr/local/bin/wp_setup.sh" ]
