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

