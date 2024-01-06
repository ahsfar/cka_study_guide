# Security 

Authentication: Who can access?
Authorization: What can they do?

TLS Certificates for secure communication in cluster.

Auth:
- Users
- Service Accounts

Mechanism: Static Password File, Static Token File, Certificates, LDAP

Symmetric vs Asymmetric encryption
CA - Certificate Authority 
PKI - Public Key Infrastructure
TLS Cert: 
-> Root cert: CA 
-> cliet cert: Admin, scheduler, controller-manager 
-> server cert: kube-apiserver, etcd-server

### View Certification Details

View cert to do healthcheck.

<details><summary>show</summary>
<p>
  
```bash
cat /etc/kubernetes/manifests/kube-apiserver.yaml
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

kubectl logs etcd-master
docker ps -a
docker logs 87fc

cat /etc/kubernetes/manifests/etcd.yaml
ls -l /etc/kubernetes/pki/etcd/server* | grep .crt
vim /etc/kubernetes/manifests/etcd.yaml

crictl ps -a | grep kube-apiserver
crictl logs --tail=2 a11b49d7257ab
```

</p>
</details>

### Certificates API

Controller manager helps approving and signing csr for creating new users.

These can be viewed and approved by admin.

<details><summary>show</summary>
<p>
  
```bash
cat akshay.csr | base64 -w 0

---
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: akshay
spec:
  groups:
  - system:authenticated
  request: <Paste the base64 encoded value of the CSR file>
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth

kubectl apply -f akshay-csr.yaml
k get csr
k certificate approve akshay
kubectl get csr agent-smith -o yaml
k certificate deny agent-smith
k delete csr agent-smith
```

</p>
</details>

### KubeConfig

It's yaml file stored at &HOME/.kube/config which is used to keep cert files with cluster, context and users. So, you don't have to provide certs with commands.

<details><summary>show</summary>
<p>
  
```bash
kubectl config --kubeconfig=/root/my-kube-config current-context
kubectl config --kubeconfig=/root/my-kube-config use-context research

cd /etc/kubernetes/pki/users
k config view
vim $HOME/.kube/config
```

</p>
</details>

### Role Based Access Control

Before we talk about RBAC we need to talk about:

#### API Groups:
-> named /apis -> API Group (/storage, /networking, /certificates, etc) -> resources (/deplayments, etc ) -> verb (list, get, update, etc)

#### Authorization:
Node: system node internal communication approved by node authorizor.
ABAC: Attribute based for different users creating policies file and if update needed need to restart api server. (Difficult to manage)
RBAC: role based -> create roles and define in it all the permissions and then assign groups and users to it.
Webhook: outsource to 3rd party tools
AlwaysAllow: no auth (By Default this)
AlwaysDeny: no auth

<details><summary>Check Access</summary>
<p>
  
```bash
kubectl get roles
kubectl get rolebindings
kubectl describe role developer
kubectl describe rolebinding devuser-developer-binding

kubectl auth can-i create deployments
kubectl auth can-i delete nodes
kubectl auth can-i create deployments --as dev-user
kubectl auth can-i create pods --as dev-user
kubectl auth can-i create pods --as dev-user --namespace test
```

</p>
</details>


<details><summary>Manifest files</summary>
<p>
  
```bash
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
name: developer
rules:
- apiGroups: [""]
resources: ["pods"]
verbs: ["list“, "get", “create“, “update“, “delete"]
developer-role.yaml
- apiGroups: [""]
resources: [“ConfigMap"]
verbs: [“create“]

kubectl create -f developer-role.yaml

apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
name: devuser-developer-binding
subjects:
- kind: User
name: dev-user
apiGroup: rbac.authorization.k8s.io
roleRef:
kind: Role
name: developer
apiGroup: rbac.authorization.k8s.io

kubectl create -f devuser-developer-binding.yaml
```

</p>
</details>

<details><summary>show</summary>
<p>
  
```bash
cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep authorization
k get roles -A
k describe role kube-proxy -n kube-system
kubectl describe rolebinding kube-proxy -n kube-system
k get pods --as dev-user

kubectl create role developer --namespace=default --verb=list,create,delete --resource=pods
kubectl create rolebinding dev-user-binding --namespace=default --role=developer --user=dev-user

kubectl edit role developer -n blue
```

</p>
</details>

### Cluster Roles

namespaced scope: deployments, pods, role, rolebinding etc 
cluster scope: certificate_signing_request, namesapce, node, PV etc

For authorizing cluster scope resources we need cluster roles.


<details><summary>show</summary>
<p>
  
```bash
kubectl api-resources --namespaced=true
kubectl api-resources --namespaced=false

k get ClusterRoles | wc -l
k describe ClusterRole cluster-admin
k describe ClusterRoleBinding cluster-admin

k create clusterrole node-admin --verb=get,watch,list,create,delete --resource=nodes
kubectl create clusterrolebinding michelle-binding --user=michelle --clusterrole=node-admin

kubectl get clusterrolebinding michelle-binding -o yaml

k create clusterrole storage-admin --resource=persistentvolumes,storageclasses --verb=get,watch,list,create,delete
k create clusterrolebinding michelle-storage-admin --user=michelle --clusterrole=storage-admin
kubectl auth can-i list storageclasses --as michelle
```

</p>
</details>

### Service Accounts

3rd party applications/bots

Create token and then secret
Mention the serviceaccounts in the pod-definition.yaml

<details><summary>show</summary>
<p>
  
```bash

kubectl set serviceaccount deploy/web-dashboard dashboard-sa
```

</p>
</details>

### Image Security

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Security Contexts

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Network Poicies

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

