# base image
FROM python:3.12-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG PG_MAJOR=17

RUN groupadd -r postgres --gid=999 && \
    useradd -r -g postgres --uid=999 --home-dir=/var/lib/postgresql --shell=/bin/bash postgres

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -o /etc/apt/keyrings/postgresql-archive-keyring.gpg --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
    echo "deb [signed-by=/etc/apt/keyrings/postgresql-archive-keyring.gpg] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    postgresql-${PG_MAJOR} \
    gcc && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir patroni[etcd3] psycopg2-binary

USER postgres


# Copy config and entrypoint
COPY patroni.yml /etc/patroni.yml
COPY entrypoint.sh /entrypoint.sh

EXPOSE 5432 8008
ENTRYPOINT ["/entrypoint.sh"]

