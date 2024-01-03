# Cluster Maintenance

### OS Upgrade

For performing OS upgrades you can drain the nodes and then mark them as unscheduled and then after upgrade mark them as scheduled.

Remember pod eviction period is 5 mins which means if somehting goes wrong to pod node will wait for 5 mins if pod is not up it marks them as dead or temrinated.

If there is replicasets active those pods are recreated in other nodes.

Drain node will termiante the nodes from this node and recreate them in new node.
<details><summary>show</summary>
<p>
  
```bash
kubectl drain node01 --ignore-daemonsets

k get nodes
k get pods
k get pods -n default 
k describe pods
k describe pods -o wide
k get pods -n default -o wide
k drain node01 
clear
kubectl drain node01 --ignore-daemonsets
k get nodes
k describe node node01 
k get pods all -o wide
k get pods -o wide
k uncordon node01 
k get pods -o wide
k describe nodes controlplane 
clear
k get nodes
kubectl drain node01 --ignore-daemonsets
k get pods -o wide
k cordon node01 
```

</p>
</details>

### Cluster Upgrade

Only latest 3 versions are supported and should upgrade version by version instaed of jumping to latest versin.
With other cloud providers just one click upgrade but with kubeadm you can run some commands to upgrade.

Master node gets upgraded first and then worker nodes. For worker nodes there are 3 strategies

1st Strategy: all workder nodes update at the same time (downtime)
2nd Strategy: one node at a time 
3rd Strategy: Create upgrade nodes and move workload to new nodes (Convenient to do in cloud)

<details><summary>show</summary>
<p>
  
```bash
kubeadm upgrade plan
apt-get upgrade -y kubeadm=1.12.0 00
kubeadm upgrade apply v1.12.0
kubectl get nodes
apt-get upgrade -y kubelet=1.12.0 00
systemctl restart kubelet

```

</p>
</details>

Upgrading Workder controlplane from 1.26.0 to 1.27.0

<details><summary>controlplane</summary>
<p>
  
```bash
k get node
k describe nodes 
k describe nodes | grep -i taint
k get deployments.apps 
k get all
k get pods -o wide
k get deployments -A
k get deployments -A -o wide
kubeadm upgrade plan
k get node
k drain controlplane --ignore-daemonsets 
cat /etc/*release*
apt-mark unhold kubeadm && apt-get update && apt-get install -y kubeadm='1.27.x-*' && \
apt-mark unhold kubeadm && apt-get update && apt-get install -y kubeadm='1.27.0' && apt-mark hold kubeadm
kubeadm version
apt update
apt-cache madison kubeadm
apt-mark unhold kubeadm && apt-get update && apt-get install -y kubeadm='1.27.0' && apt-mark hold kubeadm
apt-mark unhold kubeadm && apt-get update && apt-get install -y kubeadm='1.27.0-*' && apt-mark hold kubeadm
kubeadm version
kubeadm upgrade plan
sudo kubeadm upgrade apply v1.27.0
apt-mark unhold kubelet kubectl && apt-get update && apt-get install -y kubelet='1.27.0-*' kubectl='1.27.0-*' && apt-mark hold kubelet kubectl
k get nodes
k drain controlplane --ignore-daemonsets 
sudo systemctl daemon-reload
sudo systemctl restart kubelet
k get noes
k get nodes
k uncordon controlplane 
k drain node01 --ignore-daemonsets 
k get nodes
k uncordon node01 
k get nodes


```

</p>
</details>

Upgrading Workder node from 1.26.0 to 1.27.0
<details><summary>workder node</summary>
<p>
  
```bash
apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm='1.27.0-*' && \
apt-mark hold kubeadm

sudo kubeadm upgrade node

kubectl drain node01 --ignore-daemonsets

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet='1.27.0-*' kubectl='1.27.0-*' && \
apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet

kubectl uncordon node01
```

</p>
</details>

### Backup and Restore Method 1

tct

<details><summary>show</summary>
<p>
  
```bash
k get node

```

</p>
</details>

### Backup and Restore Method 2

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>
