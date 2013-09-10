#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file $DBCONF"
    exit 1
fi

. $DBCONF


if [ ! -z $1 ]; then
    DBDUMP=$1
fi

mysqldump --skip-opt --add-drop-table --routines --disable-add-locks \
    --create-options --quick --set-charset --disable-keys \
    $DBNAME -u$DBUSER -p$DBPASS -h$DBHOST > $DBDUMP
