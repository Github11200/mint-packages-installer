echo -e "Starting container...\n"
CONTAINER_ID=$(docker ps -aq | head -n 1)
docker start $CONTAINER_ID

echo -e "Starting tailscale...\n"
sudo tailscale funnel 8080
