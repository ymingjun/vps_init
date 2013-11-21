#!/bin/bash
cd /data/ot/
COUNT=`forever list | wc -l`
CMD="forever start -c coffee   src/main.coffee"

if [ $COUNT -ne 3 ]; then
   forever stopall
   $CMD
fi
