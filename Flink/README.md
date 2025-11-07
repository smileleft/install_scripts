# Apache Flink
https://flink.apache.org/

## Flink Docker Image
https://hub.docker.com/_/flink

## How to run flink with docker
```
# docker network create
docker network create flink-network

# launch the jobmanager
docker run -d --name flink-jobmanager --network flink-network \
    --env JOB_MANAGER_RPC_ADDRESS=jobmanager -p 8081:8081 flink jobmanager

# launch taskmanager
docker run -d --name flink-taskmanager-1 --network flink-network \
    --env JOB_MANAGER_RPC_ADDRESS=jobmanager flink taskmanager

# accessing web ui
http://localhost:8081
```
