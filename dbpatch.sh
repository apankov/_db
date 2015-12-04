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
cmd="${MYSQL_CMD} ${DBNAME} < ${DBPATCH}"
run_mysql_cmd "${cmd}" "-v ${PATCH_DIR}:${PATCH_DIR}"
