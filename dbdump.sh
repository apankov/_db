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


cmd="mysqldump -h${DBHOST} -u${DBUSER} -p${DBPASS} ${DBNAME} "
cmd="${cmd} --skip-opt --add-drop-table --routines --disable-add-locks"
cmd="${cmd} --create-options --quick --set-charset --disable-keys > $DBDUMP"
run_mysql_cmd "${cmd}" "-v ${DUMP_DIR}:${DUMP_DIR}"
