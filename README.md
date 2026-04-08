# Linux Production Server with k3s Deployment

[![Status](https://img.shields.io/badge/status-learning-blue)]()
[![License](https://img.shields.io/badge/license-MIT-green)]()

A comprehensive hands-on project demonstrating production server setup, security hardening, and Kubernetes deployment using k3s on Ubuntu Linux.

## 🎯 Project Overview

This project provisions a production-ready Linux server with:
- **System hardening** for security best practices
- **Docker** container runtime
- **k3s** lightweight Kubernetes cluster
- **Nginx** deployment exposed via NodePort

Perfect for learning platform engineering, DevOps practices, and Kubernetes fundamentals.

## 🏗️ Architecture


Client Request → NodePort (30000-32767) → Service → Pod (Nginx)


## 📋 Prerequisites

- Ubuntu 22.04 or 24.04 LTS server
- Minimum 2GB RAM, 2 CPU cores
- Root or sudo access
- Internet connection

## 📁 Project Structure
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


## 🚀 Quick Start

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


⚠️ Important: Log out and back in after users.sh to apply group changes

users.sh to apply group changes

🔧 Script Details
Script	Purpose	Key Commands
base.sh	System initialization	apt update/upgrade, installs curl, vim, git
users.sh	User management	Creates deployer user with sudo access
security.sh	Hardening	UFW firewall, SSH hardening, fail2ban
docker.sh	Container runtime	Docker CE installation, user permissions
k3s.sh	Kubernetes	Lightweight K8s with Docker runtime
✅ Verification Steps
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

# View pods
kubectl get pods --all-namespaces

# Deploy test nginx
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --type=NodePort --port=80

# Get NodePort and access
kubectl get svc nginx
curl http://localhost:PORT_NUMBER
🔒 Security Features
✅ Root login disabled (SSH)

✅ Password authentication disabled (key-based only)

✅ UFW firewall with default deny

✅ Fail2ban for brute force protection

✅ Automatic security updates

✅ Non-root user for daily operations

📊 What I Learned
Through this project, I gained hands-on experience with:

Linux System Administration

User management and sudo configuration

Package management with apt

Service management with systemctl

Security Best Practices

SSH hardening techniques

Firewall configuration (UFW)

Fail2ban implementation

Container Orchestration

Docker installation and configuration

k3s Kubernetes cluster setup

Deploying and exposing applications

Automation

Bash scripting with error handling (set -e)

Non-interactive script design (-y flags)

Idempotent operations (checking before creating)

🐛 Troubleshooting
Common Issues
Problem	Solution
"Permission denied" for Docker	Log out and back in, or run newgrp docker
Can't connect to NodePort	Check UFW: sudo ufw allow 30000:32767/tcp
SSH connection refused after security.sh	Ensure you have SSH key configured BEFORE running
kubectl: command not found	Run sudo k3s kubectl or configure kubeconfig
Getting Help
Check service logs: sudo journalctl -u SERVICE_NAME -f

Verify script order (must run sequentially)

Ensure Ubuntu version is 22.04+

📚 Resources
k3s Documentation

Docker Documentation

Ubuntu Server Guide

Kubernetes Basics

🔄 Future Improvements
Add monitoring with Prometheus + Grafana

Implement CI/CD pipeline with GitHub Actions

Add Helm charts for package management

Configure Ingress controller for HTTP routing

Add persistent volume storage examples

Create Terraform configuration for cloud deployment

📝 License
This project is for educational purposes. MIT License.

👤 Author
Your Name

GitHub: @nazmur96

Project Link: https://github.com/nazmur96/linux-production-server

⭐️ If this project helped you learn, give it a star!
