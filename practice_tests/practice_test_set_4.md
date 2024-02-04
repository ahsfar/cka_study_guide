
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

# network policy to allow traffic from a pod to other pods

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

                    



```

</p>
</details>
