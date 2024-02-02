
# Practice/Challenge Test Set 3

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash

# Deployment autoscale
k auto-scale deployment dep-name --min=3 --max=6 --cpu-percent=80

---

# No. of nodes in ready status
k descibe nodes | grep ready | wc -l > text.txt

---

# create pod with environment variable
k run env-demo-pod --image=nginx --env="DEMO_ENV_VAR=Hello, World!"
# verify 
k exec env-demo-pod -- printenv DEMO_ENV_VAR
k exec -it env-demo-pod -- sh -c 'echo $DEMO_ENV_VAR'

---

#



```

</p>
</details>
