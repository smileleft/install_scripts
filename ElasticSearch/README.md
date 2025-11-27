# ElasticSearch

## How to Run ElasticSearch with Docker

```bash
docker run --name es01 \
  --net elastic \
  -p 9200:9200 \
  -e "discovery.type=single-node" \
  -e "xpack.security.enabled=false" \
  -m 1GB \
  docker.elastic.co/elasticsearch/elasticsearch:<VERSION_NUMBER>
```

## for testing

```bash
curl -fsSL https://elastic.co/start-local | sh
```

## for production

```bash
# docker image pull, current latest version is 9.2.1
docker pull docker.elastic.co/elasticsearch/elasticsearch-wolfi:9.2.1

# start a single node cluster
docker network create elastic
docker run --name es01 --net elastic -p 9200:9200 -it -m 1GB docker.elastic.co/elasticsearch/elasticsearch:9.2.1

# copy the generated elastic password and enrollment token
docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

# store elastic password as an environment varibale
export ELASTIC_PASSWORD="your_password"

# copy th http_ca.crt SSL certificate from the container to your local machine
docker cp es01:/usr/share/elasticsearch/config/certs/http_ca.crt .

# make a REST api call to ElasticSearch to ensure the ElasticSearch container is running
curl --cacert http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200
```
