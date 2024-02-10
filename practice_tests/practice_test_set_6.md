
# Practice/Challenge Test Set 6

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# get a list of all the deleted pods

kubectl get events --field-selector reason=Killing -o custom-columns=NAME:.involvedObject.name | awk '!/NAME/{print $1}' | sort -u > recently_deleted_pods.txt


---

# delete pod without delay

K delete pod pod-name --grace-period=0 --force


---

# expose deployment

k expose deployment deploy-name --name=deploy-service-name --port=80 --target-port=80 --type=NodePort
k get svc
k describe svc deploy-service-name


---

# Default deny
https://kubernetes.io/docs/concepts/services-networking/network-policies/


---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
  - Ingress

---

# replicaSets

kubectl create replicaset my-replicaset --image=nginx --replicas=3 --dry-run=client -o yaml > my-replicaset.yaml

# can't use the --replica flag using imperative so do -o yaml and then adjust the file and then apply changes
kubectl apply -f my-replicaset.yaml

---

# create a pod with security context for logging purpose giving permission to use ports without root user and giving net admin task privileges

apiVersion: v1
kind: Pod
metadata:
  name: log-manager
spec:
  containers:
  - name: log-manager-container
    image: log-manager-image:latest
    securityContext:
      capabilities:
        add: ["CAP_NET_BIND_SERVICE", "CAP_NET_ADMIN"]
    ports:
    - containerPort: 80
    - containerPort: 443

---

# 3 probes in kubernetes

Startup Probe: "Has the application finished starting up?"
Liveness Probe: "Is the application still running as expected?"
Readiness Probe: "Is the application ready to do its job (e.g., handle requests)?"

apiVersion: v1
kind: Pod
metadata:
  name: web-app
spec:
  containers:
  - name: web-server
    image: web-app-image:latest
    ports:
    - containerPort: 8080
    # Define resource requests and limits for better resource allocation
    resources:
      requests: # Minimum resources required
        cpu: "100m" # Request 100 millicpu
        memory: "200Mi" # Request 200 MiB of memory
      limits: # Maximum resources allowed
        cpu: "500m" # Limit to 500 millicpu
        memory: "500Mi" # Limit to 500 MiB of memory
    # Readiness probe to check if the container is ready to handle requests
    readinessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
      timeoutSeconds: 1
      successThreshold: 1
      failureThreshold: 3
    # Liveness probe to check if the container is running properly
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 15
      periodSeconds: 20
      timeoutSeconds: 1
      successThreshold: 1
      failureThreshold: 3
    # Startup probe to ensure the application has started correctly
    startupProbe:
      httpGet:
        path: /start
        port: 8080
      initialDelaySeconds: 10
      periodSeconds: 5
      failureThreshold: 30


---

# List all pv sort by storage 
k get pv --sort-by=.spec.capacity.storage

---

# Find pods running high CPU
k top pod --sort-by cpu -l environment=env-name | head -2

---

# Use json path to get all the nodes names
k get nodes -o jsonpath='{.items[*].metadata.name}' > node_names.txt 



```

</p>
</details>
