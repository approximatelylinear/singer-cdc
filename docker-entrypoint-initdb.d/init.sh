#!/bin/bash

sudo apt-get install postgresql-13-wal2json

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE source_db;
    USE source_db;
    DROP TABLE IF EXISTS animals;
    CREATE TABLE IF NOT EXISTS animals (
        id SERIAL,
        name VARCHAR(10),
        likes_getting_petted BOOLEAN
    );
    INSERT INTO animals (name, likes_getting_petted)
    values ('porcupine', false);
EOSQL
