
# Practice/Challenge Test D


## Practice the following commands and Q's .


### Taint and Tolerants

Pod name: web-pod
Image: httpd
Node: node01


```bash
K run —image=httpd —dry-run=client -o yaml > pod.yaml

K get nodes node01 -o jsonpath=‘{.spec.taints}’
```

Under spec:

tolerations:
- key: key1
  Operator: exists
  Effect: noSchedule

###  Event logs & crictl

Find pod
Get cont-name container id and save in a file
Get cont-name container logs and save in a file
Restart container and write cluster events to a file


```bash
K get pods
K edit pod pod-name
K logs pod-name -c cont-name
K get pod -o wide
```

Get which node pod is running on and ssh into that node


```bash
Crictl ps
Crictl stop conatiner_id
Crictl rm container_id
# cluster logs
K get events —sort-by=.metadata.creationTimestamp
# pod logs
K get events —field-selector involvedObject.name=pod-name
```

### HPA 1

Find deployment frontend in production ns scale down replicas : 2 and change img


```bash
K get deployments -n production
K scale deployment frontend —replicas=2 -n production

K set image deployment frontend nginx=nginx1.25 -n production
```

### HPA 2

Autosclae deployment
Min: 3
Max 5
Cpu: 80%


```bash
K autoscale deployment frontend -n production —min=3 —max=5 —cpu-percent=80 
```

### nodeport svc

Expose deployment frontend -n production 
Nodeport and nodeportsvc 

```bash

K expose deployment frontend -n production —name=nodeportsvc port=80 —type=NodePort


```

### => ConfigMap

a) Create configmap name truewide with content tree=iswide
b) Create configmap from the file /vm/cm.yaml


```bash
K create configmap —from-literal=tree=iswide
K get cm
Cat /vm/cm.yaml
K apply -f /vm/cm.yaml 
K get cm
```




C)  pod = pod1 image=nginx:alpine  
D) tree as env variable TREE1
E) mount all brike keys /etc/brike
F) test tree and brike mount


```bash
apiVersion: v1
kind: Pod 
metadata:
	labels:
	  run: pod1 
	name: pod1
spec:
	volumes:
	  - name: birke 
		configMap:
		  name: birke 
	containers:
	- image: nginx:alpine
	name: pod1
	 env:
	 - name: TREE1 	
        valueFrom:		
            configMapKeyRef:
				name: trauerweide # The ConfigMap this value comes from. 
				key: tree
	volumeMounts:
		- name: birke		   mountPath: "/etc/birke"
```