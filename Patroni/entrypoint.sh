#!/bin/bash
set -e

# --- Essential ENV check ---
: "${PATRONI_POSTGRESQL_DATA_DIR:=/pgdata}"

# bin_dir check
if [ -z "${PATRONI_POSTGRESQL_BIN_DIR:-}" ] && command -v pg_config >/dev/null 2>&1; then
  export PATRONI_POSTGRESQL_BIN_DIR="$(pg_config --bindir)"
fi

# Data directory check
mkdir -p "$PATRONI_POSTGRESQL_DATA_DIR"
if [ "$(id -u)" = "0" ]; then
  chown -R postgres:postgres "$PATRONI_POSTGRESQL_DATA_DIR"
fi

# yml permission check
if [ ! -r /etc/patroni.yml ]; then
  echo "ERROR: /etc/patroni.yml not readable" >&2
  exit 1
fi

# logging config
echo "[$(date +%T)] user=$(id -un) pg_bin=${PATRONI_POSTGRESQL_BIN_DIR:-unset} data=${PATRONI_POSTGRESQL_DATA_DIR}"

exec patroni /etc/patroni.yml
