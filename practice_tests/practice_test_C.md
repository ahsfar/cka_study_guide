
# Practice/Challenge Test C

## Practice the following commands and Q's .

###  pv & pvc

https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

Create PV named web-pv
capacity of 2Gi
accessMode ReadWriteOnce
hostpath /vol/data
no storageClassName

```bash
k create pv web-pb --capacity=2Gi --access-mode=ReadWriteOnce --hostPath=/vol/data


```

create pvc -n production 
name web-pvc
storage request 2Gi
accessMode readWriteOnce 
no storageClassName
pvc bound to pv


```bash
k create pvc -n production --request-storage=2Gi --access-mode=ReadWriteOnce --pv web-pv

k create deployment web-deploy -n production --image nginx:1.14.2 --dry-run=client -o yaml > deploy.yaml
```


=> mount 
# under container
volumeMounts:
- mountpath: /tmp/web-data 
  name: web-data
# under spec
volumes:
- name: web-data
  emptyDir: {}

### expose pod -> nodeport

expose pod nginxpod
svc name nginxnodeportsvc
type nodeport = 30200


```bash
k expose pod nginxpod --name=nginxnodeportsvc --type=NodePort --port=80 --target-port=80 --node-port=30200 


k expose pod nginxpod --name=nginxnodeportsvc --port=80 --type=NodePort

k edit pvc nginxnodeportsvc
# change the nodeport: 30200 and save file

k get nodes -o wide
curl node_ip:30200
```

### daemonSet
https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/

-n project-1
create DaemonSet name daemon-imp
image httpd:2.4-alpine
labels -d=daemon-imp uuid=18426a0b-5f59
request:
20 millicore cpu 
20 mebibyte memory



```bash
k create ds daemon-imp -n project-1 --image=httpd:2.4-alpine --label=d=daemon-imp --label=uuid=18426a0b-5f59 --requests=cpu=20m,memory=20Mi --dry-run=client -o yaml > ds.yaml
```

### Network policy
https://kubernetes.io/docs/concepts/services-networking/network-policies/

db pods on Project-a ns -> only accessible from -> service pods in Project-b ns
```bash
k get ns
k get pods -n project-a
k get pods -n project-b
k get pods -n project-c
k get pods -o wide -n project-a
k -n project-b exec service-pod -- ping db_ip
```


Check other pods in other ns connection to db pod

Label ns a and b
```bash
k lable ns project-a namespace=project-a
```


Get lables for both ns pods
```bash
k get pods -n project-a --show-labels
```


```bash
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
  namespace: project-a
spec:
  podSelector:
    matchLabels:
      app: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          namespace: project-a
      podSelector:
        matchLabels:
          app: service

```

### Role and Rolebinding



```bash
k create sa gitops -n project-1 
k create role gitops-role --verb=create --resource=secrets,configmaps -n project-1
k create rolebinding gitops-role-binding --role=gitops-role --sa=project-1:gitops -n project-1

k -n project-1 auth can-i create pod --as system:serviceaccount:project-1:gitops
k -n project-1 auth can-i create secrets --as system:serviceaccount:project-1:gitops
k -n project-1 auth can-i create configmap --as system:serviceaccount:project-1:gitops
```