# Scheduling:


### Manual Scheduling:

1) While creating pod

---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: controlplane     ---> controlplane is the node name
  containers:
  -  image: nginx
     name: nginx


### Act as scheduler and bind data to pod, convert ur yaml to json 



kubectl get nodes
kubectl get pods -o wide


kubectl get pods --selector env=dev
kubectl get pods --selector env=dev --no-headers | wc -l
kubectl get pods --selector bu=finance --no-headers | wc -l
kubectl get all --selector env=prod --no-headers | wc -l
kubectl get all --selector env=prod,bu=finance,tier=frontend


---
apiVersion: apps/v1
kind: ReplicaSet
metadata:
   name: replicaset-1
spec:
   replicas: 2
   selector:
      matchLabels:
        tier: front-end   
   template:
     metadata:
       labels:
        tier: front-end         ----------------------> changed from nginx to front-end (matched the labels)
     spec:
       containers:
       - name: nginx
         image: nginx 

kubectl apply -f replicaset-definition-1.yaml

### Taints & Toleration:

Taints are like anti-bug repellent spray on nodes to control which pods are deployed on them. By default master node is tainted that's why no pods are scheduled on the master node by scheduler.

kubectl describe node node01 | grep -i taints
kubectl taint nodes node01 spray=mortein:NoSchedule


Tolearation is for the pods if they can still go to that node even if it's taint. It's to control which particular pod can go on a node.

---
apiVersion: v1
kind: Pod
metadata:
  name: bee
spec:
  containers:
  - image: nginx
    name: bee
  tolerations:
  - key: spray
    value: mortein
    effect: NoSchedule
    operator: Equal

kubectl create -f bee-pod.yaml

k describe node controlplane

// Confirm the taint, remove the taint and then confirm the taint again.
k edit node controlplane
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
//The - at the end indicates that we want to remove this taint from the node.
k edit node controlplane

### Node Selector:

lablel nodes to select them later for the pod to be deployed to.

### Node Affinity:

For complex labeling
In Large,Medium.. or Not In Small
RequireDuringSchedulingIgnoredDuringExecution:
PrefferedDuringSchedulingIgnoredDuringExecution:
RequireDuringSchedulingRequiredDuringExecution:

k describe node01
k describe node node01
k label node node01 color=blue
k describe node node01

kubectl create deployment blue --image=nginx --replicas=3

kubectl get nodes --show-labels


---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      run: nginx
  template:
    metadata:
      labels:
        run: nginx
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
      affinity:                            -----> added afinity section under below container to move the blue deployment only to node which has label color=blue
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: color
                operator: In
                values:
                - blue


➜  cat new.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: red
  name: red
spec:
  replicas: 2
  selector:
    matchLabels:
      app: red
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: red
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: node-role.kubernetes.io/control-plane
                operator: Exists
status: {}


----------
You can use both Taints & Tolerations and Node Affinity to get the more complex/desired results.


### Resource limits:

in yaml file:
resources: (min)
limits: (max)
min=yes max=no is ideal case.
Throttle -> if resources exceeds will error out e.g. OOM (out of memeory)

### ResourceQuota.yml set on namesapce level hardcoded to limit all the resources (eg.g cpu and mem)
