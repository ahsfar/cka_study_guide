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

Upgrading controlplane from 1.26.0 to 1.27.0

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

Upgrading Worker node from 1.26.0 to 1.27.0

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

1) Resoruce config => kubeapi-server (Externel tool can be used like velero) -> in some cases this is useful when etch cluster is not available
2) ETCD cluster => create snapshots of the etcd cluster

<details><summary>show</summary>
<p>
  
```bash
kubectl get all all namespaces o yaml all deploy services.yaml

export ETCDCTL_API=3 

ETCDCTL_API=3 etcdctl \
  snapshot save snapshot.db

ls

ETCDCTL_API=3 etcdctl \
  snapshot status snapshot.db

service kube apiserver stop

ETCDCTL_API=3 etcdctl \
  snapshot restore snapshot.db
  --data dir /var/lib/etcd from backup
  --initial cluster master-1=https://192.168.5.11:2380,master-2=https://192.168.5.12:2380
  --initial cluster token etcd cluster 1 \
  --initial advertise peer urls https://${INTERNAL_IP}:2380

service kube apiserver start
systemctl daemon reload
service etcd restart


kubectl logs etcd-controlplane -n kube-system
kubectl -n kube-system logs etcd-controlplane | grep -i 'etcd-version'
kubectl -n kube-system describe pod etcd-controlplane | grep Image:
kubectl -n kube-system describe pod etcd-controlplane | grep '\--listen-client-urls'

ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/snapshot-pre-boot.db

ETCDCTL_API=3 etcdctl  --data-dir /var/lib/etcd-from-backup \
snapshot restore /opt/snapshot-pre-boot.db

vim /etc/kubernetes/manifests/etcd.yaml

volumes:
  - hostPath:
      path: /var/lib/etcd-from-backup
      type: DirectoryOrCreate
    name: etcd-data
```

</p>
</details>

### Backup and Restore Method 2



<details><summary>show</summary>
<p>
  
```bash
kubectl config use-context cluster1

kubectl get pods -n kube-system  | grep etcd

ls /etc/kubernetes/manifests/ | grep -i etcd

ps -ef | grep etcd
kubectl -n kube-system describe pod kube-apiserver-cluster2-controlplane | grep etcd

kubectl config use-context cluster1
 kubectl describe  pods -n kube-system etcd-cluster1-controlplane  | grep advertise-client-urls
kubectl describe  pods -n kube-system etcd-cluster1-controlplane  | grep pki
ETCDCTL_API=3 etcdctl --endpoints=https://10.1.220.8:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save /opt/cluster1.db
Snapshot saved at /opt/cluster1.db

scp cluster1-controlplane:/opt/cluster1.db /opt
```

<details><summary>restore etcd</summary>
<p>
  
```bash
scp /opt/cluster2.db etcd-server:/root
etcd-server ~ ➜  ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/etcd.pem --key=/etc/etcd/pki/etcd-key.pem snapshot restore /root/cluster2.db --data-dir /var/lib/etcd-data-new

vi /etc/systemd/system/etcd.service

[Unit]
Description=etcd key-value store
Documentation=https://github.com/etcd-io/etcd
After=network.target

[Service]
User=etcd
Type=notify
ExecStart=/usr/local/bin/etcd \
  --name etcd-server \
  --data-dir=/var/lib/etcd-data-new \
---End of Snippet---


etcd-server /var/lib ➜  chown -R etcd:etcd /var/lib/etcd-data-new

etcd-server /var/lib ➜  ls -ld /var/lib/etcd-data-new/

etcd-server ~/default.etcd ➜  systemctl daemon-reload 
etcd-server ~ ➜  systemctl restart etcd
```

</p>
</details>
