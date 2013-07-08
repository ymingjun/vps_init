#!/bin/bash

#php 5.5
#http://cn1.php.net/distributions/php-5.5.0.tar.bz2
php=php-5.5.0

if [ ! -d $php ]; then
    wget "http://cn1.php.net/distributions/${php}.tar.bz2"
    tar xvf ${php}.tar.bz2
fi
cd ${php}

./configure \
--enable-libgcc \
--enable-fpm \
--with-fpm-user=php-fpm \
--with-fpm-group=php-fpm \
--with-libxml-dir \
--with-openssl \
--with-zlib \
--with-zlib-dir \
--enable-bcmath \
--with-bz2 \
--enable-calendar \
--with-curl \
--enable-exif \
--with-pcre-dir \
--enable-ftp \
--with-gd \
--with-vpx-dir \
--with-jpeg-dir \
--with-png-dir \
--with-xpm-dir \
--with-freetype-dir \
--with-t1lib \
--enable-gd-native-ttf \
--enable-gd-jis-conv \
--with-gettext \
--with-gmp \
--with-mhash \
--enable-intl \
--enable-mbstring \
--with-libmbfl \
--with-onig \
--with-mcrypt \
--with-mysql \
--with-mysql-sock \
--with-mysqli \
--enable-opcache \
--enable-pcntl \
--with-pdo-mysql \
--with-pspell \
--with-libedit \
--with-readline \
--with-recode \
--with-mm \
--enable-shmop \
--enable-sockets \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--with-tidy \
--with-xmlrpc \
--with-iconv-dir \
--with-xsl \
--enable-zip \
--enable-mysqlnd \
--with-pear \
--with-tsrm-pthreads \
--enable-shared \
--enable-static \
--enable-fast-install \
--with-openssl-dir \
--sysconfdir=/data/php/conf \
--with-config-file-path=/data/php/conf 

make && make install

pecl install mongo
