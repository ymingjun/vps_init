#! /bin/bash

nginx=nginx-1.5.7
if [ ! -d $nginx ]; then
    wget http://nginx.org/download/${nginx}.tar.gz
    tar xvf ${nginx}.tar.gz
fi
cd ${nginx}

./configure \
--sbin-path=/usr/local/sbin/nginx \
--conf-path=/data/nginx/conf/nginx.conf \
--pid-path=/data/nginx/logs/nginx.pid \
--error-log-path=/data/nginx/logs/error.log \
--http-log-path=/data/nginx/logs/access.log \
--user=nginx \
--group=nginx \
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

make && make install
