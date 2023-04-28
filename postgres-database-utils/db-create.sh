#! /bin/sh

. ../.env
docker run -it --rm --network $DOCKER_NETWORK -e PGPASSWORD=$POSTGRES_PASSWORD postgres psql -h $DB_HOST -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE DATABASE $DATABASE_NAME;"