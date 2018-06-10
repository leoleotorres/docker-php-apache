##
# dockerized php with PHP extensions for Yii v1
#
# docker build -t floatapp/docker-php-apache:dev-$(~/scripts/git-log-count.sh) .
# docker build -t floatapp/docker-php-apache:$(~/scripts/git-log-count.sh) .
#
###

FROM php:7.1.18-apache-stretch
LABEL maintainer="tech@float.com"

# php-related updates:
RUN apt-get update && apt-get install -y \
    bzip2 nano wget zip unzip git \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    libmcrypt-dev libzzip-dev zziplib-bin zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install iconv mcrypt zip \
    && docker-php-ext-install pdo_mysql bcmath
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install -j$(nproc) gd

RUN pecl install redis-4.0.2 \
    && docker-php-ext-enable redis
# opcache:
RUN docker-php-ext-install opcache
RUN a2enmod rewrite

COPY etc-php/php.ini /usr/local/etc/php

# Composer:
WORKDIR /var/www/html
RUN chown -R www-data /var/www
COPY composer-install.sh /tmp
RUN /tmp/composer-install.sh && cp /usr/local/bin/composer.phar /usr/local/bin/composer

USER www-data
RUN composer self-update
RUN composer global require "fxp/composer-asset-plugin:^1.3.1"

# build composer vendor files

COPY composer.json /var/www/html/composer.json
COPY composer.lock /var/www/html/composer.lock
RUN /usr/local/bin/composer install -o

USER root
####
# docker-php-ext-configure
# docker-php-ext-install
# docker-php-ext-enable
#
# Possible values for ext-name:
#   bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash
#   iconv imap interbase intl json ldap mbstring mcrypt mssql mysql mysqli oci8 odbc opcache pcntl
#   pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell
#   readline recode reflection session shmop simplexml snmp soap sockets spl standard sybase_ct sysvmsg
#   sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip
