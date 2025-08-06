#!/bin/bash

CONTAINER_NAME=pg-primary
STANDBY_HOST=10.0.10.27

echo "[1] Create replication user..."
docker exec -u root $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME -c \
"DO \$\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'replicator') THEN
      CREATE ROLE replicator WITH REPLICATION LOGIN ENCRYPTED PASSWORD 'password';
   END IF;
END
\$\$;"

echo "[2] Update postgresql.conf..."
docker exec -u root $CONTAINER_NAME bash -c "echo '
wal_level = replica
max_wal_senders = 10
wal_keep_size = 64MB
listen_addresses = '\''*'\'
' >> /var/lib/postgresql/data/postgresql.conf"

echo "[3] Update pg_hba.conf..."
docker exec -u root $CONTAINER_NAME bash -c "echo '
host replication replicator $STANDBY_HOST/32 trust
host all all 0.0.0.0/0 trust
' >> /var/lib/postgresql/data/pg_hba.conf"

echo "[4] Restart primary container..."
docker restart $CONTAINER_NAME

