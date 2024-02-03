
# Practice/Challenge Test Set 3

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Deployment autoscale
k auto-scale deployment dep-name --min=3 --max=6 --cpu-percent=80

---

# No. of nodes in ready status
k descibe nodes | grep ready | wc -l > text.txt

---

# create pod with environment variable
k run env-demo-pod --image=nginx --env="DEMO_ENV_VAR=Hello, World!"
# verify 
k exec env-demo-pod -- printenv DEMO_ENV_VAR
k exec -it env-demo-pod -- sh -c 'echo $DEMO_ENV_VAR'

---

# Adding configmap to pod
k create configmap cm-name --from-literal=user=jane --from-literal=password=abcd1234
k get pod pod-name --dry-run=client -o yaml > pod-name.yaml
# input below under conatiner in spec section
 envFrom:
 - configMapRef:
    name: cm-name

k exec -it pod-name -- env

---

# Results by timestamp
k get events --sort-by=.metadata.creationTimestamp > events.log

---

# Non-pv pod
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: first-container
    image: nginx
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  - name: second-container
    image: alpine
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir: {}

kubectl apply -f example-pod.yaml

---

#

---

#




```

</p>
</details>
