#!/bin/bash

set -e

sudo yum install -y geos-devel json-c-devel proj-devel expat CUnit CUnit-devel
cd /
sudo wget http://download.osgeo.org/gdal/1.11.1/gdal-1.11.1.tar.gz

sudo tar zxf gdal-1.11.1.tar.gz
cd gdal-1.11.1
sudo ./configure
sudo make
sudo make install
sudo sed -i '/LD_LIBRARY_PATH/s/LD_LIBRARY_PATH=/LD_LIBRARY_PATH=\/usr\/local\/lib:/g' /build/install/greenplum_path.sh

source /build/install/greenplum_path.sh
source /build/gpdb/gpAux/gpdemo/gpdemo-env.sh

git clone --shared /workspace/geospatial /build/geospatial
cd /build/geospatial/postgis/build/postgis-2.1.5/
./configure --with-pgconfig=/build/install/bin/pg_config --with-raster --without-topology --prefix=$GPHOME --with-gdalconfig=/usr/local/bin/gdal-config

CFLAGS="-O0 -g3" CXXFLAGS="-O0 -g3" make USE_PGXS=1 all
sudo make install

make check