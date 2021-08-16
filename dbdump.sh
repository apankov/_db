#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file $DBCONF"
    exit 1
fi

. $DBCONF
. $DIR/lib.sh


if [ ! -z $1 ]; then
    DBDUMP=$1
fi



DUMP_DIR="$( cd -P "$( dirname ${DBDUMP} )" && pwd )"
DUMP_FILE="$( basename ${DBDUMP} )"
DBDUMP="${DUMP_DIR}/${DUMP_FILE}"


clientCmd="mysqldump -h${DBHOST} -u${DBUSER} -p${DBPASS} ${DBNAME} "
clientCmd="${clientCmd} --skip-opt --add-drop-table --routines --disable-add-locks"
clientCmd="${clientCmd} --create-options --quick --set-charset --disable-keys"
cmd="${clientCmd} > ${DBDUMP}"

if [ $DOCKER_MYSQLD_CONTAINER ]; then
    network=''
    if [ $DOCKER_NETWORK ]; then
        network="--net $DOCKER_NETWORK"
    fi
    docker exec -i $DOCKER_MYSQLD_CONTAINER sh -c "${clientCmd}" > ${DBDUMP}
elif [ $DOCKER_COMPOSE_SERVICE ]; then
    fullcmd="docker-compose exec $DOCKER_COMPOSE_SERVICE $cmd"
    sh -c "$fullcmd"
else
    bash -c "$cmd"
fi
