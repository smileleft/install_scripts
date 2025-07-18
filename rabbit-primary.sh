#!/bin/bash
set -e

RABBITMQ_VERSION="3.12.4-1"
HOSTNAME="rabbit1"
COOKIE_VALUE="CLUSTER_SECRET_COOKIE"
ADMIN_USER="admin"
ADMIN_PASS="strongpassword"

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

# Enable and start RabbitMQ
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

# Enable management plugin
sudo rabbitmq-plugins enable rabbitmq_management

# Add admin user
sudo rabbitmqctl add_user $ADMIN_USER $ADMIN_PASS
sudo rabbitmqctl set_user_tags $ADMIN_USER administrator
sudo rabbitmqctl set_permissions -p / $ADMIN_USER ".*" ".*" ".*"

echo "✅ Primary node ($HOSTNAME) 설치 및 설정 완료"
