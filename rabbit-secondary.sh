#!/bin/bash
set -e

RABBITMQ_VERSION="3.12.4-1"
HOSTNAME="rabbit2"
PRIMARY_NODE="rabbit1"
COOKIE_VALUE="CLUSTER_SECRET_COOKIE"

# Set hostname
sudo hostnamectl set-hostname $HOSTNAME

# Install dependencies
sudo apt update
sudo apt install -y curl gnupg apt-transport-https

# Install Erlang
curl -fsSL https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb -o esl.deb
sudo dpkg -i esl.deb
sudo apt update
sudo apt install -y erlang-nox

# Install RabbitMQ
curl -fsSL https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/rabbitmq.gpg
echo "deb https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
sudo apt update
sudo apt install -y rabbitmq-server=$RABBITMQ_VERSION

# Set Erlang cookie
echo "$COOKIE_VALUE" | sudo tee /var/lib/rabbitmq/.erlang.cookie
sudo chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
sudo chmod 400 /var/lib/rabbitmq/.erlang.cookie

# Stop RabbitMQ to prepare for join
sudo systemctl stop rabbitmq-server
sudo rm -rf /var/lib/rabbitmq/mnesia/*

# Start and join cluster
sudo systemctl start rabbitmq-server
sudo rabbitmqctl stop_app
sudo rabbitmqctl reset
sudo rabbitmqctl join_cluster rabbit@$PRIMARY_NODE
sudo rabbitmqctl start_app

echo "✅ Secondary node ($HOSTNAME) 클러스터 조인 완료"
