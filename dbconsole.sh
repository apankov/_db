#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file ${DBCONF}"
    exit 1
fi

. $DBCONF
. $DIR/lib.sh


extra="$@"
if [ "${extra}" ]; then
    extra="'${extra}'"
fi
cmd="${MYSQL_CMD} ${DBNAME} ${extra}"

if [ $DOCKER_MYSQLD_CONTAINER ]; then
    network=''
    if [ $DOCKER_NETWORK ]; then
        network="--net $DOCKER_NETWORK"
    fi
    docker exec -it $DOCKER_MYSQLD_CONTAINER sh -c "${cmd}"
elif [ $DOCKER_COMPOSE_SERVICE ]; then
    fullcmd="docker-compose exec $DOCKER_COMPOSE_SERVICE $cmd"
    sh -c "$fullcmd"
else
    bash -c "$cmd"
fi
