#!/bin/sh

DIR=`dirname $0`
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file $DBCONF"
    exit
fi

. $DBCONF


now=`date +'%Y-%m-%d_%H-%M-%S'`

./dbdump.sh $DBNAME-$now.sql
bzip2 -9    $DBNAME-$now.sql
