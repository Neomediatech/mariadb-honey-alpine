# vim:set ft=dockerfile:
FROM alpine:3.9

LABEL maintainer="docker-dario@neomediatech.it"

RUN apk update && apk upgrade && apk add --no-cache tzdata && cp /usr/share/zoneinfo/Europe/Rome /etc/localtime && \
    apk add --no-cache tini mariadb mariadb-client pwgen bash && \ 
    rm -rf /usr/local/share/doc /usr/local/share/man && \
    mkdir -p /data && chmod 777 /data 

COPY init.sh /
COPY my.cnf  /etc/mysql/
COPY my.cnf  /etc/my.cnf.d/mariadb-server.cnf
RUN chmod +x /init.sh

EXPOSE 3306

ENTRYPOINT ["/init.sh"]
