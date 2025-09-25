ARG PG_VERSION=17
FROM pgvector/pgvector:pg17

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
