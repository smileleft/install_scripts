# postgres/Dockerfile
FROM pgvector/pgvector:pg17 

RUN apt-get update && apt-get install -y postgresql-contrib-$PG_MAJOR && rm -rf /var/lib/apt/lists/*
