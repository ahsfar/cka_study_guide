# Troubleshooting

### Application Failure

Info

<details><summary>show</summary>
<p>
  
```bash
k get pods
k describe pod -A
k edit pod -n <namespace.name>
k logs webapp-1

# Check Pod Status
kubectl get pods

# View Pod Logs
kubectl logs <pod-name>

# Check Pod Events
kubectl describe pod <pod-name>

# Check Deployment Status
kubectl get deployments

```

</p>
</details>


### Controlplane Failure

Info

<details><summary>show</summary>
<p>
  
```bash
# Check Control Plane Components
kubectl get componentstatuses

# Check kube-apiserver Logs
journalctl -u kube-apiserver -n 100

# Check etcd Cluster Health
ETCDCTL_API=3 etcdctl member list

# Check kube-controller-manager Logs
journalctl -u kube-controller-manager -n 100

```

</p>
</details>


### Worker node Failure

Info

<details><summary>show</summary>
<p>
  
```bash
# Check Node Status
kubectl get nodes

# Describe Node
kubectl describe node <node-name>

# Check Node Logs
journalctl -u kubelet -n 100

# Check Container Runtime Logs (e.g., Docker)
journalctl -u docker -n 100

```

</p>
</details>

### Network Troubleshooting

Info

<details><summary>show</summary>
<p>
  
```bash
# Check Network Policies
kubectl get networkpolicies --all-namespaces

# Check Pod Network Configuration
kubectl get pods -o wide
kubectl describe pod <pod-name>

# Check Cluster Network Configuration
kubectl cluster-info

# Use `traceroute` and `ping` within Pods
kubectl exec -it <pod-name> -- traceroute <destination>
kubectl exec -it <pod-name> -- ping <destination>

```

</p>
</details>
