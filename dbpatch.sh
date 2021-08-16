#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file ${DBCONF}"
    exit 1
fi

. $DBCONF
. $DIR/lib.sh


DBPATCH=''

if [ -z $1 ]; then
    echo 'Please specify patch file'
    exit 2
fi

if [ ! -f $1 ]; then
    echo "$1 doesn't exist, please correct"
    exit 3
fi

DBPATCH=$1

PATCH_DIR="$( cd -P "$( dirname ${DBPATCH} )" && pwd )"
PATCH_FILE="$( basename ${DBPATCH} )"
DBPATCH="${PATCH_DIR}/${PATCH_FILE}"


echo "Applying patch ${DBPATCH} ..."
clientCmd="${MYSQL_CMD} ${DBNAME}"
cmd="${clientCmd} < ${DBPATCH}"


if [ $DOCKER_MYSQLD_CONTAINER ]; then
    network=''
    if [ $DOCKER_NETWORK ]; then
        network="--net $DOCKER_NETWORK"
    fi
    cat ${DBPATCH} | docker exec -i $DOCKER_MYSQLD_CONTAINER sh -c "${clientCmd}"
elif [ $DOCKER_COMPOSE_SERVICE ]; then
    fullcmd="docker-compose exec $DOCKER_COMPOSE_SERVICE $cmd"
    sh -c "$fullcmd"
else
    bash -c "$cmd"
fi
