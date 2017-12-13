
# What
This repository is a folk of https://github.com/d/bug-free-fortnight and adds some advanced analytics testing scripts. ## Remeber to checkout branch `advanced_analytics_debug`## .Basically, by running scripts here, you can quickly have a centos6 docker container with gpdb installed and orca on, and make debug build of postgis and madlib and install them, also, gdb is installed for debuging purpose. 

## Prerequisites
1. Hack on your code, commit them locally
1. Assuming all your code repositories are checked out in the same directory
   locally (e.g. `~/workspace`). Specifically, the following repositories
   should be checked out locally with the commit/tag you want(make sure the orca version matches with gpdb version!).

   * [orca](https://github.com/greenplum-db/gporca)
   * [gp-xerces](https://github.com/greenplum-db/gp-xerces)
   * [gpdb](https://github.com/greenplum-db/gpdb)
   * [madlib](https://github.com/apache/madlib)
   * [geopspatial](https://github.com/greenplum-db/geospatial)

## How
1. on your local machine, run `env DEBUG=1 ~/workspace/bug-free-fortnight/streamline-master/uber.bash --interactive` this will spin up gpdb for you and login to the docker container.

2. in the docker container:
   if you want to install postgis and run install check, run
   `. /workspace/bug-free-fortnight/advanced_analytics/install_postgis_on_centos_docker.bash`
   if you want to install madlib and run install check, run
   `. /workspace/bug-free-fortnight/advanced_analytics/install_madlib_on_centos_docker.bash your_test_db_name`
   note: the above variable your_test_db_name is optional. Default test database is postgres. If you want to specify something else, just pass the db name and this script will help create the new database and install madlib in it.

## Notes
You local repos are mounted to the docker container in a readonly mode. if you wnat to change code, you can do it on your local repo and the change will be reflected in the docker container.

After running this script, the docker container won't be removed. You can use `docker exec -it container_name /bin/bash` to login again.

If you want to run install scripts multiple times, make sure you uninstall madlib/postgres from database before you run the installation script again.

To clean it up, run `docker kill container_name`.

The docker container has the following config:

* cmake version 3.6.1

* GNU gdb (GDB) Red Hat Enterprise Linux (7.2-92.el6)

For postgis, it will install gdal v1.11.1
## License

See the [LICENSE](LICENSE) file for license rights and your freedom (GPL v3)
