#!/bin/bash

set -e

sudo yum install -y geos-devel json-c-devel proj-devel expat CUnit CUnit-devel
cd /
sudo wget http://download.osgeo.org/gdal/1.11.1/gdal-1.11.1.tar.gz

sudo tar zxf gdal-1.11.1.tar.gz
cd gdal-1.11.1
sudo ./configure --prefix=$GPHOME
sudo make
sudo make install

source /build/install/greenplum_path.sh
source /build/gpdb/gpAux/gpdemo/gpdemo-env.sh

git clone --shared /workspace/geospatial /build/geospatial
cd /build/geospatial/postgis/build/postgis-2.1.5/
./configure --with-pgconfig=/build/install/bin/pg_config --with-raster --without-topology --prefix=$GPHOME

CFLAGS="-O0 -g3" CXXFLAGS="-O0 -g3" make USE_PGXS=1 all -j5
sudo make install

make check