# Redis

## Install
```
sudo apt update && sudo apt upgrade
sudo apt install redis-server

# verify install
redis-server --version

# start redis
sudo systemctl start redis-server

# check redis status
sudo systemctl status redis-server

# make auto start on boot
sudo systemctl enable redis-server
```

## Install with Docker
```
docker run -d \
  --name redis \
  -p 6379:6379 \
  -v ~/redis_data:/data \
  --restart always \
  redis:latest \
  redis-server --requirepass your_strong_redis_password
```
