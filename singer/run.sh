#!/bin/bash

set -e

# Wait for the master database server to become available on port 5432.
wait-for-it master:5432

psql -v ON_ERROR_STOP=1 --username "$PGUSER" --dbname "$REP_DB" <<EOSQL
SELECT * FROM pg_create_logical_replication_slot('stitch', 'wal2json');
EOSQL

pgbench -i rep_test

cat <<EOF > "config.json"
{
    "host": "$PGHOST",
    "port": "5432",
    "user": "$PGUSER",
    "password": "$PGPASSWORD",
    "dbname": "$REP_DB"
}
EOF

tap-postgres -c config.json --discover > properties-discover.json

# # cat properties.json | jq .

# tap-postgres -c config.json --properties properties.json

sleep 3600;
