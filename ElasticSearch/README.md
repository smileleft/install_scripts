# ElasticSearch

# How to Run ElasticSearch with Docker
```
docker run --name es01 \
  --net elastic \
  -p 9200:9200 \
  -e "discovery.type=single-node" \
  -e "xpack.security.enabled=false" \
  -m 1GB \
  docker.elastic.co/elasticsearch/elasticsearch:<VERSION_NUMBER>
```
