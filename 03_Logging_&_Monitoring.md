# Logging & Monitoring

### Monitor Cluster Components

Download and monitor in-memory nodes and pods metrics via metrics server. 

<details><summary>show</summary>
<p>


```bash
git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git
ls
cd kubernetes-metrics-server
ls
k create -f .
k top node
kubectl top node --sort-by='cpu' --no-headers | head -1
kubectl top node --sort-by='memory' --no-headers | head -1
kubectl top pod --sort-by='memory' --no-headers | head -1
kubectl top pod --sort-by='cpu' --no-headers | tail -1



```

</p>
</details>

### Managing Application Logs

Can view the logs of pods and container like docker.

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>
