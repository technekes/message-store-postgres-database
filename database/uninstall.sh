#!/usr/bin/env bash

set -e

echo
echo "Uninstalling Database"
echo "= = ="
echo

default_name=message_store

if [ -z ${DATABASE_USER+x} ]; then
  echo "(DATABASE_USER is not set. Default will be used.)"
  user=$default_name
else
  user=$DATABASE_USER
fi
echo "Database user is: $user"

if [ -z ${DATABASE_NAME+x} ]; then
  echo "(DATABASE_NAME is not set. Default will be used.)"
  database=$default_name
else
  database=$DATABASE_NAME
fi
echo "Database name is: $database"
echo

# function delete-user {
#   user_exists=`psql postgres -qtAXc "SELECT 1 FROM pg_roles WHERE rolname='$user'"`

#   if [ "$user_exists" = "1" ]; then
#     echo "Deleting database user \"$user\"..."
#     dropuser $user
#   else
#     echo "Database user \"$user\" does not exist. Not deleting."
#   fi

#   echo
# }

function delete-user {
  psql -P pager=off -c "DROP ROLE IF EXISTS $user;"
  echo
}

# function delete-database {
#   database_exists=`psql postgres -qtAXc "SELECT 1 FROM pg_database WHERE datname='$database'"`

#   if [ "$database_exists" = "1" ]; then
#     echo "Deleting database \"$database\"..."
#     dropdb $database
#   else
#     echo "Database \"$database\" does not exist. Not deleting."
#   fi

#   echo
# }

function delete-database {
  psql -P pager=off -c "DROP DATABASE IF EXISTS $database;"
  echo
}

echo
echo "Deleting database \"$database\"..."
echo "- - -"
delete-database

echo
echo "Deleting database user \"$user\"..."
echo "- - -"
delete-user
