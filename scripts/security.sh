#!/bin/bash
# ==========================================
# SECURITY HARDENING SCRIPT
# Purpose: Protect server from common attacks
# Run this AFTER users.sh (so you have a non-root user)
# ==========================================

set -e

echo "========================================="
echo "Starting security hardening"
echo "========================================="

# ==========================================
# 1. CONFIGURE SSH FOR SECURITY
# ==========================================
echo "Configuring SSH security..."

# Backup original SSH config before modifying
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Disable root login (attackers can't guess root password)
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password authentication (force SSH key login only)
# More secure than passwords which can be brute-forced
sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# ==========================================
# 2. SETUP FIREWALL (UFW)
# ==========================================
echo "Configuring firewall..."

# Install UFW if not present
sudo apt install -y ufw

# Default policies: block everything incoming, allow everything outgoing
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH (important: do this BEFORE enabling firewall!)
sudo ufw allow 22/tcp

# Allow HTTP (port 80) and HTTPS (443) for web traffic
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Allow Kubernetes NodePort range (30000-32767)
# This is where our nginx service will be exposed
sudo ufw allow 30000:32767/tcp

# Enable firewall (this will ask for confirmation)
echo "Enabling firewall..."
sudo ufw --force enable

# Show firewall status
sudo ufw status verbose

# ==========================================
# 3. INSTALL FAIL2BAN (Brute force protection)
# ==========================================
echo "Installing fail2ban..."

sudo apt install -y fail2ban

# Create local configuration
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Restart fail2ban
sudo systemctl enable fail2ban
sudo systemctl restart fail2ban

# ==========================================
# 4. AUTOMATIC SECURITY UPDATES
# ==========================================
echo "Configuring automatic security updates..."

sudo apt install -y unattended-upgrades

# Enable automatic security updates
sudo dpkg-reconfigure --priority=low unattended-upgrades -f noninteractive

echo "========================================="
echo "Security hardening complete!"
echo "========================================="

# IMPORTANT WARNING:
echo ""
echo "⚠️  SSH Password authentication is DISABLED"
echo "Make sure you have configured SSH keys BEFORE logging out!"
echo "Otherwise you will lock yourself out of the server."
echo ""
echo "To add your SSH key:"
echo "  ssh-copy-id deployer@YOUR_SERVER_IP"
