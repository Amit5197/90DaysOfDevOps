# Day 53 – Kubernetes Services

## Task 1: Deploy the Application
First, create a Deployment that you will expose with Services. Create `app-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
```

```bash
kubectl apply -f app-deployment.yaml
kubectl get pods -o wide
```

Note the individual Pod IPs. These will change if pods restart — that is the problem Services fix.

**Verify:** Are all 3 pods running? Note down their IP addresses.

   ![snapshot](images/1-a.png)

---

## Task 2: ClusterIP Service (Internal Access)
ClusterIP is the default Service type. It gives your Pods a stable internal IP that is only reachable from within the cluster.

Create `clusterip-service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-clusterip
spec:
  type: ClusterIP
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
```

Key fields:
- `selector.app: web-app` — this Service routes traffic to all Pods with the label `app: web-app`
- `port: 80` — the port the Service listens on
- `targetPort: 80` — the port on the Pod to forward traffic to

```bash
kubectl apply -f clusterip-service.yaml
kubectl get services
```

   ![snapshot](images/2-a.png)

You should see `web-app-clusterip` with a CLUSTER-IP address. This IP is stable — it will not change even if Pods restart.

Now test it from inside the cluster:
```bash
# Run a temporary pod to test connectivity
kubectl run test-client --image=busybox:latest --rm -it --restart=Never -- sh

# Inside the test pod, run:
wget -qO- http://web-app-clusterip
exit
```

   ![snapshot](images/2-b.png)

You should see the Nginx welcome page. The Service load-balanced your request to one of the 3 Pods.

**Verify:** Does the Service respond? Try running the wget command multiple times — the Service distributes traffic across all healthy Pods.

---

## Task 3: Discover Services with DNS
Kubernetes has a built-in DNS server. Every Service gets a DNS entry automatically:

```
<service-name>.<namespace>.svc.cluster.local
```

Test this:
```bash
kubectl run dns-test --image=busybox:latest --rm -it --restart=Never -- sh

# Inside the pod:
# Short name (works within the same namespace)
wget -qO- http://web-app-clusterip

# Full DNS name
wget -qO- http://web-app-clusterip.default.svc.cluster.local

# Look up the DNS entry
nslookup web-app-clusterip
exit
```

   ![snapshot](images/3-a.png)

Both the short name and the full DNS name resolve to the same ClusterIP. In practice, you use the short name when communicating within the same namespace and the full name when reaching across namespaces.

**Verify:** What IP does `nslookup` return? Does it match the CLUSTER-IP from `kubectl get services`?
**YES**

---

## Task 4: NodePort Service (External Access via Node)
A NodePort Service exposes your application on a port on every node in the cluster. This lets you access the Service from outside the cluster.

Create `nodeport-service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-nodeport
spec:
  type: NodePort
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
```

- `nodePort: 30080` — the port opened on every node (must be in range 30000-32767)
- Traffic flow: `<NodeIP>:30080` -> Service -> Pod:80

```bash
kubectl apply -f nodeport-service.yaml
kubectl get services
```

   ![snapshot](images/4-a.png)

Access the service:
```bash
# If using Minikube
minikube service web-app-nodeport --url

# If using Kind, get the node IP first
kubectl get nodes -o wide
# Then curl <node-internal-ip>:30080

# If using Docker Desktop
curl http://localhost:30080
```

   ![snapshot](images/4-b.png)

   ![snapshot](images/4-c.png)

**Verify:** Can you see the Nginx welcome page from your browser or terminal using the NodePort?

---

## Task 5: LoadBalancer Service (Cloud External Access)
In a cloud environment (AWS, GCP, Azure), a LoadBalancer Service provisions a real external load balancer that routes traffic to your nodes.

Create `loadbalancer-service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-loadbalancer
spec:
  type: LoadBalancer
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
```

```bash
kubectl apply -f loadbalancer-service.yaml
kubectl get services
```

   ![snapshot](images/5-a.png)


If you are using Minikube:
```bash
# Minikube can simulate a LoadBalancer
minikube tunnel
# In another terminal, check again:
kubectl get services
```

In a real cloud cluster, the EXTERNAL-IP would be a public IP address or hostname provisioned by the cloud provider.

**Verify:** What does the EXTERNAL-IP column show? Why is it `<pending>` on a local cluster?

On a local cluster (Minikube, Kind, Docker Desktop), the EXTERNAL-IP will show `<pending>` because there is no cloud provider to create a real load balancer. This is expected.

---

## Task 6: Understand the Service Types Side by Side
Check all three services:

```bash
kubectl get services -o wide
```

   ![snapshot](images/6-b.png)

Each type builds on the previous one:
- LoadBalancer creates a NodePort, which creates a ClusterIP
- So a LoadBalancer service also has a ClusterIP and a NodePort

Verify this:
```bash
kubectl describe service web-app-loadbalancer
```

   ![snapshot](images/6-a.png)

You should see all three: a ClusterIP, a NodePort, and the LoadBalancer configuration.

**Verify:** Does the LoadBalancer service also have a ClusterIP and NodePort assigned?
**YES**

---

## Task 7: Clean Up
```bash
kubectl delete -f app-deployment.yaml
kubectl delete -f clusterip-service.yaml
kubectl delete -f nodeport-service.yaml
kubectl delete -f loadbalancer-service.yaml

kubectl get pods
kubectl get services
```

Only the built-in `kubernetes` service in the default namespace should remain.

**Verify:** Is everything cleaned up?

    ![snapshot](images/7.png)

---

### What problem Services solve and how they relate to Pods and Deployments
   * Every Pod gets its own IP address. But there are two problems:
     1. Pod IPs are **not stable** — when a Pod restarts or gets replaced, it gets a new IP
     2. A Deployment runs **multiple Pods** — which IP do you connect to?

   * A Service solves both problems. It provides:
     - A **stable IP and DNS name** that never changes
     - **Load balancing** across all Pods that match its selector
   * Relationship:
     - Deployment: Manages Pods (creates 3 replicas)
     - Pods: Run your application (nginx)
     - Service: Sits in front of Pods, Uses labels (selector) to find them.Routes traffic to them
     - Client → Service → Pods 

### Your three Service manifests with an explanation of each type
   * ClusterIP

    ![snapshot](images/clusterip.png)

     - Default service type.
     - Exposes pods inside cluster online.
     - Provides a stable internal IP + DNS name.
     - Used for internal communication between micro-services.

   * NodePrt IP

    ![snapshot](images/nodeport.png)

     - Exposes pods externally. Opens a port on evry node.
     - Provides access through <NodeIP>:<NodePort>  
     - Internally, traffic floes through cluster IP service.
     - Used for tesing/development.

   * LoadBalancer

    ![snapshot](images/loadbalancer.png)

     - Creates an external load balancer (in cloud environments).
     - Exposes pods externally with single IP.
     - Internally, k8s creates `cluster IP` & `NodePort IP` then the cloud loadbalancer routes   
       trrafic into them.
     - Used for production-grade external access.

### The difference between ClusterIP, NodePort, and LoadBalancer

| Type | Accessible From | Use Case | Backed By |
|------|-----------------|----------|-----------|
| ClusterIP | Inside the cluster only | Internal communication between services |ClusterIP |
| NodePort | Outside via `<NodeIP>:<NodePort>` | Development, testing, direct node access | ClusterIP + NodePort |
| LoadBalancer | Outside via cloud load balancer | Production traffic in cloud environments | ClusterIP + NodePort + Cloud LoadBalancer |

### How Kubernetes DNS works for service discovery
   * The core component:
     - **Core DNS**: The default cluster DNS server. It runs as a Deployment (in kube-system ns)
       and watches the k8s API for new services and endpoints.
     - **Kubelet**: On evry node, the kubelet configures each pod's `/etc/resolv.conf` file to 
       point to the coreDNS service IP.
     - **Service Obejct**: When you create a service k8s assigns a stable clusterIP and coreDNS
       immediately creates a DNS record for it.
   * The DNS naming convection
     - k8s uses a strict predictable hierarchy for DNS names. The full qualified DNS name :
         `service-name.namespace.svc.cluster.local`
   * How a Query is Resolved
     - A Pod makes a request using the Service DNS name:wget http://web-app-clusterip.
     - The request goes to CoreDNS for resolution.
     - CoreDNS resolves the Service name → ClusterIP. (Example: web-app-clusterip → ClusterIP)
     - Traffic is routed to the Service via ClusterIP.
     - The Service forwards the request to its Endpoints (Pods).
     - The Service selects Pods using labels (app: web-app)
     - Traffic is load-balanced across all healthy Pods
     - One of the Pods processes the request and returns a response (e.g., Nginx welcome page)

### What Endpoints are and how to inspect them
    - Endpoints connects a service to the actual running pods.
    - The endpoints maintains the dynamic list of IP addresses for the pods that match the service's
      selector.
   - Inspect them using:
      - `kubectl get endpoints`
      - `kubectl get endpoints <service-name> -o yaml`
      - `kubectl describe endpoints <service-name>`

---
