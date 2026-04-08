#!/bin/bash
# ==========================================
# USER MANAGEMENT SCRIPT
# Purpose: Create a non-root user for daily operations
# Security: Running apps as root is dangerous
# ==========================================

set -e  # Stop script if any command fails

echo "========================================="
echo "Starting user setup"
echo "========================================="

# CONFIGURATION
# Change this to your preferred username
USERNAME="deployer"

# Check if user already exists
# &>/dev/null silences output (we don't need to see errors)
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists. Skipping creation."
else
    echo "Creating user: $USERNAME"
    
    # Create user with:
    # -m : create home directory (/home/deployer)
    # -s : set default shell to bash
    sudo useradd -m -s /bin/bash "$USERNAME"
    
    # Set password (interactive - you type it)
    echo "Set password for $USERNAME:"
    sudo passwd "$USERNAME"
    
    # Add user to sudo group (allows admin commands)
    # -aG : append user to group (don't remove from other groups)
    sudo usermod -aG sudo "$USERNAME"
    
    echo "User $USERNAME created and added to sudo group"
fi

# Show user details to confirm it worked
echo "Verifying user creation..."
id "$USERNAME"

echo "========================================="
echo "User setup complete!"
echo "========================================="
