# Cassandra

## Run with Docker

```bash
# pull cassandra image
docker pull cassandra:latest

# run cassandra docker
docker network create cassandra
docker run --rm -d --name cassandra --hostname cassandra --network cassandra cassandra

# load data with CQLSH
docker run --rm --network cassandra -v "$(pwd)/data.cql:/scripts/data.cql" -e CQLSH_HOST=cassandra -e CQLSH_PORT=9042 -e CQLVERSION=3.4.6 nuvo/docker-cqlsh
```
