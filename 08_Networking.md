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

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### CNI

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>


### Deploy Network Solution

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Networking Weave

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>


### Service Networking 

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>


### Explore DNS

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>


### Ingress 1

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>


### Ingress 2

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

