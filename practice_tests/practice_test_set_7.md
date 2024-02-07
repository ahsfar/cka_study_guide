
# Practice/Challenge Test Set 7

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# 

---

#


---

#


---

# Create a pod with labels
k run <pod_name> --image=redis:alpine -l tier=redis
k describe pod <pod_name>

---

# Create pod in namespace
k create namesapce <namepsace_name>
k run <pod_name> --image=<img_name>:alpine -n <ns_name>

---

# Create pod and expose port
k run my-pod --image=nginx
k expose pod my-pod --name=my-service --port=8080 --target-port=8080



```

</p>
</details>
