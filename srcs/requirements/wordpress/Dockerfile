FROM alpine:3.21

ARG PHP_VERSION=84 \
    DB_NAME \
    DB_USER \
    DB_PASS

ENV WP_ADMIN_USER=${WP_ADMIN_USER} \
    WP_ADMIN_PASS=${WP_ADMIN_PASS} \
    WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL} \
    WP_USER=${WP_USER} \
    WP_USER_PASS=${WP_USER_PASS} \
    WP_USER_EMAIL=${WP_USER_EMAIL}

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-phar \
    wget \
    unzip \
    curl \
    netcat-openbsd

RUN ln -s /usr/bin/php${PHP_VERSION} /usr/bin/php

# Download and install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    # sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    # sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www

RUN adduser -D -s /bin/sh wordpress

RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

COPY ./requirements/wordpress/conf/wp-config-create.sh .
COPY ./requirements/wordpress/conf/wp-setup.sh .
RUN chmod +x wp-setup.sh
RUN chown wordpress:wordpress wp-setup.sh

RUN sh wp-config-create.sh && rm wp-config-create.sh

# Set ownership - WordPress process needs to own the files
RUN chown -R wordpress:wordpress /var/www/wp-content

# Set proper permissions
# Directories: 755 (owner can read/write/execute, others can read/execute)
# Files: 644 (owner can read/write, others can read only)
RUN find /var/www/wp-content -type d -exec chmod 755 {} \; && \
    find /var/www/wp-content -type f -exec chmod 644 {} \;

RUN mkdir -p /var/log/php${PHP_VERSION} && \
    chown -R wordpress:wordpress /var/log/php${PHP_VERSION}

USER wordpress

CMD ["sh", "-c", "./wp-setup.sh && /usr/sbin/php-fpm84 -F"]
