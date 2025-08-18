FROM alpine:3.21

    # using ARG instead of ENV because ARG will only live during image build
ARG DB_NAME \
    DB_USER \
    DB_PASS \
    DB_ROOT

RUN apk update && \
    apk add --no-cache mariadb mariadb-client

# all permissions
RUN mkdir -p /var/run/mysqld  && \
    chown -R mysql:mysql /var/run/mysqld  && \
    chmod 700 /var/run/mysqld 

# settings for mariaDB
RUN { echo '[mysqld]'; \
    echo 'skip-host-cache'; \
    echo 'skip-name-resolve'; \
    echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/network.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
    /etc/my.cnf.d/mariadb-server.cnf

# setup initial MySQL system
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql

# execute initial sql script (sets up wordpress database)
COPY conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh

USER mysql

EXPOSE 3306

CMD ["/usr/bin/mariadbd", "--skip-log-error"]
