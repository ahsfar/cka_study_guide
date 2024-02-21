
# Practice/Challenge Test B

## Practice the following commands and Q's .

### Rolling update using imperative commands
```bash
kubectl set image deployment/[deployment-name] [container-name]=[new-image]:[tag]

kubectl set image deployment/nginx-deployment nginx=nginx:1.19.0

```

### Static pod on node01
SSH into node01.
Create a pod definition file, e.g., my-static-pod.yaml, in the /etc/kubernetes/manifests directory (assuming this is the kubelet's manifest path).
```bash
apiVersion: v1
kind: Pod
metadata:
  name: my-static-pod
  labels:
    role: myrole
spec:
  containers:
  - name: nginx
    image: nginx

```

### POD with SYS_TIME capablities
```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: time-cap-pod
spec:
  containers:
  - name: test-container
    image: alpine
    command: ["sleep", "3600"]
    securityContext:
      capabilities:
        add: ["SYS_TIME"]
EOF

```