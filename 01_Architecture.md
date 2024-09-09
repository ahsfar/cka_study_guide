# Kubernetes Architecture (Cluster Architecture)


### Docker vs Container D

#### Docker:

- Docker is a comprehensive container platform that includes various components and tools.
- It provides a high-level API and command-line interface (CLI) for container management.
- Docker includes features like container orchestration (Docker Swarm and Kubernetes integration), networking, storage management, and image distribution.
- It is designed to be user-friendly and offers a complete solution for building, running, and managing containers.
- Docker uses its own container runtime, which is responsible for creating and executing containers.

#### containerd:

- containerd is a lightweight, open-source container runtime developed by Docker and later donated to the Cloud Native Computing Foundation (CNCF).
- It focuses specifically on container execution and management, providing a minimalistic and modular approach.
- containerd is designed to be more low-level and is primarily used as a container runtime by other container platforms and orchestration systems.
- It follows the OCI (Open Container Initiative) specifications, ensuring compatibility and interoperability with other OCI-compliant tools.
- containerd is highly extensible and can be integrated with higher-level container management platforms like Kubernetes or Docker.

### ETCD

- Distributed key-value store for cluster configuration and state.
- Stores information about cluster, resources, and operational data.
- Ensures consistency and fault tolerance.
- Critical for cluster reliability and consistency.

### Kube apiserver

- Kubernetes API, often referred to as kubeapi, is the primary interface for interacting with a Kubernetes cluster.
- It provides a set of endpoints and resources that enable users to manage and control the cluster's behavior.
- Through the Kubernetes API, users can create, update, and delete resources such as pods, services, deployments, and more.
- The API allows for automation, integration, and extension of Kubernetes functionality through custom controllers and operators.
- It supports both imperative and declarative approaches for managing the cluster's state.
- kubeapi is a central component that enables interaction with the Kubernetes cluster, facilitating administration, monitoring, and scaling of applications and infrastructure.

###  Kube controller manager

- The Kubernetes Controller Manager is a core component of the Kubernetes control plane.
- It runs a set of built-in controllers responsible for managing various aspects of the cluster's desired state.
- The Controller Manager includes controllers for ReplicaSets, Deployments, StatefulSets, DaemonSets, and more.
- Each controller continuously monitors the cluster's current state and takes actions to reconcile it with the desired state.
- The Controller Manager ensures that the cluster remains in the desired state by handling tasks such as scaling, healing, and maintaining the desired number of replicas.
- It detects and reconciles any discrepancies between the actual state and the desired state defined through Kubernetes resources.
- The Controller Manager plays a vital role in maintaining the reliability, availability, and scalability of applications running on the Kubernetes cluster.

###  kubelet

- The Kubelet is an essential component of a Kubernetes node.
- It runs on every node in the cluster and is responsible for managing the containers and their lifecycle on that node.
- The Kubelet receives instructions from the Kubernetes control plane and ensures that the containers are running as expected.
- It interacts with the container runtime, such as Docker or containerd, to start, stop, and monitor containers.
- The Kubelet monitors the health of containers and automatically restarts them if they fail.
- It also performs resource management by enforcing resource limits and managing container networking.
- The Kubelet reports the node's status and resource utilization back to the control plane.
- It plays a crucial role in maintaining the desired state of the cluster by managing containers on individual nodes and collaborating with other Kubernetes components.


###  Kube proxy 

- Kube Proxy is a network proxy that runs on each node in a Kubernetes cluster.
- It enables communication between services within the cluster.
- Kube Proxy implements the Kubernetes Service concept, allowing services to be accessed by other pods and external clients.
- It maintains a set of network rules that enable network traffic forwarding to the appropriate pods based on service selectors.
- Kube Proxy can perform different network proxying modes, including userspace, iptables, and IPVS, depending on the cluster configuration.
- It handles load balancing across multiple pods belonging to a service and ensures high availability and fault tolerance.
- Kube Proxy monitors the Kubernetes API server for changes in service definitions and automatically updates its proxy rules accordingly.
- Kube Proxy plays a crucial role in enabling service discovery and load balancing within a Kubernetes cluster, facilitating seamless communication between pods and services.

###  Pods

- A Pod is the smallest and most basic unit in Kubernetes for deploying and running containers.
- It represents a single instance of a running process in a cluster.
- Pods are created and managed by the Kubernetes scheduler, which assigns them to specific nodes in the cluster.
- A Pod can contain one or more containers that share the same network namespace, IPC, and storage volumes.
- Containers within a Pod can communicate with each other using localhost, making it easy to build tightly coupled and co-located applications.
- Pods are ephemeral, which means they can be created, destroyed, or replaced by the Kubernetes control plane based on scaling needs, failures, or updates.
- Each Pod is assigned a unique IP address within the cluster, allowing other Pods and services to communicate with it.
- Pods can be configured with resource requests and limits to ensure fair allocation of resources and prevent resource starvation.
- Pods are typically created and managed using higher-level abstractions such as Deployments or StatefulSets, which provide additional features like scaling, rolling updates, and self-healing capabilities.

###  Replicasets 

- ReplicaSets are a Kubernetes resource used for managing and scaling replicated pods.
- They ensure a specified number of pod replicas are running at all times.
- ReplicaSets are often used in conjunction with Deployments, which provide declarative updates and rolling upgrades to ReplicaSets.
- ReplicaSets use labels and selectors to identify the pods they manage.
- They allow for scaling the number of replicas up or down based on resource demands or desired availability.
- When a ReplicaSet is created, it creates and maintains the desired number of pod replicas in the cluster.
- If a pod fails or is deleted, the ReplicaSet automatically replaces it to maintain the desired replica count.
- ReplicaSets also support rolling updates, allowing for controlled and gradual updates of pods to new versions.
- They provide fault tolerance and high availability by distributing replicas across multiple nodes in the cluster.
- ReplicaSets can be managed and monitored through the Kubernetes API and command-line tools.

<details><summary>show</summary>
<p>

```bash
kubectl get replicaset
kubectl create f replicaset definition.yml
kubectl get replicaset
kubectl delete replicaset myapp replicaset *Also deletes all underlying PODs
kubectl replace f replicaset definition.yml
kubectl scale replicas=6 f replicaset definition.yml
```

</p>
</details>

### Deployment

- Deployments are a Kubernetes resource that manages the deployment and scaling of applications.
- They provide a declarative way to define and manage the desired state of the application.
- Deployments work in conjunction with ReplicaSets to ensure the specified number of replicas are running and maintained.
- Deployments allow for controlled updates and rolling upgrades of the application.
- They support strategies like rolling updates, recreating pods, or canary deployments to minimize downtime during updates.
- Deployments provide features like scaling the number of replicas up or down to handle changes in demand or traffic.
- They monitor the health of pods and automatically replace or restart any pods that fail.
- Deployments can be easily rolled back to a previous version in case of issues or failures.
- They provide a high level of abstraction and enable application portability across different environments.
- Deployments can be managed and monitored through the Kubernetes API, command-line tools, or graphical interfaces like Kubernetes Dashboard.

<details><summary>show</summary>
<p>

```bash
kubectl create f deployment definition.yml
kubectl get deployments

kubectl get all

kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml
```

</p>
</details>

Useful link bookmark for exam as well
https://kubernetes.io/docs/reference/kubectl/conventions/

Basically use -o yaml to create yaml template instead of writing 
and use --dry-run=client to test if your cmd is going to run fine without running it 
e.g.


### Services
* Nodeport: target port:#, port:#, NodePort:# for outside world connectivity to the pod running container
* ClusterIP: Default service
* Loadbalancer: for frontend connecting to outside world. Uses native load balancing of cloud e.g. GCP, AWS, Azure, etc

<details><summary>show</summary>
<p>

```bash
k get svc
```
</p>
</details>

### Namespaces

Resource Quota, default DNS between different DNS, 3 namespaces by default (default, kube-system, kube-public)
  
<details><summary>show</summary>
<p>


```bash
k get pods -A
k get svc -n=marketing
kubectl config set-context $(kubectl config current-context) --namespace=prod
kubectl get pods --namespace=default
kubectl get pods --all-namespaces
```
</p>
</details>


### Imperative vs Declerative 
  Step by step (cmd's e.g. k edit/get/scale/create/run) vs config (yaml e.g. terraform, ansible, chef, k apply -f name.yml)

<details><summary>show</summary>
<p>

```bash
k run httpd --image=httpd:alpine --port=80 --expose

k create deployment redis-deploy --image=redis --replicas=2 --namespace=dev-ns

k run custom-nginx --image=nginx --port=8080

k create deployment --image=kodekloud/webapp-color --replicas=3 webapp

k create service clusterip redis-service --tcp=6379:6379 or k expose pod redis --port 6379 --name redis-service

k describe svc redis-service

k run --image=redis:alpine redis --labels=tier=db

k create ns dev-ns
```
</p>
</details>

### Kubectl apply
  It creates a live object config add some extra tags and also creates json format to keep track of the last modified config and compares the old and new to see what actions to perform on the file.
<details><summary>show</summary>
<p>


```bash
kubectl apply f deployment definition.yml
kubectl run nginx image= nginx


kubectl create f deployment definition.yml                                  (create)
kubectl get deployments                                                     (Get)
kubectl apply f deployment definition.yml                                   (Update)
kubectl set image deployment/ myapp deployment nginx =nginx:1.9.1           (Update)
kubectl rollout status deployment/ myapp deployment                         (Status)
kubectl rollout history deployment/ myapp deployment                        (Status)
kubectl rollout undo deployment/ myapp deployment                           (Rollback)
```
</p>
</details>

### Exam Tips
<details><summary>show</summary>
<p>
  
```bash
 Create Objects
kubectl apply f nginx.yaml
kubectl run image= nginx nginx
kubectl create deployment image= nginx nginx
kubectl expose deployment nginx port 80

  Update Objects
kubectl apply f nginx.yaml
kubectl edit deployment nginx
kubectl scale deployment nginx replicas=5
kubectl set image deployment nginx nginx =nginx:1.18
```
</p>
</details>

