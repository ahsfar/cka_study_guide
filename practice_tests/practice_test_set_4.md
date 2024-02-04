
# Practice/Challenge Test Set 4

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# List all pods in all namespaces
k get pods -A > pods.txt

---

# Update configmap 
k get configmap cm-name
k get configmap cm-name -o yaml > configmap.yaml
# vim configmap.yaml and replace value u want to change 
k replace -f configmap.yaml
# If password still not changed
k get pod pod-name -o yaml | k replace --force -f -
k exec -it pod-name -- env

---

# Troubleshooting pod unable to schedule on node
k get pod pod-name -o wide
k describe pod pod-name
k get pod pod-name -o yaml > newpod.yaml
vim newpod.yaml
# fix the mistakes yaml 
k replace --force -f newpod.yaml
k describe pod pod-name | grep Labels

---

# Network policy to allow traffic from a pod to other pods

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: policy-name
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: allow-outbound
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels: 
          name: department1
    ports:
    - protocol: TCP
      port: 80
  - to:
    - podSelector:
        matchLabels: 
          name: department2
    ports:
    - protocol: TCP
      port: 8080

---

# Set SYS_TIME for pod

apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-4
spec:
  containers:
  - name: sec-ctx-4
    image: gcr.io/google-samples/node-hello:1.0
    command: [ "sh", "-c", "sleep 1h" ]
    securityContext:
      capabilities:
        add: ["SYS_TIME"]

---

# Create clusterrole and clusterrolebindings

kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods
kubectl create clusterrolebinding pod-reader-binding --clusterrole=pod-reader --serviceaccount=default:default


kubectl create serviceaccount monitoring-sa --namespace monitoring
kubectl create clusterrolebinding monitoring-pod-reader-binding --clusterrole=pod-reader --serviceaccount=monitoring:monitoring-sa

# Verify
kubectl auth can-i <verb> <resource> [--namespace <namespace>] [--as <username|serviceaccount>]

kubectl auth can-i create pods
kubectl auth can-i list deployments --namespace my-namespace --as system:serviceaccount:my-namespace:my-service-account
kubectl auth can-i delete nodes --as system:serviceaccount:default:default

kubectl auth can-i list pods --all-namespaces --as system:serviceaccount:monitoring:monitoring-sa


---


#


---

#


```

</p>
</details>
