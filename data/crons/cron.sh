#!/bin/bash
export PATH=$PATH:/usr/local/sbin:/usr/local/bin
/data/crons/mongod.sh > /data/crons/logs/mongod.log
/data/crons/nginx.sh > /data/crons/logs/nginx.log
/data/crons/php-fpm.sh > /data/crons/logs/php-fpm.log
/data/crons/ot.sh > /data/crons/logs/ot.log
