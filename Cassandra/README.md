# Cassandra

## Run with Docker

```bash
# pull cassandra image
docker pull cassandra:latest

# run cassandra docker
docker network create cassandra
docker run --rm -d --name cassandra --hostname cassandra --network cassandra cassandra
```
