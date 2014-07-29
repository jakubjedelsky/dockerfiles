#!/bin/bash
# initialize DB
/usr/pgsql-9.3/bin/initdb -D $PGDATA
# run Postgres on background
/usr/pgsql-9.3/bin/postgres -D $PGDATA &
sleep 5
# create user
psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';"
# create DB
createdb -O docker docker
# kill running process
pkill postgres
