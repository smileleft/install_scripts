#!/bin/bash
# rabbitmq/entrypoint-cluster.sh

# container start
rabbitmq-server &

# wait until Primary node is ready
sleep 20 

# cluster join
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster rabbit@primary-server
rabbitmqctl start_app

# foreground process
tail -f /dev/null
