#! /bin/sh
PID_FILE="/data/php/logs/php-fpm.pid"
CMD="/data/script/php-fpm.sh restart"

if [ ! -e $PID_FILE ] ||
   [ ! -s $PID_FILE ] || 
   [ ! -e /proc/`cat $PID_FILE`/status ]; then
   $CMD
fi
