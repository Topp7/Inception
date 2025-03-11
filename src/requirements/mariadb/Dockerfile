FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.cnf

COPY --chmod=0755 ./tools/mariadb_setup.sh /usr/local/bin/mariadb/setup.sh

CMD ["/usr/local/bin/mariadb_setup.sh"]
