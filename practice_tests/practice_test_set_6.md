
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

#

---

#

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
