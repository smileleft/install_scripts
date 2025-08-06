#!/bin/bash

CONTAINER_NAME=pg-standby

echo "[1] Stop standby container..."
docker stop $CONTAINER_NAME

echo "[2] Clean up old data directory..."
docker exec -u root $CONTAINER_NAME rm -rf /var/lib/postgresql/data/*

echo "[3] Run basebackup from primary..."
docker exec -u root $CONTAINER_NAME bash -c "
export PGPASSWORD=$REPL_PASSWORD && \
pg_basebackup -h $PRIMARY_HOST -D /var/lib/postgresql/data -U $REPL_USER -Fp -Xs -P -R
"

echo "[4] Ensure permissions..."
docker exec -u root $CONTAINER_NAME chown -R postgres:postgres /var/lib/postgresql/data

echo "[5] Start standby container..."
docker start $CONTAINER_NAME

