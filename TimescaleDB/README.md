# TimescaleDB

## Install

```bash
# install the latest postgresSQL packages
sudo apt install gnupg postgresql-common apt-transport-https lsb-release wget

# run the postgreSQL setup script
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

# add TimescaleDB package
echo "deb https://packagecloud.io/timescale/timescaledb/ubuntu/ $(lsb_release -c -s) main" | sudo tee /etc/apt/sources.list.d/timescaledb.list

# install TimescaleDB GPG key
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/timescaledb.gpg
```
