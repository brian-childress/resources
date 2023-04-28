#! /bin/sh

# Restore the dump to the specified DB
. .env
docker run -it --rm --network $DOCKER_NETWORK -e PGPASSWORD=$POSTGRES_PASSWORD -v $(pwd):/backups postgres psql -h $DB_HOST -U $POSTGRES_USER -d $POSTGRES_DB -f /backups/$EXPORT_DATAFILE