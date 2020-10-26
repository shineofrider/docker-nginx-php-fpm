FROM tiredofit/nginx:debian
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Default Runtime Environment Variables
ENV COMPOSER_VERSION=1.10.16 \
    ZABBIX_HOSTNAME=nginx-php-fpm-app \
    ENABLE_SMTP=TRUE \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE

### Dependency Installation
RUN set -x && \
    curl https://packages.sury.org/php/apt.gpg | apt-key add && \
    echo "deb https://packages.sury.org/php/ buster main" | sudo tee /etc/apt/sources.list.d/php.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
               ca-certificates \
               mariadb-client \
               #php7.4 \
               php7.4-bcmath \
               php7.4-bz2 \
               php7.4-cli \
               php7.4-common \
               php7.4-curl \
               php7.4-enchant \
               php7.4-fpm \
               php7.4-gd \
               php7.4-imap \
               php7.4-intl \
               php7.4-json \
               php7.4-ldap \
               php7.4-mbstring \
               php7.4-mysql \
               php7.4-odbc \
               php7.4-opcache \
               php7.4-pspell \
               php7.4-readline \
               php7.4-soap \
               php7.4-sqlite3 \
               php7.4-tidy \
               php7.4-xdebug \
               php7.4-xml \
               php7.4-xmlrpc \
               php7.4-xsl \
               php7.4-zip \
               postgresql-client \
               && \
    \
    ### PHP7 Setup
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/cli/php.ini && \
    ln -s /usr/sbin/php-fpm7.4 /usr/sbin/php-fpm && \
    rm -rf /etc/logrotate.d/php7.4-fpm && \
    \
    ### Install PHP Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} && \
    \
    ### Cleanup
    mkdir -p /var/log/nginx && \
    rm -rf /var/lib/apt/lists/* /root/.gnupg /var/log/*

### Networking Configuration
EXPOSE 9000

### Files Addition
ADD install /
