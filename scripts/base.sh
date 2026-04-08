#!/bin/bash
# ==========================================
# BASE SYSTEM SETUP SCRIPT
# Purpose: Initialize Ubuntu server with essential packages
# Run this FIRST before any other scripts
# ==========================================

set -e  # Exit on any error (critical for automation)

echo "========================================="
echo "Starting base system setup"
echo "========================================="

# UPDATE PACKAGE LIST
# apt update refreshes the package index from Ubuntu repositories
# Without this, apt doesn't know about new or updated packages
echo "Updating package lists..."
sudo apt update

# UPGRADE EXISTING PACKAGES
# -y flag automatically answers "yes" to confirmation prompts
# This is essential for non-interactive scripts
echo "Upgrading packages..."
sudo apt upgrade -y

# INSTALL ESSENTIAL TOOLS
# Each tool serves a specific purpose:
# curl/wget   - Download files from internet
# vim         - Terminal text editor
# git         - Version control (to clone this repo!)
# net-tools   - Network debugging (ifconfig, netstat)
# htop        - Better version of 'top' for monitoring
echo "Installing essential tools..."
sudo apt install -y \
    curl \
    wget \
    vim \
    git \
    net-tools \
    htop

echo "========================================="
echo "Base setup complete!"
echo "========================================="

# NEXT STEPS:
# Run scripts/users.sh to create a non-root user
