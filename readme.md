# Singer CDC 

Example of CDC from postgres with wal2json and singer.

Wal2Json example modified from [pg-wal2json](https://github.com/splicehq/pg-wal2json).

Singer tap uses [transferwise posgres tap](https://github.com/transferwise/pipelinewise-tap-postgres).

# Components
Contains a Docker Compose stack with two postgres instances and a python app running a singer posgres tap.

- Master postgres: Sets up postgres with wal2json plugin and db `rep_test` and user `rep_user` 
- Listener postgres: Sets up replication slot with wal2json plugin using `pg_recvlogical`
- Singer app: Creates fake data with `pg_bench` and sets up singer postgres tap for logical replication of pg_bench tables

# Usage

Start docker containers: `docker-compose -f stack.yml build && docker-compose -f stack.yml up` 

This will emit all changes twice in the compose log, once for the pg_recvlogical print slot and another for the singer postgres tap. 

# Todo

Validate usage under various conditions
- Normal operation
- Interrupted operation with full restart
- Interrupted operation with state checkpoint

Tests
- Row counts for each table 
- Min/max column values for each table
- Checksums for each table column

