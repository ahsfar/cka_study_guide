# Application Lifecycle Management

### Rolling Updates

Performing updates on deployments. Two deployment strategies:

1) Recreate: Kill all and update and bring up.
2) Rolling update (By default): kill 1 update 1 and continue. It creates new replicasets in case we want to roll back to older version we can do so.

<details><summary>show</summary>
<p>
  
```bash
kubectl rollout status deployment/ myapp deployment                        (Create)       
kubectl rollout history deployment/ myapp deployment                       (Get)  
kubectl create -f deployment definition.yml                                (Update)
kubectl get deployments                                                 
kubectl apply -f deployment definition.yml                                 (Status)
kubectl set image deployment/ myapp deployment nginx =nginx:1.9.1      
kubectl rollout undo deployment/ myapp deployment                          (Rollback)

k get pods
ls
bash curl-test.sh 
k get pods
k describe pod
k get all
k describe deployments.apps 
k edit deployments.apps 
k get pods
k get rs
k describe pods
ls
bash curl-test.sh 
k describe deployments.apps 
k describe deployments.apps | grep -i rollingupdatestrategy
k edit deployments.apps 
k describe deployments.apps 
k edit deployments.apps --image=kodekloud/webapp-color:v3
k edit deployment frontend 
k get pods
k describe po frontend-744f8c4fd4-
```

</p>
</details>

### Commands and Arguments

Just lik in docker file you can have ENTRYPOINT and CMD. And also pass arguements when entring docker run command. You can have in pod-definition file as well.

<details><summary>show</summary>
<p>
  
```bash
---
apiVersion: v1 
kind: Pod 
metadata:
  name: ubuntu-sleeper-2 
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command:
      - "sleep"
      - "5000"

Dockerfile
FROM python:3.6-alpine

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "app.py"]

CMD ["--color", "red"]

Pod.yaml
apiVersion: v1 
kind: Pod 
metadata:
  name: webapp-green
  labels:
      name: webapp-green 
spec:
  containers:
  - name: simple-webapp
    image: kodekloud/webapp-color
    command: ["python", "app.py"]
    args: ["--color", "pink"]

e.g.
---
apiVersion: v1 
kind: Pod 
metadata:
  name: webapp-green
  labels:
      name: webapp-green 
spec:
  containers:
  - name: simple-webapp
    image: kodekloud/webapp-color
    args: ["--color", "green"]
```

</p>
</details>

### Environment Variables

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Secrets

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Multi-container Pods

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Innit Conatiners

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>


