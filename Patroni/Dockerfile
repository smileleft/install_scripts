FROM python:3.12-slim

# Install Postgres & system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql postgresql-contrib \
    libpq-dev gcc g++ libffi-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Patroni
RUN pip install --upgrade pip && \
    pip install patroni[etcd] psycopg2-binary python-etcd

# Copy config and entrypoint
COPY patroni.yml /etc/patroni.yml
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5432 8008
ENTRYPOINT ["/entrypoint.sh"]
