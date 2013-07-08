#! /bin/sh
PID_FILE="/data/mongo/logs/mongod.pid"
CMD="/data/script/mongod.sh restart"

if [ ! -e $PID_FILE ] ||
   [ ! -s $PID_FILE ] || 
   [ ! -e /proc/`cat $PID_FILE`/status ]; then
   $CMD
fi
