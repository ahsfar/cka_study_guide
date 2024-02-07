
# Practice/Challenge Test Set 3

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash



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

#  pod troubleshooting - kubelet
sudo systemctl status kubelet
sudo systemctl start kubelet
sudo systemctl restart kubelet
# kubelet service errors
journalctl -u kubelet

---

# Preparing for node upgrade
k get pods -o wide
k get nodes
k cordon node1
k drain node1 --ignore-daemonsets --force
k get pods -o wide
k get nodes

---

# Temp pod delete after creation 
k run temp-pod --image=nginx --restart=Never --rm -it -- /bin/sh -c 'echo "something"'

---

# Annotate a pod 
# Annotations are a powerful feature for adding contextual information to your Kubernetes objects, 
# enhancing both the manageability and the operational visibility of your applications in Kubernetes.
k annotate pod my-app-pod git-commit="123abc"
k annotate pod my-app-pod git-commit="456def" pipeline-id="pipeline-789" deployment-timestamp="2024-02-01T15:04:05Z"
k describe pod my-app-pod | grep -i annotations 

```

</p>
</details>
