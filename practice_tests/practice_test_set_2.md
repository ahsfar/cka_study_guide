
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

#


---

#

---

#


---

#


```

</p>
</details>
