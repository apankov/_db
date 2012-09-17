#!/bin/sh

DIR=`dirname $0`
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file $DBCONF"
    exit
fi

. $DBCONF


DBPATCH=''

if [ -z $1 ]; then
    echo "Please specify patch file"
    exit 1
fi

if [ ! -f $1 ]; then
    echo "$1 doesn't exist, please correct"
    exit 2
fi

DBPATCH=$1

echo -n "Applying patch $DBPATCH ... "
mysql -u$DBUSER -p$DBPASS -h$DBHOST --default-character-set=utf8 $DBNAME < $DBPATCH && echo "done"
