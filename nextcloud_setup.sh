#!/bin/bash

echo -e "==========================\nInstalling Docker\n==========================\n"

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

echo -e "\n==========================\nInstalling docker packages\n==========================\n"
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


echo -e "\n==========================\nRunning the Nextcloud Docker container\n==========================\n"

# Get the ID of the container that we just started
CONTAINER_ID=$(docker run -d -p 8080:80 nextcloud)
echo -e "\nUsing container ID: $CONTAINER_ID\n"

echo -e "\n==========================\nOpening link\n==========================\n"
xdg-open "http://localhost:8080"
