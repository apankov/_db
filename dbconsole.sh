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
run_mysql_cmd "${cmd}"
