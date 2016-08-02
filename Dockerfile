
# docker build -t floatapp/docker-php-apache:5.x-1.x .

FROM php:5.5-apache
MAINTAINER lars@float.com

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev
RUN docker-php-ext-install -j$(nproc) iconv mcrypt && \
	docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install pdo_mysql

RUN a2enmod rewrite

# redis (phpredis):
COPY phpredis-x86_64.deb .
RUN dpkg --install phpredis-x86_64.deb && \
	cp /etc/php5/apache2/conf.d/redis.ini /usr/local/etc/php/conf.d/

COPY php.ini /usr/local/etc/php

####
# docker-php-ext-configure
# docker-php-ext-install
# docker-php-ext-enable
#
# Possible values for ext-name:
# bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl json ldap mbstring mcrypt mssql mysql mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard sybase_ct sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip