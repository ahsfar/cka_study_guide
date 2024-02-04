
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

#



```

</p>
</details>
