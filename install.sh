#!/bin/bash

screen

#add op group
groupadd op
useradd -M -r -s /usr/sbin/nologin mongo
useradd -M -r -s /usr/sbin/nologin php-fpm
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

apt-get -y update
apt-get -y dist-upgrade
apt-get -y install unzip make gcc-4.6 g++-4.6 build-essential \
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
########php#####
bash ./php_init.sh
#####mongodb#####
cd ${src}
bash ./mongo_init.sh
#####nginx######
cd ${src}
bash ./nginx_init.sh
###nodejs####
cd ${src}
bash ./node_init.sh
###
cd ${src}
cp -rf data/* /data/
chown -R root:op /data
chmod -R 775 /data
chmod -R g+s /data

chown -R mongo /data/mongo
chown -R php-fpm /data/php
chown -R nginx /data/nginx

