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

=> pods

=> replicasets

=> deployment

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
