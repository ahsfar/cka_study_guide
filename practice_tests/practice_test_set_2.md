
# Practice/Challenge Test Set 2

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Check container logs
k logs pod-name -c container-name -n ns-name > file.log

---

# Basic Ingress file 
vim ingress.yaml

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ing-name
  namespace: ingress-ns
spec:
  rules:
  - http:
      paths:
      - path: /here
        pathType: Prefix
        backend:
          service:
            name: test
            port:
              number: 8080

---

# Overwrite lable
k label pod/pod-name env=new-label --overwrite

---

# Upgrade the image in deployment
k describe deployment dep-name | grep Image
k set image deployment dep-name image=newimage:1.28 --record
k rollout undo deployment dep-name 
k describe deployment dep-name | grep Image

---

# Pods with lable
k get pods -l env=me > pods_me.txt

---

# Pod on specific node
k lable nodes node-name env=prod
k run pod-name --image=img-name --dry-run=client -o yaml > new-pod.yaml
vim new-pod.yaml
# under spec:
    nodeSelector: 
        env: prod

k get pod pod-name -o wide 

---

# PVC for pod
vim pvc.yaml

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi

# then pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
    volumeMounts:
    - mountPath: "/usr/share/nginx/html"
      name: my-volume
  volumes:
  - name: my-volume
    persistentVolumeClaim:
      claimName: my-pvc

# This is dynamic provisionong -> K8 will create pv dynamically for pvc if doesn't exist.
k get pvc # and it should show bound
---

# Untaint a node
kubectl taint nodes <node-name> <taint-key>-
kubectl taint nodes node1 key:NoSchedule-

---

# ETCD backup and restore 
# https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=<trusted-ca-file> --cert=<cert-file> --key=<key-file> \
  snapshot save <backup-file-location>

ETCDCTL_API=3 etcdctl --data-dir <data-dir-location> snapshot restore snapshot.db

export ETCDCTL_API=3

export ETCDCTL_CACERT="/path/to/ca.crt"
export ETCDCTL_CERT="/path/to/etcd.crt"
export ETCDCTL_KEY="/path/to/etcd.key"

etcdctl snapshot save /path/to/snapshot.db
# restore snapshot
sudo systemctl stop etcd

etcdctl snapshot restore /path/to/snapshot.db --data-dir /path/to/new/data-dir

sudo systemctl daemon-reload
sudo systemctl start etcd

etcdctl member list
etcdctl endpoint health

---

# 


```

</p>
</details>
