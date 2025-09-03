#!/bin/bash
set -e

# Start Patroni using the config file
exec patroni /etc/patroni.yml
