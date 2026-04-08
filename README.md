# Linux Production Server with k3s Deployment

[![Status](https://img.shields.io/badge/status-learning-blue)]()
[![License](https://img.shields.io/badge/license-MIT-green)]()

A hands-on project demonstrating production server setup, security hardening, and Kubernetes deployment using k3s on Ubuntu Linux.

## Project Overview

This project provisions a production-ready Linux server with:

- System hardening for security best practices
- Docker container runtime
- k3s lightweight Kubernetes cluster
- Nginx deployment exposed via NodePort

Perfect for learning platform engineering, DevOps practices, and Kubernetes fundamentals.

## Architecture
Client Request → NodePort (30000-32767) → Service → Pod (Nginx)

text

## Prerequisites

- Ubuntu 22.04 or 24.04 LTS server
- Minimum 2GB RAM, 2 CPU cores
- Root or sudo access
- Internet connection

## Project Structure
linux-production-server/
├── scripts/ # Automation scripts (run in order)
│ ├── base.sh # 1. System updates & essentials
│ ├── users.sh # 2. Create non-root user
│ ├── security.sh # 3. Security hardening
│ ├── docker.sh # 4. Docker installation
│ └── k3s.sh # 5. k3s Kubernetes setup
├── docs/ # Documentation
│ ├── users-setup.md # User management details
│ └── docker-setup.md # Docker configuration
└── README.md # This file

text

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/nazmur96/linux-production-server.git
cd linux-production-server
2. Make Scripts Executable
bash
chmod +x scripts/*.sh
3. Run Scripts in Order
bash
# Step 1: Base system setup
sudo bash scripts/base.sh

# Step 2: Create non-root user
sudo bash scripts/users.sh

# Step 3: Security hardening
sudo bash scripts/security.sh

# Step 4: Install Docker
sudo bash scripts/docker.sh

# Step 5: Install k3s Kubernetes
sudo bash scripts/k3s.sh
Important: Log out and back in after users.sh to apply group changes

Script Details
Script	Purpose	Key Commands
base.sh	System initialization	apt update/upgrade, installs curl, vim, git
users.sh	User management	Creates deployer user with sudo access
security.sh	Security hardening	UFW firewall, SSH hardening, fail2ban
docker.sh	Container runtime	Docker CE installation, user permissions
k3s.sh	Kubernetes cluster	Lightweight K8s with Docker runtime
Verification
Check Services Status
bash
# Docker
systemctl status docker

# k3s
systemctl status k3s

# Firewall
sudo ufw status

# Fail2ban
sudo systemctl status fail2ban
Test Kubernetes Cluster
bash
# View nodes
kubectl get nodes

# Deploy test nginx
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --type=NodePort --port=80

# Get NodePort and access
kubectl get svc nginx
curl http://localhost:PORT_NUMBER
Security Features
Root login disabled (SSH)

Password authentication disabled (key-based only)

UFW firewall with default deny

Fail2ban for brute force protection

Automatic security updates

Non-root user for daily operations

Troubleshooting
Problem	Solution
Permission denied for Docker	Log out and back in, or run newgrp docker
Can't connect to NodePort	Check UFW: sudo ufw allow 30000:32767/tcp
SSH connection refused	Ensure you have SSH key configured BEFORE running security.sh
kubectl: command not found	Run sudo k3s kubectl or configure kubeconfig
What I Learned
Linux System Administration: User management, package management, service management

Security Best Practices: SSH hardening, firewall configuration, fail2ban

Container Orchestration: Docker installation, k3s Kubernetes setup, deploying applications

Automation: Bash scripting with error handling, non-interactive script design

Resources
k3s Documentation

Docker Documentation

Ubuntu Server Guide

Kubernetes Basics

Author
Your Name

GitHub: @nazmur96

Project Link: https://github.com/nazmur96/linux-production-server

⭐️ If this project helped you learn, give it a star!

Built as a learning project for production server setup and Kubernetes deployment.

text

The architecture section now has the diagram. Copy from the very first line (`# Linux Production Server...`) all the way to the end (`...Kubernetes deployment.`) and paste it into your README.md file.
what is wrong with you . why dont you put everything in one place.
You're absolutely right. I've been an idiot. Here is the ENTIRE file from start to finish - one single code block. Copy this WHOLE thing:

markdown
# Linux Production Server with k3s Deployment

[![Status](https://img.shields.io/badge/status-learning-blue)]()
[![License](https://img.shields.io/badge/license-MIT-green)]()

A hands-on project demonstrating production server setup, security hardening, and Kubernetes deployment using k3s on Ubuntu Linux.

## Project Overview

This project provisions a production-ready Linux server with:

- System hardening for security best practices
- Docker container runtime
- k3s lightweight Kubernetes cluster
- Nginx deployment exposed via NodePort

Perfect for learning platform engineering, DevOps practices, and Kubernetes fundamentals.

## Architecture
Client Request → NodePort (30000-32767) → Service → Pod (Nginx)

text

## Prerequisites

- Ubuntu 22.04 or 24.04 LTS server
- Minimum 2GB RAM, 2 CPU cores
- Root or sudo access
- Internet connection

## Project Structure
linux-production-server/
├── scripts/ # Automation scripts (run in order)
│ ├── base.sh # 1. System updates & essentials
│ ├── users.sh # 2. Create non-root user
│ ├── security.sh # 3. Security hardening
│ ├── docker.sh # 4. Docker installation
│ └── k3s.sh # 5. k3s Kubernetes setup
├── docs/ # Documentation
│ ├── users-setup.md # User management details
│ └── docker-setup.md # Docker configuration
└── README.md # This file

text

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/nazmur96/linux-production-server.git
cd linux-production-server
2. Make Scripts Executable
bash
chmod +x scripts/*.sh
3. Run Scripts in Order
bash
# Step 1: Base system setup
sudo bash scripts/base.sh

# Step 2: Create non-root user
sudo bash scripts/users.sh

# Step 3: Security hardening
sudo bash scripts/security.sh

# Step 4: Install Docker
sudo bash scripts/docker.sh

# Step 5: Install k3s Kubernetes
sudo bash scripts/k3s.sh
Important: Log out and back in after users.sh to apply group changes

Script Details
Script	Purpose	Key Commands
base.sh	System initialization	apt update/upgrade, installs curl, vim, git
users.sh	User management	Creates deployer user with sudo access
security.sh	Security hardening	UFW firewall, SSH hardening, fail2ban
docker.sh	Container runtime	Docker CE installation, user permissions
k3s.sh	Kubernetes cluster	Lightweight K8s with Docker runtime
Verification
Check Services Status
bash
# Docker
systemctl status docker

# k3s
systemctl status k3s

# Firewall
sudo ufw status

# Fail2ban
sudo systemctl status fail2ban
Test Kubernetes Cluster
bash
# View nodes
kubectl get nodes

# Deploy test nginx
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --type=NodePort --port=80

# Get NodePort and access
kubectl get svc nginx
curl http://localhost:PORT_NUMBER
Security Features
Root login disabled (SSH)

Password authentication disabled (key-based only)

UFW firewall with default deny

Fail2ban for brute force protection

Automatic security updates

Non-root user for daily operations

Troubleshooting
Problem	Solution
Permission denied for Docker	Log out and back in, or run newgrp docker
Can't connect to NodePort	Check UFW: sudo ufw allow 30000:32767/tcp
SSH connection refused	Ensure you have SSH key configured BEFORE running security.sh
kubectl: command not found	Run sudo k3s kubectl or configure kubeconfig
What I Learned
Linux System Administration: User management, package management, service management

Security Best Practices: SSH hardening, firewall configuration, fail2ban

Container Orchestration: Docker installation, k3s Kubernetes setup, deploying applications

Automation: Bash scripting with error handling, non-interactive script design

Resources
k3s Documentation

Docker Documentation

Ubuntu Server Guide

Kubernetes Basics

Author
Your Name

GitHub: @nazmur96

Project Link: https://github.com/nazmur96/linux-production-server

⭐️ If this project helped you learn, give it a star!
