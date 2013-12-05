#! /bin/bash
version=v0.10.22
node=node-$version
if [ ! -d $node ]; then
    wget http://nodejs.org/dist/${version}/${node}.tar.gz
    tar xvf ${node}.tar.gz
fi
cd ${node}

./configure
make && make install
