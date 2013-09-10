#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file $DBCONF"
    exit 1
fi

. $DBCONF


DBPATCH=''

if [ -z $1 ]; then
    echo "Please specify patch file"
    exit 2
fi

if [ ! -f $1 ]; then
    echo "$1 doesn't exist, please correct"
    exit 3
fi

DBPATCH=$1

echo -n "Applying patch $DBPATCH ... "
mysql -u$DBUSER -p$DBPASS -h$DBHOST --default-character-set=utf8 $DBNAME < $DBPATCH && echo "done"
