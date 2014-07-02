#!/bin/bash

# default values
M_USER="root"
M_PASSWORD="changeme"

function adduser {
    local DBUSER=$1
    local PW=$2
    local COMMAND="GRANT ALL ON *.* TO '$DBUSER'@'%' IDENTIFIED BY '$PW'"
    mysql -u root --protocol=tcp -e "$COMMAND"
}

if [[ $MYSQL_USER ]] ; then
    M_USER=$MYSQL_USER
fi

if [[ $MYSQL_PASSWORD ]] ; then
    M_PASSWORD=$MYSQL_PASSWORD
fi

/usr/libexec/mariadb-prepare-db-dir
/usr/bin/mysqld_safe --basedir=/usr &
# need to wait for full start
sleep 5
adduser "$M_USER" "$M_PASSWORD"

PID=$(pidof mysqld)
kill -SIGTERM $PID
# need to wait for stop
sleep 5

/usr/bin/mysqld_safe --basedir=/usr 
