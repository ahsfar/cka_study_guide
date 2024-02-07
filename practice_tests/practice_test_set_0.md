# Practice/Challenge Test Set 0 

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Upgrade the cluster (kubeadm;kubelet;kubectl)
# Step 1
k drain <node_name>
# Step 2
k uncordon <node_name>
# Step 3
apt update
# Step 4
apt install kubeadm=1.1.19.0-00
# Step 5
kubeadm upgrade apply v1.19.0
# Step 6
apt install kubelet=1.1.19.0-00
# Step 7
apt install kubectl=1.1.19.0-00
# Step 8
systemctl restart kubelet
# Step 9
kubectl uncordon <node_name>

---

# Create deployment with 5 replicas
k create deployment <deployment_name> --image=<image>:x.x-alpine
k scale deployment <deployment_name> --replicas=5
# above in 1 command
k create deployment <deployment_name> --image=<image>:x.x-alpine --replicas=5
# verify
k describe deployment <deployment_name>


---

# Rolling updates of deployment
k create deployment my-deploy --image=my-img:1.15 --replicas=5 --dry-run-client -o yaml > deploy.yaml
k create -f deploy.yaml
k get deployments -o wide
k describe deployment my-deploy
k set image deployment/my-deploy my-image=my-image:1.16 --record
k get deployments -o wide
k rollout history deployment my-deploy 

---

# Creating a static pod
ps -aux | grep kubelet
# look for --config**config.yaml
k get nodes
ssh my-node
cat pathname/config.yaml
# look for staticPodPath: /etc/kubernetes/manifet
exit
k run my-pod --image=my-img --command sleep 1000 --dry-run=client -o yaml > static.yaml
k get nodes -o wide
# get ip
sudo scp static.yaml 102.x.x.x:/root/
ssh my-node
sudo -i
cp /root/static.yaml /etc/kubernetes/manifests
exit
k get pods

---

# Taint a node
k get nodes
k taint node my-node key=value:NoSchedule
k describe node my-node | grep -i taitns
k run my-pod --image=my-image:alpine
k describe pod my-pod
k run new-pod --image=my-img:alpine --dry-run=client -o yaml > tolerant_pod.yaml
# add below in yaml file under spec:
tolerations:
- key: "key"
  effect: "NoSchedule"
  operator: "Equal"
  value: "value"

  ---

# Upgrading the k8 cluster

# drain, cordon, install, upgarde, restart and uncordon on both control plane and worker nodes

```

</p>
</details>


