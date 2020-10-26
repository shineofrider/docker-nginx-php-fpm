FROM tiredofit/nginx:alpine-3.5
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Default Runtime Environment Variables
ENV COMPOSER_VERSION=1.10.16 \
    ZABBIX_HOSTNAME=nginx-php-fpm-app \
    ENABLE_SMTP=TRUE \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE

### Dependency Installation
RUN set -x && \
    apk update && \
    apk add -t .php-fpm-run-deps \
          ca-certificates \
          imagemagick \
          mariadb-client \
          php7-apcu \
          php7-bcmath \
          php7-bz2 \
          php7-calendar \
          php7-common \
          php7-ctype \
          php7-curl \
          php7-dba \
          php7-dom \
          php7-embed \
          php7-enchant \
          php7-exif \
          php7-fpm \
          php7-ftp \
          php7-gd \
          php7-gettext \
          php7-gmp \
          php7-iconv \
          php7-imap \
          php7-intl \
          php7-json \
          php7-ldap \
          php7-litespeed \
          php7-mbstring \
          php7-mcrypt \
          php7-mysqli \
          php7-mysqlnd \
          php7-odbc \
          php7-opcache \
          php7-openssl \
          php7-pcntl \
          php7-pdo \
          php7-pgsql \
          php7-phar\
          php7-posix \
          php7-pspell \
          php7-session \
          php7-shmop \
          php7-snmp \
          php7-soap \
          php7-sockets \
          php7-sqlite3 \
          php7-tidy \
          php7-wddx \
          php7-xdebug \
          php7-xml \
          php7-xmlreader \
          php7-xmlrpc \
          php7-xml \
          php7-zip \
          php7-zlib \
          postgresql-client \
          && \
    \
    ### PHP7 Setup
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini && \
    ln -s /sbin/php-fpm7 /sbin/php-fpm && \
    ln -s /usr/bin/php7 /sbin/php && \
    rm -rf /etc/logrotate.d/php-fpm7 && \
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
