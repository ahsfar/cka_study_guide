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

### Backup and Restore Method 1

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
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
