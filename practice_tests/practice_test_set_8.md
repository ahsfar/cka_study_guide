
# Practice/Challenge Test Set 8

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Update image imperative way 
k get deployment -o wide
k set image deployment <image_name>=<image_name>:1.1.19

---


# Deployment rollback

kubectl rollout history deployment/my-web-app

kubectl rollout history deployment/my-web-app --revision=2

kubectl rollout undo deployment/my-web-app --to-revision=1

kubectl get deployment my-web-app
kubectl describe deployment my-web-app

---

# Pod info using custom columns

kubectl get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase

kubectl get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,REASON:.status.containerStatuses[0].state.waiting.reason



---

#


---

#



```

</p>
</details>
