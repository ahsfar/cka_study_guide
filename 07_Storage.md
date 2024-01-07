# Storage

Storage driver: ZFS, AUFS, etc based on OS -> Volume mount and bind mount.
Volume driver: local or external (AWs_ebs, or other cloud providers)(if container is killed volume is safe)

CRI: container runtime interface -> for docker, cri-o, rocket etc
CNI: Container Network Interface -> weaveworks, flannel, etc
CSI: Container Storage Interface -> GlusterFS, aws ebs, etc

In Kubernetes you can create volumes on host or external and mount them to your pods.

### Persistant Volumes & Persistant Volumes Claim

PV is cluster wide storage and you can perform PVC to use (bind) the PV created.

<details><summary>show</summary>
<p>
  
```bash
kubectl exec webapp -- cat /log/app.log

kubectl delete po webapp
k run webappp --image=kodekloud/event-simulator --dry-run=client -o yaml > webappp.yaml


apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: webapp
  name: webapp
spec:
  containers:
  - image: kodekloud/event-simulator
    name: webapp
    resources: {}
    volumeMount: /log
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
volume:
  hostPath: /var/log/webapp

=> PV:
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-log
spec:
  persistentVolumeReclaimPolicy: Retain
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 100Mi
  hostPath:
    path: /pv/log

=> PVC:
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: claim-log-1
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Mi


k get persistentvolume
k get persistentvolumeclaims
```

</p>
</details>

### Storage Class

Dynamic provisioning: storage is created in external storage like gcp, etc.
Replace the PV with SC bcz SC contains PV in it. Classes (Silver, Gold, Platinum)

<details><summary>show</summary>
<p>
  
```bash
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-pvc
spec:
  storageClassName: local-storage
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi

kubectl run nginx --image=nginx:alpine --dry-run=client -oyaml > nginx.yaml

---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    volumeMounts:
      - name: local-persistent-storage
        mountPath: /var/www/html
  volumes:
    - name: local-persistent-storage
      persistentVolumeClaim:
        claimName: local-pvc

---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: delayed-volume-sc
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer


```

</p>
</details>

