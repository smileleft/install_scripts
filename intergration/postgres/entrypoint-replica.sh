#!/bin/bash
# postgres/entrypoint-replica.sh
set -e

# 기본 데이터 디렉토리가 비어있을 때만 Primary로부터 복제 실행
if [ -z "$(ls -A "$PGDATA")" ]; then
    echo "Starting initial replication from primary..."
    pg_basebackup -h $PRIMARY_SERVER_IP -p 5432 -D $PGDATA -U $POSTGRES_USER -vP -w -R
fi

echo "Starting PostgreSQL in standby mode..."
exec postgres
