#!/bin/bash

short=${1:0:7}

# download code and unpack:
wget https://github.com/bstandley/mezurit2/archive/${1}.tar.gz
tar xf ${1}.tar.gz

# fix version: (TODO - check for release tag)
sed "s/version=.*/version=${short}/" -i mezurit2-${1}/configure

# build:
args="--mingw --win32path=../win32 --gtkwin32path=../win32"
cd mezurit2-${1}

./configure ${args} --driver=nidaqmx
make install_local
zip -r ../Mezurit2-${short}-DAQmx.zip Mezurit2
rm -r Mezurit2
make clean

./configure ${args} --driver=nidaqmx --disable-gpib
make install_local
zip -r ../Mezurit2-${short}-DAQmx-nogpib.zip Mezurit2
rm -r Mezurit2
make clean

./configure ${args} --driver=nidaq
make install_local
zip -r ../Mezurit2-${short}-TDAQ.zip Mezurit2
rm -r Mezurit2
make clean

./configure ${args} --driver=nidaq --disable-gpib
make install_local
zip -r ../Mezurit2-${short}-TDAQ-nogpib.zip Mezurit2
rm -r Mezurit2
make clean

./configure ${args} --driver=none --disable-gpib
make install_local
zip -r ../Mezurit2-${short}-dummy.zip Mezurit2
rm -r Mezurit2
make clean
