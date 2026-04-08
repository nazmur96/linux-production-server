#!/bin/bash
# ==========================================
# K3S KUBERNETES INSTALLATION SCRIPT
# Purpose: Install lightweight Kubernetes cluster
# Run this AFTER docker.sh
# ==========================================

set -e

echo "========================================="
echo "Starting k3s installation"
echo "========================================="

# ==========================================
# 1. INSTALL K3S (with Docker as runtime)
# ==========================================
# --docker flag: Use Docker instead of containerd
# --write-kubeconfig-mode: Allow non-root user to access kubectl
echo "Installing k3s..."
curl -sfL https://get.k3s.io | sh -s - --docker --write-kubeconfig-mode 644

# ==========================================
# 2. CONFIGURE KUBECONFIG FOR DEPLOYER USER
# ==========================================
echo "Configuring kubectl access for deployer..."

# Create .kube directory for deployer
if id "deployer" &>/dev/null; then
    sudo mkdir -p /home/deployer/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml /home/deployer/.kube/config
    sudo chown -R deployer:deployer /home/deployer/.kube
    echo "kubectl configured for deployer user"
else
    echo "WARNING: deployer user not found"
fi

# ==========================================
# 3. SET ALIASES (optional convenience)
# ==========================================
echo "Setting up aliases..."
echo "alias k='kubectl'" | sudo tee -a /etc/bash.bashrc

# ==========================================
# 4. VERIFY CLUSTER STATUS
# ==========================================
echo "Waiting for cluster to be ready..."
sleep 10

echo "Checking nodes..."
sudo kubectl get nodes

echo "Checking pods in all namespaces..."
sudo kubectl get pods --all-namespaces

# ==========================================
# 5. TEST DEPLOYMENT
# ==========================================
echo "Testing with nginx deployment..."
sudo kubectl create deployment test-nginx --image=nginx
sudo kubectl expose deployment test-nginx --type=NodePort --port=80

echo "Waiting for pod to be ready..."
sleep 5

echo "Services:"
sudo kubectl get svc

# Get NodePort
NODEPORT=$(sudo kubectl get svc test-nginx -o jsonpath='{.spec.ports[0].nodePort}')
echo ""
echo "========================================="
echo "k3s installation complete!"
echo "========================================="
echo ""
echo "✅ Test nginx is running on NodePort: $NODEPORT"
echo "Access it at: http://YOUR_SERVER_IP:$NODEPORT"
echo ""
echo "📝 Useful commands:"
echo "  kubectl get nodes"
echo "  kubectl get pods"
echo "  kubectl get svc"
echo ""
echo "🧹 Clean up test deployment:"
echo "  kubectl delete service test-nginx"
echo "  kubectl delete deployment test-nginx"
