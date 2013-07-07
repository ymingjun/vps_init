#!/bin/bash

PID_FILE="/data/nginx/logs/nginx.pid"
COMMAND="nginx"

usage() {
  echo "Usage: $0 {start|stop|restart}"
  exit 0
}

if [ $# != 1 ]; then
  usage
fi

start()
{
  echo -n $"Starting $COMMAND: "
  $COMMAND
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] 
}

stop()
{
  echo -n $"Stopping $COMMAND: "
  kill `cat $PID_FILE`
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
