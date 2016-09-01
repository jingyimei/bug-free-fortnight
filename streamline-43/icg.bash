#!/bin/bash

set -e -u -o pipefail
set -x

_main() {
	USER="$(id -un)"
	LOGNAME="${USER}"
	export USER LOGNAME

	time icg
	time bugbuster
}

icg() {
	: ${LD_LIBRARY_PATH:=}
	(
	source /opt/gcc_env.sh
	source /build/install/greenplum-db-devel/greenplum_path.sh
	source /build/gpdb4/gpAux/gpdemo/gpdemo-env.sh

	cd /build/gpdb4/src/test/regress
	PGOPTIONS='-c optimizer=on' make installcheck-good
	)
}

bugbuster() {
	: ${LD_LIBRARY_PATH:=}
	(
	source /opt/gcc_env.sh
	source /build/install/greenplum-db-devel/greenplum_path.sh
	source /build/gpdb4/gpAux/gpdemo/gpdemo-env.sh

	cd /build/gpdb4/src/test/regress
	PGOPTIONS='-c optimizer=on' make installcheck-bugbuster
	)
}

_main "$@"