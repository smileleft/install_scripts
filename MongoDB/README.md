# MongoDB

## Install
```
# Impoert the MongoDB GPG Key
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor

# Add the MongoDB Repository
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

# Update package
sudo apt update
sudo apt install -y monogb-org

# Start and Enable MongoDB service
sudo systemctl start mongod
sudo systemctl enable mongod

# Verify Installation
mongosh
```
