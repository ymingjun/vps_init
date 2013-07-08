#! /bin/bash
node=node-v0.10.12
if [ ! -d $node ]; then
    wget http://nodejs.org/dist/v0.10.12/${node}.tar.gz
    tar xvf ${node}.tar.gz
fi
cd ${node}

./configure
make && make install
