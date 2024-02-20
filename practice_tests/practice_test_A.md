
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

Check Kubernetes documentaion:
https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/


```bash
# Get trusted-ca-file, cert-file and key-file from the description of the etcd Pod.

ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=<trusted-ca-file> --cert=<cert-file> --key=<key-file> \
  snapshot save <backup-file-location>


ETCDCTL_API=3 etcdctl snapshot restore backup.db \
  --endpoints=[localhost:2379] \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --data-dir /var/lib/etcd-from-backup \

```


### Reschedule pods to another node

```bash
kubectl drain [node-name] --ignore-daemonsets

```

### Create pod expose internally, create another pod to test dns lookup and store pod and service info on file.svc and file.pod

```bash
kubectl run my-pod --image=nginx

kubectl expose pod my-pod --port=80 --name=my-service --cluster-ip="None"


kubectl run dns-test --image=busybox --restart=Never -- sleep 3600
kubectl exec dns-test -- nslookup my-service > file.svc
kubectl get pod my-pod -o wide > file.pod


```