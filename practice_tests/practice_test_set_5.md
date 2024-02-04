
# Practice/Challenge Test Set 5

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Network Policy
# Allow traffic from Pods in the frontend-ns namespace with a specific label (e.g., role: frontend) to Pods in the backend-ns namespace with a specific label (e.g., role: backend).
# Allow traffic from any Pod within the backend-ns namespace to Pods in the same namespace with the role: backend label.

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

kubectl apply -f backend-access-policy.yaml


---

#


---

#


---

#



```

</p>
</details>
