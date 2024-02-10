
# Practice/Challenge Test Set 9

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Update the static pod path (static pod is pod which creates itself after deletion)
ps -aux | grep kubelet
# look for --config=/var/lib/kubelet/config.yaml
vim config.yaml # above file
-> change staticPodPath: etc/kubernetes/manifest


---

#


---

#


---

# Least privilege (run as non root user) and mounted volume necessary permissions (fsgroup)

apiVersion: v1
kind: Pod
metadata:
  name: secure-webapp
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: webapp-container
    image: nginx:latest
    ports:
    - containerPort: 8080



```

</p>
</details>
