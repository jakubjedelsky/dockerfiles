#!/bin/bash
# 
# Inspired by https://github.com/bluelabsio/docker-vertica
#

function shut_down() {
    echo "Shutting Down"
    su $DBUSER -c "/opt/vertica/bin/admintools -t stop_db -d $DBNAME -i"
    exit
}

function install_vertica() {
    # Magic!
    local IP='localhost'
    if [[ $1 ]] ; then
        IP=$1
    fi
    echo "Installing Vertica"
    /opt/vertica/sbin/install_vertica --host $IP \
        --license CE \
        --accept-eula \
        --dba-user $DBUSER \
        --dba-group $DBUSER \
        --dba-user-password-disabled \
        --data-dir $VERTICADATA \
        --tmp-dir $VERTICADATA \
        --point-to-point \
        --spread-logging \
        --failure-threshold NONE \
        --no-system-configuration
}

trap "shut_down" SIGKILL SIGTERM SIGHUP SIGINT EXIT

# TODO:
# obtain container's ip and install it there (for cluster support). But a new
# container (eg. after restart or new container with persistent data) has a
# different ip. Thus we install it just on localhost now.
ip="localhost"

if [ -z "$(ls -A "$VERTICADATA/$DBNAME")" ]; then
    echo "Creating database"
    install_vertica $ip
    su $DBUSER -c "/opt/vertica/bin/admintools -t create_db -s $ip -d $DBNAME -D $VERTICADATA"
else
    su $DBUSER -c "/opt/vertica/bin/admintools -t start_db -d $DBNAME -i"
fi

echo "Vertica is running"

# This is the end, my only friend, the end.
while true ; do
    sleep 30
done
