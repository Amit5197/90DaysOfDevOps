# Day 52 – Kubernetes Namespaces and Deployments

## Task 1: Explore Default Namespaces
Kubernetes comes with built-in namespaces. List them:

```bash
kubectl get namespaces
```

You should see at least:
- `default` — where your resources go if you do not specify a namespace
- `kube-system` — Kubernetes internal components (API server, scheduler, etc.)
- `kube-public` — publicly readable resources
- `kube-node-lease` — node heartbeat tracking

Check what is running inside `kube-system`:
```bash
kubectl get pods -n kube-system
```

These are the control plane components keeping your cluster alive. Do not touch them.

**Verify:** How many pods are running in `kube-system`?
* 12 Pods are running

   ![snapshot](images/kube-system.png)

---

## Task 2: Create and Use Custom Namespaces
Create two namespaces — one for a development environment and one for staging:

```bash
kubectl create namespace dev
kubectl create namespace staging
```

Verify they exist:
```bash
kubectl get namespaces
```

You can also create a namespace from a manifest:
```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

```bash
kubectl apply -f namespace.yaml
```

   ![snapshot](images/2-a.png)

Now run a pod in a specific namespace:
```bash
kubectl run nginx-dev --image=nginx:latest -n dev
kubectl run nginx-staging --image=nginx:latest -n staging
```

List pods across all namespaces:
```bash
kubectl get pods -A
```

Notice that `kubectl get pods` without `-n` only shows the `default` namespace. You must specify `-n <namespace>` or use `-A` to see everything.

**Verify:** Does `kubectl get pods` show these pods? What about `kubectl get pods -A`?

   ![snapshot](images/2-a.png)

---

## Task 3: Create Your First Deployment
A Deployment tells Kubernetes: "I want X replicas of this Pod running at all times." If a Pod crashes, the Deployment controller recreates it automatically.

Create a file ` `:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: dev
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.24
        ports:
        - containerPort: 80
```

Key differences from a standalone Pod:
- `kind: Deployment` instead of `kind: Pod`
- `apiVersion: apps/v1` instead of `v1`
- `replicas: 3` tells Kubernetes to maintain 3 identical pods
- `selector.matchLabels` connects the Deployment to its Pods
- `template` is the Pod template — the Deployment creates Pods using this blueprint

Apply it:
```bash
kubectl apply -f nginx-deployment.yaml
```

Check the result:
```bash
kubectl get deployments -n dev
kubectl get pods -n dev
```

   ![snapshot](images/3.png)

You should see 3 pods with names like `nginx-deployment-xxxxx-yyyyy`.

**Verify:** What do the READY, UP-TO-DATE, and AVAILABLE columns mean in the deployment output?

>READY - Pods healthy and serving traffic now.
>UP-TO-DATE - Pods running the latest deployment spec.
>AVAILABLE - Pods stable and available for end users.

---

## Task 4: Self-Healing — Delete a Pod and Watch It Come Back
This is the key difference between a Deployment and a standalone Pod.

```bash
# List pods
kubectl get pods -n dev

# Delete one of the deployment's pods (use an actual pod name from your output)
kubectl delete pod <pod-name> -n dev

# Immediately check again
kubectl get pods -n dev
```

The Deployment controller detects that only 2 of 3 desired replicas exist and immediately creates a new one. The deleted pod is replaced within seconds.

   ![snapshot](images/4.png)

**Verify:** Is the replacement pod's name the same as the one you deleted, or different?
* Replacement pod's name is different.
---

## Task 5: Scale the Deployment
Change the number of replicas:

```bash
# Scale up to 5
kubectl scale deployment nginx-deployment --replicas=5 -n dev
kubectl get pods -n dev

# Scale down to 2
kubectl scale deployment nginx-deployment --replicas=2 -n dev
kubectl get pods -n dev
```
   * Scale to 5 replicas

   ![snapshot](images/5-a.png)

   * Scale down to 2 replicas

   ![snapshot](images/5-b.png)   

Watch how Kubernetes creates or terminates pods to match the desired count.

You can also scale by editing the manifest — change `replicas: 4` in your YAML file and run `kubectl apply -f nginx-deployment.yaml` again.

**Verify:** When you scaled down from 5 to 2, what happened to the extra pods?
* Extra pods are terminated, kubernetes only keeps desired number of replicas it deletes
  or creates pods to match desired state.

---

## Task 6: Rolling Update
Update the Nginx image version to trigger a rolling update:

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev
```

Watch the rollout in real time:
```bash
kubectl rollout status deployment/nginx-deployment -n dev
```

Kubernetes replaces pods one by one — old pods are terminated only after new ones are healthy. This means zero downtime.

Check the rollout history:
```bash
kubectl rollout history deployment/nginx-deployment -n dev
```

   ![snapshot](images/6-a.png)   

Now roll back to the previous version:
```bash
kubectl rollout undo deployment/nginx-deployment -n dev
kubectl rollout status deployment/nginx-deployment -n dev
```

Verify the image is back to the previous version:
```bash
kubectl describe deployment nginx-deployment -n dev | grep Image
```

**Verify:** What image version is running after the rollback?

   ![snapshot](images/6-b.png)   

---

## Task 7: Clean Up
```bash
kubectl delete deployment nginx-deployment -n dev
kubectl delete pod nginx-dev -n dev
kubectl delete pod nginx-staging -n staging
kubectl delete namespace dev staging production
```

Deleting a namespace removes everything inside it. Be very careful with this in production.

```bash
kubectl get namespaces
kubectl get pods -A
```

**Verify:** Are all your resources gone? **YES**

   ![snapshot](images/7.png)   

---

- What namespaces are and why you would use them
   * Namespaces are used to organize and isolate deployemnts/pods.

- Your Deployment manifest and an explanation of each section
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: dev
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.24
        ports:
        - containerPort: 80
```
    * `apiVersion`: `apps/v1`
    * `kind`: `deployment`
    * `metadata` - contains (name, namespace, labels)
    * `spec` - deployments specifications
    * `repicas` - how many replicas to create 
    * `selector` - matches pods with label `app: nginx`
    * `template.metadata` - contains pods labels, must match the selector (app: nginx)
    * `template.spec` - pods specification (containers,name,image,port)

- What happens when you delete a Pod managed by a Deployment vs a standalone Pod
   * A standalone pod is gone forever. A managed pod is created again to match desired state.

- How scaling works (both imperative and declarative)
   * `imperative` : You directly tell Kubernetes how many replicas you want using a command.
   * `declarative` : You update the Deployment manifest (YAML) with the desired replicas.

- How rolling updates and rollbacks work

   * **Rolling updates** (Gradual replacement of Pods with new spec)
      - When you change something (eg. iamge) k8s doesn't replace all pods at once.
      - A new replica set is created with updated pod template.
      - Old pods are deleted one by one.
      - Ensures `0 downtime` by keeping some pods available while new ones become available.

   * **Rollbacks** (Revert to a previous Deployment revision if the update fails)
      - If something goes wrong in a rollout you can revert to previous or a specific 
        version.
      - K8s keeps a history of replicasets for each deployemnt.
      - Quick recovery from failed updates without manual redeployment.

---
