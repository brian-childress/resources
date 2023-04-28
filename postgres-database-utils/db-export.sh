#! /bin/sh

# Using docker, create a dump of the remote DB
# This uses a separate configuration (.env) file to export data from another DB
. .env.remote

docker run -it -e PGPASSWORD=$POSTGRES_PASSWORD postgres pg_dump -h $DB_HOST -U $POSTGRES_USER -d $POSTGRES_DB > $EXPORT_DATAFILE