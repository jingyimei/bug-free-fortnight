#!/bin/bash

source /build/install/greenplum_path.sh
source /build/gpdb/gpAux/gpdemo/gpdemo-env.sh

db_name=${1:-postgres}

if [ ${db_name} != "postgres" ]; then
	createdb ${db_name}
fi

git clone --shared /workspace/madlib /build/madlib
cd /build/madlib
mkdir -p build_madlib_debug
cd build_madlib_debug/
cmake -DCMAKE_BUILD_TYPE=debug -DCMAKE_CXX_COMPILER_LAUNCHER=ccache ..

# Currently, `make -j8` fails, but running it two times solves this problem
# and also speed up make, that's also why there is no set -e at the begining
# of this script
make -j8; make -j8
sudo make install

src/bin/madpack -p greenplum -c gpadmin@localhost:15432/${db_name} install
src/bin/madpack -p greenplum -c gpadmin@localhost:15432/${db_name} install-check
