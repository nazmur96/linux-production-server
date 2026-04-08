# Docker Setup Documentation

## Script: `scripts/docker.sh`

### What it does:
- Installs Docker Engine from official repository
- Configures Docker to start automatically on boot
- Adds `deployer` user to `docker` group (no sudo needed)
- Verifies installation with hello-world container

### Why Docker first, then k3s?
k3s can use Docker as its container runtime instead of containerd.
This gives you flexibility and familiar Docker commands.

### Key concepts:

| Concept | Explanation |
|---------|-------------|
| GPG key | Cryptographically verifies packages are official |
| Repository | Where apt gets Docker packages from |
| docker group | Users in this group can run Docker commands |
| systemctl enable | Makes Docker start on server reboot |

### Verification commands:
```bash
# Check Docker version
docker --version

# List running containers
docker ps

# Test with nginx
docker run -d -p 8080:80 nginx
curl localhost:8080
