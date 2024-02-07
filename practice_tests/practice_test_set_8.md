
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

k rollout history deployment/my-web-app

k rollout history deployment/my-web-app --revision=2

k rollout undo deployment/my-web-app --to-revision=1

k get deployment my-web-app
k describe deployment my-web-app

---

# Pod info using custom columns

k get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase

k get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,REASON:.status.containerStatuses[0].state.waiting.reason



---

#


---

#



```

</p>
</details>
