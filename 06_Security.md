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
```

</p>
</details>

### Certificates API

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### KubeConfig

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
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
