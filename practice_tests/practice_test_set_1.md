# Practice/Challenge Test Set 1

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

----

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

----

# Internal IP of all nodes in cluster
k get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > filename.txt
cat filename.txt

----

# Multicontainer pod with a command 
# in multicontainer pod normally we share data like usign sidecar containers
k run pod-name --image=img-name --command sleep 100 --dry-run=client -o yaml > multipod.yaml
vim multipod.yaml
# under conatiners:
# - name: second-conatiner
#   image: new-image
k create -f multipod.yaml
k get pods -o wide

----

################################
# New user with acces on cluster in a specific namesapce
# always check the documentation if you're not sure
# you're allowed to use the official kubernetes documentation for the exam
# will need to create certificates for new user
# 1. create key (cmd)
# 2. create csr (yaml and apply)
# 3. approve csr (cmd)
# 4. create role (yaml and apply)
# 5. create rolebiinding (yaml and apply)
# 6. verify if as a new user you can perform the configured actions or not using auth (cmd)
openssl genrsa -out newuser_name.key 2048
openssl req key -new -key newuser_name.key -out newuser_name.csr
vim csr.yaml
# enter below yaml config got from official documentation 
# https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: newuser_name
spec:
  request: LS0t.....xxxx.....=
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth

cat newuser_name.csr | base64 | tr -d "\n"
# copy the output and replace withe the request value in the above yaml
k create -f csr.yaml
k get csr
# should show pending
k certificate approve newuser_name 
k get csr 
# should show approved 
# get the config for role binding from official doc
# https://kubernetes.io/docs/reference/access-authn-authz/rbac/
vim new-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: namesapce_name
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "create", "list", "update", "delete"]

# create role binding as per official doc
vim rolebinding-new.yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "newuser_name " to read pods in the "default" namespace.
# You need to already have a Role named "pod-reader" in that namespace.
kind: RoleBinding
metadata:
  name: read-pods
  namespace: namesapce_name
subjects:
# You can specify more than one "subject"
- kind: User
  name: newuser_name  # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io

k apply -f new-role.yaml
k get role -n namespace_name
k create -f rolebinding-new.yaml
k get rolebinding -n namespace_name
# verify
k auth can-i delete pods -n namesapce_name --as newuser_name

----

################################
# Create a service from the pod and running DNS lookup to check the service
k expose pod my-pod --name=my-pod-service-name --port=80 
k run nslookup --image=image-name:1.28 --command sleep 3600
k exec -it nslookup -- nslookup my-pod-service-name
k exec -it nslookup -- nslookup my-pod-service-name > text.txt
cat text.txt

----

# Creating and mounting a secret to the pod
# ConfigMaps are also used for securing text but secrets more secure way to keep a text secret
k create secert generic pod-secret-name --from-literal=password=pswd1234
# open the pod yaml file and mount the seceret under conatiner VolumeMounts: options:
VolumeMounts:
- mountPath: "/secret"
  name: pod-secret-name
# and under voluems as well
volumes:
- name: pod-secret-name
  secret:
    secretName: pod-secret-name

k describe pod my-pod



```

</p>
</details>
