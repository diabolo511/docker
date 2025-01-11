#!/bin/bash

# Install Docker and Portainer in one script
# First, delete old packages related

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  sudo apt-get remove $pkg || { echo "Failed to remove $pkg"; exit 1; }
done

# Add Docker's official GPG key:

sudo apt-get update || { echo "Failed to update package list"; exit 1; }
sudo apt-get install ca-certificates curl || { echo "Failed to install prerequisites"; exit 1; }
sudo install -m 0755 -d /etc/apt/keyrings || { echo "Failed to create keyrings directory"; exit 1; }
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg || { echo "Failed to download Docker GPG key"; exit 1; }
sudo chmod a+r /etc/apt/keyrings/docker.gpg || { echo "Failed to set permissions on Docker GPG key"; exit 1; }

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || { echo "Failed to add Docker repository"; exit 1; }

sudo apt-get update || { echo "Failed to update package list after adding Docker repository"; exit 1; }

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y || { echo "Failed to install Docker"; exit 1; }

# Test if Docker works 
sudo docker run hello-world || { echo "Docker test failed"; exit 1; }

# Create Data Volume for Portainer
sudo docker volume create portainer_data || { echo "Failed to create Portainer data volume"; exit 1; }

# Install Portainer on port 9443 with self-signed SSL cert
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce || { echo "Failed to install Portainer"; exit 1; }
