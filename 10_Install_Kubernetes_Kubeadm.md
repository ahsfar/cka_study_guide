# Install Kubernetes Kubeadm way

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

<details><summary>show</summary>
<p>
  
```bash
- Create VM's for master and workder nodes.

- set net.bridge.bridge-nf-call-iptables to 1:

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system
- Install container runtime if not installed.
- Install kubeadm, kubectl and kubelet on all nodes

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

sudo mkdir -m 755 /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

# To see the new version labels
sudo apt-cache madison kubeadm

sudo apt-get install -y kubelet=1.27.0-2.1 kubeadm=1.27.0-2.1 kubectl=1.27.0-2.1

sudo apt-mark hold kubelet kubeadm kubectl
```

</p>
</details>

