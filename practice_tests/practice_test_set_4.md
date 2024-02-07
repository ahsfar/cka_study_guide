
# Practice/Challenge Test Set 4

### Practice the following commands.

<details><summary>show</summary>
<p>
  
```bash


# Troubleshooting pod unable to schedule on node
k get pod pod-name -o wide
k describe pod pod-name
k get pod pod-name -o yaml > newpod.yaml
vim newpod.yaml
# fix the mistakes yaml 
k replace --force -f newpod.yaml
k describe pod pod-name | grep Labels

---

# Network policy to allow traffic from a pod to other pods

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: policy-name
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: allow-outbound
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels: 
          name: department1
    ports:
    - protocol: TCP
      port: 80
  - to:
    - podSelector:
        matchLabels: 
          name: department2
    ports:
    - protocol: TCP
      port: 8080

---

# Set SYS_TIME for pod

apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-4
spec:
  containers:
  - name: sec-ctx-4
    image: gcr.io/google-samples/node-hello:1.0
    command: [ "sh", "-c", "sleep 1h" ]
    securityContext:
      capabilities:
        add: ["SYS_TIME"]

---

# Create clusterrole and clusterrolebindings

k create clusterrole pod-reader --verb=get,list,watch --resource=pods
k create clusterrolebinding pod-reader-binding --clusterrole=pod-reader --serviceaccount=default:default
# Verify
k auth can-i <verb> <resource> [--namespace <namespace>] [--as <username|serviceaccount>]

k auth can-i create pods
k auth can-i list deployments --namespace my-namespace --as system:serviceaccount:my-namespace:my-service-account
k auth can-i delete nodes --as system:serviceaccount:default:default

# real world example 
k create serviceaccount monitoring-sa --namespace monitoring
k create clusterrolebinding monitoring-pod-reader-binding --clusterrole=pod-reader --serviceaccount=monitoring:monitoring-sa
# verify
k auth can-i list pods --all-namespaces --as system:serviceaccount:monitoring:monitoring-sa


---


# IP of pod

# below command will get the all the ip's of all the pods matching label 
kubectl get pods -l app=payment --namespace=finance -o jsonpath='{range .items[*]}{.status.podIP}{"\n"}{end}'

# below command will get the first ip of the pod
kubectl get pods -l app=webserver -o jsonpath='{.items[0].status.podIP}' --namespace=default


---

# Statefulset container mountpath update
StatefulSets are ideal for applications that require one or more of the following:
Stable, unique network identifiers.
Stable, persistent storage.
Ordered, graceful deployment and scaling.
Ordered, automated rolling updates.

kubectl edit statefulset my-mongodb-statefulset -n my-namespace

# before
volumeMounts:
- name: mongodb-data
  mountPath: /data/db
# after changing
volumeMounts:
- name: mongodb-data
  mountPath: /var/lib/mongodb

# verify

kubectl rollout status statefulset my-mongodb-statefulset -n my-namespace

kubectl exec -it my-mongodb-statefulset-0 -n my-namespace -- df -h


---


# cronjob for backups and report generation
# Example: Database Backup CronJob
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: database-backup
spec:
  schedule: "0 1 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: db-backup
            image: mydbbackup:latest
            env:
            - name: DB_HOST
              value: "mydatabase.host"
            - name: DB_USER
              value: "backupuser"
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: db-user-pass
                  key: password
            command: ["/bin/sh", "-c", "/path/to/backup/script.sh"]
          restartPolicy: OnFailure

k apply -f db-backup-cronjob.yaml
k get cronjobs
k describe cronjob database-backup
k get jobs

---

# pods name and namespace using jsonpath
k get pods -A -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.namespace}{"\n"}{end}'

```

</p>
</details>
