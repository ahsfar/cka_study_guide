
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

#

---

#

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
