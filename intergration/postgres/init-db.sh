#!/bin/bash
# /app/postgres/init-db.sh
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE $DB_SADB;
    CREATE DATABASE $DB_INFISICAL;
    CREATE DATABASE $DB_GRAFANA;
EOSQL
