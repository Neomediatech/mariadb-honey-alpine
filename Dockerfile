# vim:set ft=dockerfile:
FROM alpine:latest

LABEL maintainer="docker-dario@neomediatech.it"

RUN apk update; apk upgrade ; apk add --no-cache tzdata; cp /usr/share/zoneinfo/Europe/Rome /etc/localtime
RUN apk add --no-cache tini mariadb mariadb-client pwgen && \ 
    rm -rf /usr/local/share/doc /usr/local/share/man && \
    mkdir -p /data; chmod 777 /data 

COPY init.sh /
COPY my.cnf  /etc/mysql/
COPY my.cnf  /etc/my.cnf.d/mariadb-server.cnf
RUN chmod +x /init.sh

EXPOSE 3306

ENTRYPOINT ["/init.sh"]
