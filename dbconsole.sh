#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file $DBCONF"
    exit 1
fi

. $DBCONF


mysql -u$DBUSER -p$DBPASS -h$DBHOST --default-character-set=utf8 $DBNAME
