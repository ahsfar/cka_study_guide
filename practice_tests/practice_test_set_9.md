
# Practice/Challenge Test Set 9

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Update the static pod path (static pod is pod which creates itself after deletion)
ps -aux | grep kubelet
# look for --config=/var/lib/kubelet/config.yaml
vim config.yaml # above file
-> change staticPodPath: etc/kubernetes/manifest


----

# Tolerant Pod

apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  tolerations:
  - key: "example-key"
    operator: Equal
    value: "value1"
    effect: NoSchedule


----

# init containers

https://kubernetes.io/docs/concepts/workloads/pods/init-containers/

apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app.kubernetes.io/name: MyApp
spec:
  containers:
  - name: myapp-container
    image: busybox:1.28
    command: ['sh', '-c', 'echo The app is running! && sleep 3600']
  initContainers:
  - name: init-myservice
    image: busybox:1.28
    command: ['sh', '-c', "until nslookup myservice.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for myservice; sleep 2; done"]
  - name: init-mydb
    image: busybox:1.28
    command: ['sh', '-c', "until nslookup mydb.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for mydb; sleep 2; done"]


# create below to see the main container in running status

---
apiVersion: v1
kind: Service
metadata:
  name: myservice
spec:
  ports:
  - protocol: TCP
    port: 80
    targetPort: 9376
---
apiVersion: v1
kind: Service
metadata:
  name: mydb
spec:
  ports:
  - protocol: TCP
    port: 80
    targetPort: 9377


----

# Least privilege (run as non root user) and mounted volume necessary permissions (fsgroup)

apiVersion: v1
kind: Pod
metadata:
  name: secure-webapp
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: webapp-container
    image: nginx:latest
    ports:
    - containerPort: 8080



```

</p>
</details>
