# Jenkins
https://jenkins.io

## Install on Linux(Ubuntu)
```
# prepare (java)
sudo apt update
sudo apt install fontconfig openjdk-21-jre
java -vesion

# LTS install
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins
```

## Install with Docker
