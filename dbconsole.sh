#!/bin/sh

DIR=`dirname $0`
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file $DBCONF"
    exit
fi

. $DBCONF


mysql -u$DBUSER -p$DBPASS -h$DBHOST --default-character-set=utf8 $DBNAME
