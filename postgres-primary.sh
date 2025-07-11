#!/bin/bash
set -e

# Install PostgreSQL 17
echo "Installing PostgreSQL 17..."
sudo apt update
sudo apt install -y wget gnupg2
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" \
    | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install -y postgresql-17

# Configure postgresql.conf
PGCONF="/etc/postgresql/17/main/postgresql.conf"
PGHBA="/etc/postgresql/17/main/pg_hba.conf"

sudo sed -i "s/#listen_addresses =.*/listen_addresses = '*'/" $PGCONF
sudo sed -i "s/#wal_level =.*/wal_level = replica/" $PGCONF
sudo sed -i "s/#max_wal_senders =.*/max_wal_senders = 10/" $PGCONF
sudo sed -i "s/#wal_keep_size =.*/wal_keep_size = 64/" $PGCONF
sudo sed -i "s/#archive_mode =.*/archive_mode = on/" $PGCONF
sudo sed -i "s|#archive_command = .*|archive_command = 'cd .'|" $PGCONF

# Configure pg_hba.conf
echo "host replication replicator {your_ip}/32 md5" | sudo tee -a $PGHBA

# Restart and create replicator user
sudo systemctl restart postgresql
sudo -u postgres psql -c "CREATE ROLE replicator REPLICATION LOGIN ENCRYPTED PASSWORD 'Telepix_Replica_pass';"
