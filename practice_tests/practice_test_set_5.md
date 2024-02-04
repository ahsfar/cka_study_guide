
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

---

# Deployment rollback

kubectl rollout history deployment/my-web-app

kubectl rollout history deployment/my-web-app --revision=2

kubectl rollout undo deployment/my-web-app --to-revision=1

kubectl get deployment my-web-app
kubectl describe deployment my-web-app

---

#



```

</p>
</details>
