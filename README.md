# cka_study_guide
documenting commands for cka cert prep journey

Course I'm follwoing is from Mumshad on Udemy it's the highest rated course for CKA.


Going through the first section for now

Content covered so far:

=> Kubernetes Architecture (Cluster Architecture)

=> Docker vs Container D

=> ETCD

=> Kube apiserver

=> Kube controller managet

=> kubelet

=> Kube proxy 
kubectl get pods -n kube-system
kubectl get daemonset -n kube-system

=> pods
kubectl get pods

=> replicasets 
kubectl get replicaset
kubectl create f replicaset definition.yml
kubectl get replicaset
kubectl delete replicaset myapp replicaset *Also deletes all underlying PODs
kubectl replace f replicaset definition.yml
kubectl scale replicas=6 f replicaset definition.yml


=> deployment
kubectl create f deployment definition.yml
kubectl get deployments


kubectl get all

Useful link bookmark for exam as well
https://kubernetes.io/docs/reference/kubectl/conventions/

Basically use -o yaml to create yaml template instead of writing 
and use --dry-run=client to test if your cmd is going to run fine without running it 
e.g.

kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml

=> Services
Nodeport: target port:#, port:#, NodePort:# for outside world connectivity to the pod running container
ClusterIP: Default service
Loadbalancer: for frontend connecting to outside world. Uses native load balancing of cloud e.g. GCP, AWS, Azure, etc

k get svc

=> Namespaces:
Resource Quota, default DNS between different DNS, 3 namespaces by default (default, kube-system, kube-public)
k get pods -A
k get svc -n=marketing
kubectl config set-context $(kubectl config current-context) --namespace=prod
kubectl get pods --namespace=default
kubectl get pods --all-namespaces

=> Imperative vs Declerative 

Step by step (cmd's e.g. k edit/get/scale/create/run) vs config (yaml e.g. terraform, ansible, chef, k apply -f name.yml)

k run httpd --image=httpd:alpine --port=80 --expose

k create deployment redis-deploy --image=redis --replicas=2 --namespace=dev-ns

k run custom-nginx --image=nginx --port=8080

k create deployment --image=kodekloud/webapp-color --replicas=3 webapp

k create service clusterip redis-service --tcp=6379:6379 or k expose pod redis --port 6379 --name redis-service

k describe svc redis-service

k run --image=redis:alpine redis --labels=tier=db

k create ns dev-ns

=> Kubectl apply
It creates a live object config add some extra tags and also creates json format to keep track of the last modified config and compares the old and new to see what actions to perform on the file.


kubectl apply f deployment definition.yml
kubectl run nginx image= nginx


kubectl create f deployment definition.yml                                  (create)
kubectl get deployments                                                     (Get)
kubectl apply f deployment definition.yml                                   (Update)
kubectl set image deployment/ myapp deployment nginx =nginx:1.9.1           (Update)
kubectl rollout status deployment/ myapp deployment                         (Status)
kubectl rollout history deployment/ myapp deployment                        (Status)
kubectl rollout undo deployment/ myapp deployment                           (Rollback)


Exam Tips
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
