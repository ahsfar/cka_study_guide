# Practice/Challenge Test Set 2 

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Create a new service account, clusterrole and clusterrolebinding and pod 
k create serviceaccount newserviceaccount
k create clusterrole newclusterrole --resource=persistentvolume --verb=list
k create clusterrolebinding crbname --clusterrole=newclusterrole --serviceaccount=default:newserviceaccount
k run pod-name --image=img-name --dry-run=client -o yaml > pod.yaml
vim pod.yaml
# under spec:
#    serviceAccountName: newserviceaccount
k create -f pod.yaml
k describe pod pod-name
# verify serviceaccount exists

---

#


---

#


---

#



```

</p>
</details>
