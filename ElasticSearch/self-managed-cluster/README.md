# system config

## ulimit

```bash
sudo su
ulimit -n 65535
su elasticsearch
```

## /etc/security/limits.conf

```bash
# edit /etc/security/limits.conf file, insert below line
elasticsearch  -  nofile  65535

# for ubuntu, you need to edit /etc/pam.d/su instead of /etc/security/limits.conf
# session    required   pam_limits.so
```

## download and install (30-day trial)

```bash
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-9.2.1-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-9.2.1-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-9.2.1-linux-x86_64.tar.gz.sha512
tar -xzf elasticsearch-9.2.1-linux-x86_64.tar.gz
cd elasticsearch-9.2.1/
```
