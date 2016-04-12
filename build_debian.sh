#!/bin/bash

short=${1:0:7}

# download code and unpack:
wget https://github.com/bstandley/mezurit2/archive/${1}.tar.gz
mkdir mezurit2-${short}
tar xf ${1}.tar.gz --strip-components=1 -C mezurit2-${short}

# fix version and repack: (TODO - check for release tag)
sed "s/version=.*/version=${short}/" -i mezurit2-${short}/configure
tar cfz mezurit2_${short}.orig.tar.gz mezurit2-${short}

# copy debian files and build:
cp -r debian mezurit2-${short}
cd mezurit2-${short}
debuild -us -uc
