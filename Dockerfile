FROM tiredofit/nginx:alpine-3.8
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
          php5 \
          php5-apcu \
          php5-bcmath \
          php5-bz2 \
          php5-calendar \
          php5-ctype \
          php5-curl \
          php5-dba \
          php5-dom \
          php5-embed \
          php5-enchant \
          php5-exif \
          php5-fpm \
          php5-ftp \
          php5-gd \
          php5-gettext \
          php5-gmp \
          php5-iconv \
          php5-intl \
          php5-imap \
          php5-json \
          php5-ldap \
          #php5-mailparse \
          php5-mcrypt \
          php5-mysqli \
          php5-odbc \
          php5-opcache \
          php5-openssl \
          php5-pcntl \
          php5-pdo \
          php5-pdo_mysql \
          php5-pdo_pgsql \
          php5-pdo_sqlite \
          php5-pgsql \
          php5-phar\
          php5-posix \
          php5-pspell \
          php5-shmop \
          php5-snmp \
          php5-soap \
          php5-sockets \
          php5-sqlite3 \
          php5-wddx \
          php5-xml \
          php5-xmlreader \
          php5-xmlrpc \
          php5-xml \
          php5-zip \
          php5-zlib \
          postgresql-client \
          && \
 \
### Nginx and PHP5 Setup
 sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/php.ini && \
 ln -s /usr/bin/php5 /usr/sbin/php && \
 ln -s /usr/bin/php-fpm5 /usr/sbin/php-fpm && \
 rm -rf /etc/php5/conf.d/opcache.ini && \
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
