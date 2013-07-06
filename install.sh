#!/bin/bash

#add op group
groupadd op
useradd -M -r -s /usr/sbin/nologin mongo
useradd -M -r -s /usr/sbin/nologin php
useradd -M -r -s /usr/sbin/nologin nginx

mkdir -p /data

mkdir -p /data/nginx
mkdir -p /data/nginx/conf
mkdir -p /data/nginx/logs

mkdir -p /data/mongo
mkdir -p /data/mongo/conf
mkdir -p /data/mongo/logs

mkdir -p /data/php
mkdir -p /data/php/conf
mkdir -p /data/php/logs


mkdir -p /data/firewall
mkdir -p /data/crons
mkdir -p /data/script

core_num=`cat /proc/cpuinfo | grep "processor" | wc -l`
let j=$core_num+1

apt-get -y update
apt-get -y dist-upgrade
apt-get -y install unzip make gcc-4.6 g++-4.6 build-essential\
libxml2-dev libssl-dev pkg-config \
libbz2-dev libcurl3-dev libvpx-dev \
libjpeg-dev libpng-dev libxmp-dev \
libfreetype6-dev libt1-dev libgmp-dev \
libicu-dev libbison-dev libmcrypt-dev \
libpspell-dev bison libedit-dev \
librecode-dev libmm-dev libtidy-dev \
libxslt-dev scons libpcre3-dev \
libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev \
libatomic-ops-dev libperl-dev autoconf \
python-software-properties git


#config gcc to gcc-46
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 40
#config g++ to g++-46
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 40

src=`pwd`

#php 5.5
#http://cn1.php.net/distributions/php-5.5.0.tar.bz2
php=php-5.5.0
wget "http://cn1.php.net/distributions/${php}.tar.bz2"
tar xvf ${php}.tar.bz2
cd ${php}

./configure \
--enable-libgcc \
--enable-fpm \
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

make -j ${j} & make install

#####mongodb#####
cd ${src}
mongo=mongodb-src-r2.4.5
wget http://downloads.mongodb.org/src/${mongo}.tar.gz
tar xvf ${mongo}.tar.gz
cd ${mongo}
scons all
scons --full install

#####nginx######
cd ${src}
nginx=nginx-1.5.2
wget http://nginx.org/download/${nginx}.tar.gz
tar xvf ${nginx}.tar.gz
cd ${nginx}

./configure \
--sbin-path=/usr/local/sbin/nginx \
--conf-path=/data/nginx/conf/nginx.conf \
--pid-path=/data/nginx/logs/nginx.pid \
--error-log-path=/data/nginx/logs/error.log \
--http-log-path=/data/nginx/logs/access.log \
--without-select_module \
--without-poll_module \
--with-file-aio \
--with-http_ssl_module \
--with-http_spdy_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module  \
--with-http_image_filter_module \
--with-http_geoip_module \
--with-http_sub_module \
--with-http_dav_module  \
--with-http_flv_module  \
--with-http_mp4_module  \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_degradation_module \
--with-http_stub_status_module \
--with-http_perl_module \
--with-mail \
--with-mail_ssl_module \
--with-google_perftools_module \
--with-pcre  \
--with-pcre-jit \
--with-libatomic 

make -j ${j} & make install

###nodejs####
cd ${src}
node=node-v0.10.12
wget http://nodejs.org/dist/v0.10.12/${node}.tar.gz
tar xvf ${node}.tar.gz
cd ${node}

./configure
make -j ${j} & make install


###
cd ${src}
cp -rf data/* /data/*
chown -R root:op /data
chmod -R 775 /data
chmod -R g+s /data

chown -R mongo /data/mongo
chown -R php /data/php
chown -R nginx /data/nginx


############
pecl install mongo
