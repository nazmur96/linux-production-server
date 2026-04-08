#!/bin/bash
# ==========================================
# DOCKER INSTALLATION SCRIPT
# Purpose: Install Docker and configure for non-root user
# Run this AFTER users.sh (deployer user must exist)
# ==========================================

set -e

echo "========================================="
echo "Starting Docker installation"
echo "========================================="

# ==========================================
# 1. REMOVE OLD VERSIONS (if any)
# ==========================================
echo "Removing old Docker versions..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true

# ==========================================
# 2. INSTALL PREREQUISITES
# ==========================================
echo "Installing prerequisites..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# ==========================================
# 3. ADD DOCKER'S OFFICIAL GPG KEY
# ==========================================
# GPG key verifies packages are from Docker, not tampered with
echo "Adding Docker's GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# ==========================================
# 4. ADD DOCKER REPOSITORY
# ==========================================
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# ==========================================
# 5. INSTALL DOCKER ENGINE
# ==========================================
echo "Installing Docker packages..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ==========================================
# 6. START AND ENABLE DOCKER
# ==========================================
echo "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# ==========================================
# 7. CONFIGURE NON-ROOT USER ACCESS
# ==========================================
# By default, only root can run Docker commands
# This adds the deployer user to 'docker' group
echo "Configuring non-root user access..."

# Check if deployer user exists
if id "deployer" &>/dev/null; then
    sudo usermod -aG docker deployer
    echo "User 'deployer' added to docker group"
else
    echo "WARNING: User 'deployer' not found!"
    echo "Run scripts/users.sh first, or manually add your user to docker group"
fi

# ==========================================
# 8. VERIFY INSTALLATION
# ==========================================
echo "Verifying Docker installation..."
sudo docker --version
sudo docker run hello-world

echo "========================================="
echo "Docker installation complete!"
echo "========================================="

echo ""
echo "📝 IMPORTANT:"
echo "For 'deployer' user to run Docker without sudo:"
echo "  1. Log out and log back in, OR"
echo "  2. Run: newgrp docker"
echo ""
echo "Test with: docker run hello-world"
