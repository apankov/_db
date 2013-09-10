#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file $DBCONF"
    exit 1
fi

. $DBCONF


if [ ! -z $1 ]; then
    if [ ! -f $1 ]; then
        echo "$1 doesn't exist, using $DBDUMP"
        if [ ! -f $DBDUMP ]; then
            echo "$DBDUMP doesn't exist, exiting"
            exit 2
        fi
    else
        DBDUMP=$1
    fi
fi

echo -n "Dropping database $DBNAME ... "
mysql -u$DBUSER -p$DBPASS -h$DBHOST -e "drop database $DBNAME" && echo "done"

echo -n "Creating database $DBNAME ... "
mysql -u$DBUSER -p$DBPASS -h$DBHOST -e "create database $DBNAME" && echo "done"

echo -n "Loading dump $DBDUMP ... "
mysql -u$DBUSER -p$DBPASS -h$DBHOST --default-character-set=utf8 $DBNAME < $DBDUMP && echo "done"
