
# Practice/Challenge Test Set 5

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Network Policy
# 1. Allow traffic from Pods in the frontend-ns namespace with a specific label (e.g., role: frontend) to Pods in the 
# backend-ns namespace with a specific label (e.g., role: backend).
# 2. Allow traffic from any Pod within the backend-ns namespace to Pods in the same namespace with the role: backend label.

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend-access-policy
  namespace: backend-ns
spec:
  podSelector:
    matchLabels:
      role: backend
  policyTypes:
    - Ingress
  ingress:
    - from:
      - namespaceSelector:
          matchLabels:
            name: frontend-ns
        podSelector:
          matchLabels:
            role: frontend
      - podSelector: {}

k apply -f backend-access-policy.yaml


----

# Liveness probe - Real-World Scenario: Web Server Health Check

apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  containers:
  - name: web-server
    image: my-web-server:latest
    ports:
    - containerPort: 8080
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 15
      periodSeconds: 20

kubectl apply -f webapp-liveness.yaml
kubectl describe pod webapp | grep -i liveness 

# by default restartpolicy is Always if not specified it will restart if liveness probe health check fails


----

# Setting resources -> requests and limits for pod

https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

---
apiVersion: v1
kind: Pod
metadata:
  name: frontend
spec:
  containers:
  - name: app
    image: images.my-company.example/app:v4
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
  - name: log-aggregator
    image: images.my-company.example/log-aggregator:v6
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"

----

# Non-persistent storage (normally for logging)

apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: registry.k8s.io/test-webserver
    name: test-container
    volumeMounts:
    - mountPath: /data/logs
      name: logs-volume
  volumes:
  - name: logs-volume
    emptyDir: {}

----

# expose pod internally 

k expose pod pod-name --name=service-name --port=80 --target-port=80 --type=ClusterIP
k run test-pod --image=nginx:1.12 --rm -it --restart=Never -- nslookup service-name


----

# DaemonSet (ensures all the nodes run a copy of the pod)(create a deployment and then edit yaml later)

k create deployment test-daemon --image=img-name:alpine --dry-run=client -o yaml > test-daemon.yaml
# change kind: DaemonSet
# delete replica line


----

# Assigning a pod to a node

k run pod-name --image=img-name --dry-run=client -o yaml > pod-name.yaml
vim pod-name.yaml
# under spec:
 nodeName: node01

k create -f pod-name.yaml
k get pod pod-name -o wide


----

# all contexts in a file

k config get-contexts -o name > kube_contexts.txt


for context in $(cat kube_contexts.txt); do
  kubectl --context="$context" apply -f deployment.yaml
done




```

</p>
</details>
