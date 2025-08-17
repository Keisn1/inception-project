FROM alpine:3.22

RUN apk update && \
    apk add --no-cache mariadb mariadb-client

# all permissions
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 700 /var/run/mysqld

# settings for mariaDB
RUN { echo '[mysqld]'; \
    echo 'skip-host-cache'; \
    echo 'skip-name-resolve'; \
    echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/network.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
    /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

USER mysql

COPY tools/create_db.sh .

ENTRYPOINT  ["sh", "create_db.sh"]
CMD ["/usr/bin/mysqld", "--skip-log-error"]
