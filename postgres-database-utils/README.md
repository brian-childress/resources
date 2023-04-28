# Database Utilities

## Working with Docker

We're using a Docker container that leverages the Postgres image to have access to the `psql` command to do things like exporting a DB from another (remote) server, restoring data for testing or migration. By using a Docker container we have a portable solution that can be added to any project or quickly configured for ad hoc usage.

### Files

`db-export.sh`: Use to export data from a database (possibly a remote DB) and write it to a local `.sql` file

`db-create.sh`: Use to create a new empty database

`db-restore.sh`: Use to restore schema and data to a database

`db-utils.sh`: Use when connecting to a database and using the `psql` utility CLI.
