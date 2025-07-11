#!/bin/bash
set -e

PRIMARY_IP=your_primary_ip

# Install PostgreSQL 17
echo "Installing PostgreSQL 17..."
sudo apt update
sudo apt install -y wget gnupg2
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" \
    | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install -y postgresql-17

# Stop PostgreSQL and clean data directory
sudo systemctl stop postgresql
sudo -u postgres rm -rf /var/lib/postgresql/17/main/*

# Base backup from primary
sudo -u postgres pg_basebackup -h $PRIMARY_IP -D /var/lib/postgresql/17/main -U replicator -P -R --wal-method=stream

# Modify postgresql.conf (for optional tuning)
PGCONF="/etc/postgresql/17/main/postgresql.conf"
sudo sed -i "s/#hot_standby = on/hot_standby = on/" $PGCONF

# Start PostgreSQL
sudo systemctl start postgresql
