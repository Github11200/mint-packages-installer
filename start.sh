echo -e "Starting container...\n"
CONTAINER_ID=$(sudo docker ps -aq | head -n 1)
sudo docker start $CONTAINER_ID

echo -e "Starting tailscale...\n"
sudo tailscale up
sudo tailscale funnel 8080
