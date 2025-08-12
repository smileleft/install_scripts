#!/bin/bash
# rabbitmq/entrypoint-cluster.sh

# 컨테이너 시작
rabbitmq-server &

# Primary 노드가 준비될 때까지 대기
sleep 20 

# 클러스터 조인
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster rabbit@primary-server
rabbitmqctl start_app

# 포그라운드에서 계속 실행되도록 함
tail -f /dev/null
