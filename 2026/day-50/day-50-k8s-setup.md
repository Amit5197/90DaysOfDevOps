# Day 50 – Kubernetes Architecture and Cluster Setup

## Task 1: Recall the Kubernetes Story
Before touching a terminal, write down from memory:

1. Why was Kubernetes created? What problem does it solve that Docker alone cannot? 
   * For Auto Healing & Auto Scaling. Docker allows containers to run but it if a container crashes,
     it doesn't auto heal, if traffic increases it can not auto scale.
   * Docker runs containers, kubernetes manages containers.
   * Kubernetes provides: 
     - Auto Scaling
     - Auto Healing
     - Load balancing
     - Rolling updates
     - Cluster Management
2. Who created Kubernetes and what was it inspired by?
   * Google created BORG, whenever they wanted to scale or heal a crashed container, it was manual,
     so google created a tool that could auto-heal and auto-scale and managed millions of containers across thousands of servers..
   * In 2014, Google open-sourced a next-generation version of Borg’s concepts, which 
     became Kubernetes. Today, it is maintained by the Cloud Native Computing Foundation (CNCF).
3. What does the name "Kubernetes" mean?
   * Kubernetes name means **captain of a ship**.
   * Kubernetes reflects the idea of a captain managing a ship, ensuring containers are handled,
     directed, and kept on course.

Do not look anything up yet. Write what you remember from the session, then verify against the official docs.

---

## Task 2: Draw the Kubernetes Architecture
From memory, draw or describe the Kubernetes architecture. Your diagram should include:

**Control Plane (Master Node):**
- API Server — the front door to the cluster, every command goes through it
- etcd — the database that stores all cluster state
- Scheduler — decides which node a new pod should run on
- Controller Manager — watches the cluster and makes sure the desired state matches reality

**Worker Node:**
- kubelet — the agent on each node that talks to the API server and manages pods
- kube-proxy — handles networking rules so pods can communicate
- Container Runtime — the engine that actually runs containers (containerd, CRI-O)

   ![snapshot](images/architecture.jpeg)

After drawing, verify your understanding:
- What happens when you run `kubectl apply -f pod.yaml`? Trace the request through each component.
   * Kubectl reads your pod.yml. Validates and converts it into internal JSON representation.
   * kubectl sends a REST request to API server.
   * API server authenticates and validates.
   * Then it writes the new/updated object in the etcd.
   * The schedular watches API server for any newly created pod that has not been assigned yet
     and assigns pod to nodes.
   * The kubelet works with container runtime to pull necessary images, create and start the
     container.
- What happens if the API server goes down?
   * The existing pods and services continues to run but no new resources can be created, deleted
     or updated. 
   * Control plane components such as controller manager, schedular becomes inactive.
   * The self-healing ability is compromised.
   * Monitoring and logging failures.
- What happens if a worker node goes down?
   * The existing pods on the worker node will stop functioning.
   * Kubernetes waits for `pod-eviction-timeout` of 5mins(configurable) before taking action to 
     ensure node is truly down.
   * After timeout the control plane will mark the pods for deletion and evection and create
     identical replacement pods on another healthy node.

---

## Task 3: Install kubectl
`kubectl` is the CLI tool you will use to talk to your Kubernetes cluster.

Install it:
```bash
# macOS
brew install kubectl

# Linux (amd64)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Windows (with chocolatey)
choco install kubernetes-cli
```

Verify:
```bash
kubectl version --client
```

   ![snapshot](images/kubectl.png)

---

## Task 4: Set Up Your Local Cluster
Choose **one** of the following. Both give you a fully functional Kubernetes cluster on your machine.

**Option A: kind (Kubernetes in Docker)**
```bash
# Install kind
# macOS
brew install kind

# Linux
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create a cluster
kind create cluster --name devops-cluster

# Verify
kubectl cluster-info
kubectl get nodes
```

   ![snapshot](images/kind.png)

**Option B: minikube**
```bash
# Install minikube
# macOS
brew install minikube

# Linux
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start a cluster
minikube start

# Verify
kubectl cluster-info
kubectl get nodes
```

Write down: Which one did you choose and why?

---

## Task 5: Explore Your Cluster
Now that your cluster is running, explore it:

### See cluster info
kubectl cluster-info

   ![snapshot](images/5-a.png)

### List all nodes
> kubectl get nodes

   ![snapshot](images/5-b.png)

### Get detailed info about your node
> kubectl describe node <node-name>

   ![snapshot](images/5-c.png)

### List all namespaces
> kubectl get namespaces

   ![snapshot](images/5-d.png)

### See ALL pods running in the cluster (across all namespaces)
> kubectl get pods -A

   ![snapshot](images/5-e.png)

### Look at the pods running in the `kube-system` namespace:
> kubectl get pods -n kube-system

   ![snapshot](images/5-f.png)

You should see pods like `etcd`, `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `coredns`, and `kube-proxy`. These are the architecture components you drew in Task 2 — running as pods inside the cluster.

**Verify:** Can you match each running pod in `kube-system` to a component in your architecture diagram? **YES**

### What each kube-system pod does

* `core dns` : Provides DNS services so pods can communicate using service names.
* `etcd-devops-cluster-control-plane ` : Distributed key-value store that holds all cluster configuration and state.
* `kindnet-8mkrr`: Networking plugin used by KIND to enable pod networking.
* `kube-apiserver-devops-cluster-control-plane` : Main API server that handles all Kubernetes API requests.
* `kube-controller-manager-devops-cluster-control-plane` : Runs controllers that manage cluster state such as nodes, replicas, and endpoints.
* `kube-proxy-xk4lf` : Manages network rules and enables service networking for pods.
* `kube-scheduler-devops-cluster-control-plane ` : Assigns newly created pods to available nodes.

---

## Task 6: Practice Cluster Lifecycle
Build muscle memory with cluster operations:

### Delete your cluster
kind delete cluster --name devops-cluster

   ![snapshot](images/6-a.png)

### Recreate it
kind create cluster --name devops-cluster

   ![snapshot](images/6-b.png)

### Verify it is back
kubectl get nodes

   ![snapshot](images/6-c.png)

Try these useful commands:

### Check which cluster kubectl is connected to
kubectl config current-context

   ![snapshot](images/6-d.png)

### List all available contexts (clusters)
kubectl config get-contexts

   ![snapshot](images/6-e.png)

### See the full kubeconfig
kubectl config view

   ![snapshot](images/6-f.png)

Write down: What is a kubeconfig? Where is it stored on your machine?

   * kubeconfig is a configuration file used by Kubernetes clients kubectl to connect to a 
     Kubernetes cluster.
   * kind handles kubeconfig automatically.
   * It stores cluster details, user credentials, and contexts.
   * Location: ~/.kube/config

---

