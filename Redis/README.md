# Redis

## Install

```bash
sudo apt update && sudo apt upgrade
sudo apt install redis-server

# verify install
redis-server --version

# start redis
sudo systemctl start redis-server

# check redis status
sudo systemctl status redis-server

# make auto start on boot
sudo systemctl enable redis-server
```

## Run with Docker

```bash
docker run -d \
  --name redis \
  -p 6379:6379 \
  -v ~/redis_data:/data \
  --restart always \
  redis:latest \
  redis-server --requirepass your_strong_redis_password
```

## simple cluster (1 master & 2 replicas)

```bash
# start cluster
docker compose -f simple-cluster-compose.yaml up -d

# check replication
docker exec redis-master redis-cli -a redis123 INFO replication
```

## sharding cluster (3 master & 3 replicas)

```bash
# check cluster status
docker exec redis-node-1 redis-cli -c -p 6379 -a redis123 CLUSTER NODES

# test
docker exec -it redis-node-1 redis-cli -c -p 6379 -a redis123
```
