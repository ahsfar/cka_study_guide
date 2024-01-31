
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

#


---

#



```

</p>
</details>
