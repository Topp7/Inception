FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -sha256 -nodes -days 365 \
		-newkey rsa:2048 \
		-keyout /etc/ssl/private/nginx-selfsigned.key \
		-out /etc/ssl/certs/nginx-selfsigned.crt \
		-subj "/C=DE/ST=BW/L=HB/0=42/OU=Student/CN=stopp.42.fr"

COPY ./conf/config /etc/nginx/sites-available/stopp.42.fr

RUN ln -s /etc/nginx/sites-available/stopp.42.fr /etc/nginx/sites-enabled/

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
