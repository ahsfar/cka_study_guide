
# Practice/Challenge Test A

## Practice the following commands and Q's .

Source for practice tests
https://www.youtube.com/watch?v=vVIcyFH20qU
https://www.youtube.com/watch?v=o_7jlMBHFFA
https://www.youtube.com/watch?v=Zm5sy6otLGc&t=342s

  
Common Kubeconfig locations
/var/lib/kubelet/kubeconfig
/etc/kubernetes/kubelet.conf

Troubleshooting Links:
https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/


### Join a workder node to the cluster
```bash
# Run on the master node
kubeadm token create --print-join-command

sudo kubeadm join [your-master-node-ip]:6443 --token [your-token] --discovery-token-ca-cert-hash sha256:[your-hash]

```

###  Cluster Upgrade to a specific version
```bash

```

### ETCD backup and restore
  
```bash

```


### Reschedule pods to another node

```bash

```

### Create pod expose internally, create another pod to test dns lookup and store pod and service info on file.svc and file.pod

```bash
kubectl run my-pod --image=nginx

kubectl expose pod my-pod --port=80 --name=my-service --cluster-ip="None"


kubectl run dns-test --image=busybox --restart=Never -- sleep 3600
kubectl exec dns-test -- nslookup my-service > file.svc
kubectl get pod my-pod -o wide > file.pod


```