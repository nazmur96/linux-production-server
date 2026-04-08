#!/bin/bash

# User management script
# Creates a non-root user with sudo privileges

set -e  # Exit on any error

echo "========================================="
echo "Starting user setup"
echo "========================================="

# Define username (change this to your preferred username)
USERNAME="deployer"

# Check if user already exists
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists. Skipping creation."
else
    echo "Creating user: $USERNAME"
    
    # Create user with home directory
    sudo useradd -m -s /bin/bash "$USERNAME"
    
    # Set password (you'll be prompted)
    echo "Set password for $USERNAME:"
    sudo passwd "$USERNAME"
    
    # Add user to sudo group
    sudo usermod -aG sudo "$USERNAME"
    
    echo "User $USERNAME created and added to sudo group"
fi

# Verify user exists
echo "Verifying user creation..."
id "$USERNAME"

echo "========================================="
echo "User setup complete!"
echo "========================================="
