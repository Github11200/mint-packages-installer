#!/bin/bash

echo "==========================\nInstalling Docker\n==========================\n"

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

echo "==========================\nInstalling docker packages\n==========================\n"
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


echo "==========================\nRunning the Nextcloud Docker container\n==========================\n"

# Get the ID of the container that we just started
CONTAINER_ID=$(docker run -p -d 8080:80 nextcloud)
echo "Using container ID: $CONTAINER_ID"
docker exec --user www-data $CONTAINER_ID php /var/www/html/occ config:system:set trusted_domains 1 --value=10.42.0.1:8080

# Print out the file to make sure it was written to correctly
docker exec --user www-data $CONTAINER_ID cat /var/www/html/config/config.php

echo "==========================\nOpening link\n==========================\n"
xdg-open "http://localhost:8080"
