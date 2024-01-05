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

tct

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

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Cluster Roles

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Service Accounts

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
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

### 01

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>
