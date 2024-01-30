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

# Create a network policy to allow communication on a single port for all pods in a specific namespace
k create namesapce ns-name label app=website 
vim network-policy.yaml
# enter below yaml configuration
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy 
metadata:
    name: net-policy 
    namespace: website
spec:
    podSelector: (} 
    policyTypes:
    - Ingress 
    ingress:
    - from:
        - namespaceSelector: 
            matchLabels:
                app: website
        ports:
        - protocol: TCP
            port: 80

k create -f network-policy.yaml
k describe networkpolicy net-policy

---

# Internal IP of all nodes in cluster
k get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > filename.txt
cat filename.txt

---

#


---

#


---

#


---

#


---

#


---

#


---

#



```

</p>
</details>
