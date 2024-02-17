
# Practice/Challenge Test E


## Practice the following commands and Q's .


### 
```bash

```

### 
```bash

```

### 
```bash

```

### 
```bash

```

### 
```bash

=> Create a ConfigMap named "my-configmap" with the following key-value pairs:
Key: app_name, Value: my-app
Key: app_version, Value: 1.2.3
Key: max_connections, Value: 100

k create configmap my-configmap --from-literal=app_name=my-app --from-literal=app_version=1.2.3 --from-literal=max_connections=100

=> Create a PersistentVolumeClaim (PVC) named "my-pvc" with a request for 5Gi of storage.
k create pvc my-pvc --resources=requests.storage=5Gi

=> Create a DaemonSet named "my-daemonset" that runs a Pod on each node in the cluster, using the image "my-image:latest".
k create daemonset my-daemonset --image=my-image:latest

=> Create a Deployment named "my-deployment" with the following specifications:
Replicas: 3
Image: nginx:1.19
Environment Variables:
Name: APP_ENV, Value: production
Volume:
Name: data-volume
Mount Path: /data
Host Path: /opt/data

k create deployment my-deployment --image=nginx:1.19 --replicas=3 --env=APP_ENV=production --dry-run=client -o yaml > my_dep.yaml
# then mount the volume under spec section:
volumes:
  - name: data-volume
    hostPath:
      path: /opt/data

=> Create a Job named "my-job" that runs a Pod which executes the command "echo 'Hello, World!'" and then terminates.
k create job my-job --image=ubuntu -- echo 'Hello, World!'


=> Create a ServiceAccount named "my-serviceaccount" with the necessary permissions to list and create Pods in the "default" namespace.
k create serviceaccount my-serviceaccount --verb=list,create  --resource=pod
k create serviceaccount my-serviceaccount -n default

=> Create a NetworkPolicy named "my-networkpolicy" that allows incoming traffic only from Pods with the label "app=backend" and blocks all other traffic.
k create networkpolicy my-networkpolicy --pod-selector=app=backend --ingress
k create networkpolicy my-networkpolicy --pod-selector=app=backend --policy-type=Ingress --dry-run=client -o yaml > my_networkpolicy.yaml
# Then modify my_networkpolicy.yaml to include the desired ingress rules.

=> Create a Role named "my-role" with permissions to list and delete Pods in the "kube-system" namespace.
k create role my-role --verb=list,delete --resource=pods -n kube-system

=> Create a RoleBinding named "my-rolebinding" that binds the Role "my-role" to the ServiceAccount "my-serviceaccount" in the "kube-system" namespace.
k create rolebinding my-rolebinding --role=my-role --serviceaccount=kube-system:my-serviceaccount -n kube-system

=> Create a CronJob named "my-cronjob" that runs every Monday at 9:00 AM and executes a script named "backup.sh".
k create cronjob my-cronjob --schedule="0 9 * * 1" --image=my-image -- /bin/sh -c "backup.sh"


```