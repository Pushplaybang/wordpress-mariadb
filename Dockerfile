FROM alpine:3.4
MAINTAINER Paul van Zyl <pushplaybang@gmail.com>

RUN apk add --no-cache \
        bash \
        tzdata \
        pwgen \
        mariadb \
        mariadb-client

ENV BASH_SOURCE /bin/bash

RUN mkdir -p /var/run/mysqld
RUN chown 100:101 /var/run/mysqld

RUN mkdir /docker-entrypoint-initdb.d
COPY my.cnf /etc/mysql/my.cnf
COPY docker-entrypoint.sh /usr/local/bin/

WORKDIR /var/lib/mysql
VOLUME /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
