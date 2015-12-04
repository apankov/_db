#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file ${DBCONF}"
    exit 1
fi

. $DBCONF
. $DIR/lib.sh


if [ ! -z $1 ]; then
    if [ ! -f $1 ]; then
        echo "$1 doesn't exist, using ${DBDUMP}"
        if [ ! -f $DBDUMP ]; then
            echo "${DBDUMP} doesn't exist, exiting"
            exit 2
        fi
    else
        DBDUMP=$1
    fi
fi


echo "Dropping database ${DBNAME} ... "
cmd="${MYSQL_CMD} -e 'DROP DATABASE ${DBNAME}'"
run_mysql_cmd "${cmd}"


echo "Creating database ${DBNAME} ... "
cmd="${MYSQL_CMD} -e 'CREATE DATABASE ${DBNAME}'"
run_mysql_cmd "${cmd}"


$DIR/dbpatch.sh $DBDUMP
