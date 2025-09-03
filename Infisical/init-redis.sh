#!/bin/bash
# setup-redis-cluster.sh

set -e

REDIS_PORT=6379

# IPs of all redis nodes
NODES=(
  10.0.0.1
  10.0.0.2
  10.0.0.3
)

echo "[INFO] Checking Redis nodes availability..."
for ip in "${NODES[@]}"; do
  if ! nc -z $ip $REDIS_PORT; then
    echo "[ERROR] Redis not reachable at $ip:$REDIS_PORT"
    exit 1
  fi
done

# Build --cluster create argument
ARGS=""
for ip in "${NODES[@]}"; do
  ARGS+="$ip:$REDIS_PORT "
done

echo "[INFO] Creating Redis Cluster..."
yes yes | docker run -it --rm redis:7-alpine redis-cli --cluster create $ARGS --cluster-replicas 0

echo "[INFO] Redis Cluster creation complete!"
