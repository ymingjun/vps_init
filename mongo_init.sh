#! /bin/bash

mongo=mongodb-src-r2.4.8
if [ ! -d $mongo ]; then
    wget http://downloads.mongodb.org/src/${mongo}.tar.gz
    tar xvf ${mongo}.tar.gz
fi
cd ${mongo}


scons all
scons --full install
