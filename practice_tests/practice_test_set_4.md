
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

#


---

#



```

</p>
</details>
