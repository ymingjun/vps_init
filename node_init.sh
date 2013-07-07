#! /bin/bash
node=node-v0.10.12
wget http://nodejs.org/dist/v0.10.12/${node}.tar.gz
tar xvf ${node}.tar.gz
cd ${node}

./configure
make & make install


