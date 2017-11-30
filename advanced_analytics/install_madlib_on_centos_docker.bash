#!/bin/bash

set -e

source /build/install/greenplum_path.sh
source /build/gpdb/gpAux/gpdemo/gpdemo-env.sh

git clone --shared /workspace/madlib /build/madlib
cd /build/madlib
mkdir build1
cd build1/
cmake -DCMAKE_BUILD_TYPE=debug ..
make
sudo make install

src/bin/madpack -p greenplum -c gpadmin@localhost:15432/postgres install
src/bin/madpack -p greenplum -c gpadmin@localhost:15432/postgres install-check