#!/bin/bash

# install docker pre-reqs
apt-get update
apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-cache madison docker-ce

# install docker-ce components
apt-get -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io

# add "jenkins" user to /etc/sudoers
usermod -a -G docker jenkins
