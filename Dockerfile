# vim:set ft=dockerfile:
FROM alpine

LABEL maintainer="docker-dario@neomediatech.it"

RUN apk update; apk upgrade ; apk add --no-cache tzdata; cp /usr/share/zoneinfo/Europe/Rome /etc/localtime
RUN apk add --no-cache tini mariadb mariadb-client pwgen
RUN rm -rf /usr/local/share/doc /usr/local/share/man

RUN mkdir -p /data; chmod 777 /data 
COPY init.sh /
COPY my.cnf  /etc/mysql/
RUN chmod +x /init.sh

EXPOSE 3306

#CMD ["tini", "--", "exim", "-bd"]
#ENTRYPOINT ["tini", "--", "/init.sh"]
ENTRYPOINT ["/init.sh"]

