#!/bin/bash

# Add Jenkins repository for ubuntu 22.04 
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get upgrade -y

# Installing jenkins + git + docker
apt-get install -y openjdk-17-jre 
apt-get install -y jenkins docker.io git

# Allow firewall rules to be accessable from the web
ufw allow 8080
ufw reload

# create a user called gagi
adduser -q gagi

# add user to sudoers group
usermod -aG sudo gagi

# switch to gagi
su - gagi    


