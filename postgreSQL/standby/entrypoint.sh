#!/bin/bash
set -e

DATA_DIR="/var/lib/postgresql/data"
PG_VERSION="17"

# If PG already initialized, skip basebackup
if [ -s "$DATA_DIR/PG_VERSION" ]; then
  echo "[*] PostgreSQL data directory already exists, skipping basebackup"
else
  echo "[*] Running pg_basebackup from primary ${PRIMARY_HOST}:${PRIMARY_PORT}..."
  export PGPASSWORD="${REPL_PASSWORD}"
  pg_basebackup -h "${PRIMARY_HOST}" -p "${PRIMARY_PORT}" -U "${REPL_USER}" \
    -D "$DATA_DIR" -Fp -Xs -P -R
fi

echo "[*] Fixing permissions..."
chown -R postgres:postgres "$DATA_DIR"
chmod 0700 "$DATA_DIR"

echo "[*] Starting PostgreSQL in standby mode..."
exec gosu postgres postgres -D "$DATA_DIR"
