# Patroni
Make custom image for patroni

## run image
```
docker run -d --name patroni \
  -p 5432:5432 -p 8008:8008 \
  -v patroni_data:/var/lib/postgresql/data sadb-patroni:latest
```
