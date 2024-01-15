# Networking

Prerequistice topics: Switching & Routing, DNS, Network namespaces, Docker Networking, CNI, Cluster Networking.

#### Basic commands:
<details><summary>show</summary>
<p>
  
```bash

ip link
ip addr
ip addr add 192.168.1.10/24 dev eth0
ip route
ip route add 192.168.1.0/24 via 192.168.2.1
route
cat /proc/sys/net/ipv4/ip_forward

cat >> /etc/hosts
cat >> /etc/hosts
cat /etc/resolv.conf
cat /etc/nsswitch.conf

nslookup www.google.com
dig www.google.com

ps aux


# Create network namespaces
ip netns add red
ip netns add blue

ip netns

# Create veth pairs
ip link add veth-red type veth peer name veth blue

# Create Add veth to respective namespaces
ip link set veth-red netns red
ip link set veth-blue netns blue

# Set IP Addresses
ip -n red addr add 192.168.1.1 dev veth-red
ip -n blue addr add 192.168.1.2 dev veth-blue

# Check IP Addresses
ip -n red addr
ip -n blue addr

# Bring up interfaces
ip -n red link set veth-red up
ip -n blue link set veth-blue up

# Bring Loopback devices up
ip -n red link set lo up
ip -n blue link set lo up

# Add default gateway
ip netns exec red ip route add default via 192.168.1.1 dev veth-red
ip netns exec blue ip route add default via 192.168.1.2 dev veth-blue

ip netns del red
ip netns del blue
ip link del v-net-0
iptables -t nat -D POSTROUTING 1

ip netns add red
ip netns add blue

ip link add veth-red type veth peer name veth-red-br
ip link add veth-blue type veth peer name veth-blue-br

ip link set veth-red netns red
ip link set veth-blue netns blue

ip -n red addr add 192.168.15.2/24 dev veth-red

ip -n blue addr add 192.168.15.3/24 dev veth-blue

brctl addbr v-net-0

ip link set dev v-net-0 up

ip link set veth-red-br up
ip link set veth-blue-br up

```

</p>
</details>

### Kubernetes Env

Explore the kubernetes environment to get the networking details.  

<details><summary>show</summary>
<p>
  
```bash
k get nodes
k describe node controlplane  | grep -i internal

ip a / ip link
ssh node01
ip link show eth0

netstat -nplt

netstat -anp | grep etcd
netstat -anp | grep etcd | grep 2379 | wc -l

```

</p>
</details>

### CNI

Container Networking Interface is a networking standard. It helps you deploy an agent on each node where it keeps all the networking info of the pods in the nodes and all the nodes in the cluster. 

<details><summary>show</summary>
<p>
  
```bash
ps -aux | grep kubelet | grep --color container-runtime-endpoint

/opt/cni/bin  # available CNI pluggins

cat /etc/cni/net.d/10-flannel.conflist | grep type

```

</p>
</details>


### Deploy Network Solution

Check documentaion for deploying a CNI plugin. 

<details><summary>show</summary>
<p>
  
```bash
k apply -f file_name.yaml
```

</p>
</details>

### Networking Weave

Weave installs agent on all the nodes for networking in a cluster in kubernetes.

<details><summary>show</summary>
<p>
  
```bash
kubectl get pods -n kube-system

kubectl get po -o wide -n kube-system | grep weave

ip addr show weave

ssh node01
ip route
```

</p>
</details>


### Service Networking 

Services are cluster wide. 

<details><summary>show</summary>
<p>
  
```bash
ip a | grep eth0

apt install ipcalc

ipcalc -b <ip_addr>

k logs weave-net-fgxvr weave -n kube-system | grep ipalloc-range

cat /etc/kubernetes/manifests/kube-apiserver.yaml   | grep cluster-ip-range

k get pods -n kube-system

k logs kube-proxy-4t62z -n kube-system

```

</p>
</details>


### Explore DNS in Kubernetes

Kube DNS is auto created on a cluster and it maps hostnames with their ips. So, you can just reach that host by their hostname if in the same namespace.

For across namespace you can mention hostname.namespace for reaching the host in that namespace.

hostname.namespace.type.root

web-service.apps.svc.cluster.local
hostname.default.pod.cluster.local



<details><summary>show</summary>
<p>
  
```bash
kubectl get pods -n kube-system

kubectl get cm -n kube-system

kubectl get svc

kubectl exec -it hr -- nslookup mysql.payroll > /root/CKA/nslookup.out

```

</p>
</details>


### Ingress

 #### Ingress Basics:

- Ingress defines external access to services within a cluster.
- It allows you to route external HTTP/S traffic to internal services.

#### Creating Ingress:

- Use kubectl create ingress to create an Ingress resource.
- Specify backend services and rules in the Ingress definition.

#### Host-Based Routing:

- Achieve host-based routing with the host field in rules.
- Example: host: example.com.

#### Path-Based Routing:

- Use the path field in rules for path-based routing.
- Example: path: /app.

#### TLS Termination:

- Secure traffic with TLS by specifying secrets in the Ingress.
- Define TLS hosts and paths for encryption.

#### Annotations:

- Customize Ingress behavior using annotations.
- Example: nginx.ingress.kubernetes.io/rewrite-target: /.

#### Default Backend:

- Define a default backend for requests that don’t match defined rules.
- Ensures unmatched traffic has a destination.

#### Namespace Isolation:

- Ingress can be namespace-isolated for better organization.
- Specify the namespace in the Ingress definition.

#### Testing Ingress:

- Validate Ingress settings with kubectl describe ingress.
- Use tools like curl to test external access.

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>


