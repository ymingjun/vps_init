#! /bin/bash

mongo=mongodb-src-r2.4.5
wget http://downloads.mongodb.org/src/${mongo}.tar.gz
tar xvf ${mongo}.tar.gz
cd ${mongo}
scons all
scons --full install


