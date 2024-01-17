# Practice Test Set 1 

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash
# update image imperativce way 
k get deployment -o wide
k set image deployment <image_name>=<image_name>:1.1.19

#update the static pod path (static pod is pod which creates itself after deletion)
ps -aux | grep kubelet
# look for --config=/var/lib/kubelet/config.yaml
=> vim above_file.yaml
=> change staticPodPath: etc/kubernetes/manifest




```

</p>
</details>
