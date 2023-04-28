#! /bin/sh

# Have access to `psql` within database container for performing queries, etc.
. .env

docker run -it --rm --network $DOCKER_NETWORK -e PGPASSWORD=$POSTGRES_PASSWORD postgres -h $DB_HOST -U $POSTGRES_USER -d $POSTGRES_DB psql