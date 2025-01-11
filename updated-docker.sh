#!/bin/bash

# Aktualisiere die Paketliste
sudo apt-get update

# Installiere benötigte Pakete
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Füge den Docker GPG-Schlüssel hinzu
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Füge das Docker APT-Repository hinzu
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Aktualisiere die Paketliste erneut
sudo apt-get update

# Installiere Docker Engine, CLI und Containerd
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verifiziere, dass Docker korrekt installiert ist, indem du das hello-world Image ausführst
sudo docker run hello-world
