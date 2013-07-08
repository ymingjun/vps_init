#! /bin/sh
PID_FILE="/data/nginx/logs/nginx.pid"
CMD="/data/script/nginx.sh restart"

if [ ! -e $PID_FILE ] ||
   [ ! -s $PID_FILE ] || 
   [ ! -e /proc/`cat $PID_FILE`/status ]; then
   $CMD
fi
