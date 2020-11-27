FROM tiredofit/nginx:alpine-edge
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

ENV COMPOSER_VERSION=1.10.16 \
    ZABBIX_HOSTNAME=nginx-php-fpm-app \
    ENABLE_SMTP=TRUE \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE

### Dependency Installation
RUN set -x && \
    echo 'http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && \
    apk add -t .php-fpm-run-deps \
          ca-certificates \
          imagemagick \
          mariadb-client \
          php8-bcmath \
          php8-bz2 \
          php8-calendar \
          php8-cli \
          php8-common \
          php8-ctype \
          php8-curl \
          php8-dba \
          php8-dom \
          php8-embed \
          php8-enchant \
          php8-exif \
          php8-ffi \
          php8-fileinfo \
          php8-fpm \
          php8-ftp \
          php8-gd \
          php8-gettext \
          php8-gmp \
          php8-iconv \
          php8-imap \
          php8-intl \
          php8-json \
          php8-ldap \
          php8-litespeed \
          php8-mbstring \
          php8-mysqli \
          php8-mysqlnd \
          php8-odbc \
          php8-opcache \
          php8-openssl \
          php8-pcntl \
          php8-pdo \
          php8-pdo_dblib \
          php8-pdo_mysql \
          php8-pdo_odbc \
          php8-pdo_pgsql \
          php8-pdo_sqlite \
          php8-pecl-apcu \
          php8-pecl-igbinary \
          php8-pecl-mongodb \
          php8-pecl-redis \
          php8-pecl-xdebug \
          php8-pgsql \
          php8-phar\
          php8-posix \
          php8-pspell \
          php8-session \
          php8-shmop \
          php8-simplexml \
          php8-snmp \
          php8-soap \
          php8-sockets \
          php8-sodium \
          php8-sqlite3 \
          php8-tidy \
          php8-tokenizer \
          php8-xml \
          php8-xmlreader \
          php8-xmlwriter \
          php8-zip \
          php8-zlib \
          postgresql-client \
          && \
    \
    ### php8 Setup
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php8/php.ini && \
    ln -s /usr/sbin/php-fpm8 /sbin/php-fpm && \
    ln -s /usr/bin/php8 /sbin/php && \
    rm -rf /etc/logrotate.d/php-fpm8 && \
    \
    ### Install PHP Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} && \
    \
### Cleanup
    rm -rf /var/cache/apk/*

### Networking Configuration
EXPOSE 9000

### Files Addition
ADD install /
