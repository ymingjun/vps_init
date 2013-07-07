#!/bin/bash

MONGOHOME="/usr/local"
CONFIGFILE="/data/mongo/conf/mongo.conf"
DBPATH=`awk -F= '/^dbpath[ ]*=/{print $2}' "$CONFIGFILE" |sed -e 's/^[ ]*//'`
COMMAND="$MONGOHOME/bin/mongod"
OPT="--config $CONFIGFILE"
USER="mongo"
mongod=${MONGOD-$COMMAND}

usage() {
  echo "Usage: $0 {start|stop|restart|status}"
  exit 0
}

if [ $# != 1 ]; then
  usage
fi

start()
{
  echo -n $"Starting mongod: "
  sudo -u $USER $COMMAND $OPT
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] 
}

stop()
{
  echo -n $"Stopping mongod: "
  kill `cat ${DBPATH}/mongod.lock`
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] 
}
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  * )
    usage
    ;;
esac
