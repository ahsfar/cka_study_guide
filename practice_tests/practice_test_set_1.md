# Practice Test Set 1 

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Update image imperativce way 
k get deployment -o wide
k set image deployment <image_name>=<image_name>:1.1.19

---

# Update the static pod path (static pod is pod which creates itself after deletion)
ps -aux | grep kubelet
# look for --config=/var/lib/kubelet/config.yaml
-> vim above_file.yaml
-> change staticPodPath: etc/kubernetes/manifest

---

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

# Create a pod with labels
k run <pod_name> --image=redis:alpine -l tier=redis
k describe pod <pod_name>

---

# Create pod in namespace
k create namesapce <namepsace_name>
k run <pod_name> --image=<img_name>:alpine -n <ns_name>

---

# 


```

</p>
</details>
