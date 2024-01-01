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

Just like while running docker command you can pass docker environement variables. In pod definition.yaml file you can have env as below:

1) Plain key value
2) ConfigMap
3) Secrets

<details><summary>show</summary>
<p>
  
```bash
config-map.yaml

apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_COLOR: blue
  APP_MODE: prod

kubectl create –f config-map.yaml
kubectl get configmaps
kubectl describe configmaps

Link in pod:
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
      - containerPort: 8080
      envFrom:
        - configMapRef:
              name: app-config



kubectl create configmap  webapp-config-map --from-literal=APP_COLOR=darkblue --from-literal=APP_OTHER=disregard


---
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
spec:
  containers:
  - env:
    - name: APP_COLOR
      valueFrom:
       configMapKeyRef:
         name: webapp-config-map
         key: APP_COLOR
    image: kodekloud/webapp-color
    name: webapp-color


```

</p>
</details>

There are two ways to create config maps
Imperative: write commands or pass a file
Declarative: write a dfinition file and create that file like pods

Injecting the configMap into the pod definition files:

<details><summary>show</summary>
<p>
  
```bash
=> ENV
envFrom:
  - configMapRef
        name: app config

=> SINGLE ENV
env:
  - name: APP_COLOR
    valueFrom:
        configMapKeyRef:
            name: app config
            key: APP_COLOR

=> VOLUME
volumes:
  - name: app config volume
    configMap:
        name: app config
```

</p>
</details>

### Secrets

ConfigMaps just centralize the data or you can catagrize the data or environment variables in different definition files in text. Secrets come in when you want to pass passwords or sensitive informatoin. 
Which you can encode or decode in base64 and then inject in the pod definition file.
There are two ways to create 
Imperative: write commands or pass a file
Declarative: write a dfinition file and create that file like pods

<details><summary>show</summary>
<p>
  
```bash
kubectl create –f secret-data.yaml

echo –n ‘mysql’ | base64
echo –n ‘bXlzcWw=’ | base64 --decode

kubectl get secrets
kubectl describe secrets
kubectl get secret app-secret –o yaml

kubectl create secret generic db-secret --from-literal=DB_Host=sql01 --from-literal=DB_User=root --from-literal=DB_Password=password123

---
apiVersion: v1 
kind: Pod 
metadata:
  labels:
    name: webapp-pod
  name: webapp-pod
  namespace: default 
spec:
  containers:
  - image: kodekloud/simple-webapp-mysql
    imagePullPolicy: Always
    name: webapp
    envFrom:
    - secretRef:
        name: db-secret
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


