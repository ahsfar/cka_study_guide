# Application Lifecycle Management

### Rolling Updates

Performing updates on deployments. Two deployment strategies:

1) Recreate: Kill all and update and bring up.
2) Rolling update (By default): kill 1 update 1 and continue. It creates new replicasets in case we want to roll back to older version we can do so.

<details><summary>show</summary>
<p>
  
```bash
kubectl rollout status deployment/ myapp deployment                       (Create)       
kubectl rollout history deployment/ myapp deployment                      (Get)  
kubectl create f deployment definition.yml                                (Update)
kubectl get deployments                                                 
kubectl apply f deployment definition.yml                                 (Status)
kubectl set image deployment/ myapp deployment nginx =nginx:1.9.1      
kubectl rollout undo deployment/ myapp deployment                         (Rollback)
```

</p>
</details>

### Test Commands

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Environment Variables

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Secrets

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Multi-container Pods

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>

### Innit Conatiners

tct

<details><summary>show</summary>
<p>
  
```bash
k logs webapp-1
```

</p>
</details>


