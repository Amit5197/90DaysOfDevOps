# Day 50 – Kubernetes Architecture and Cluster Setup

## Task
You have been building and shipping containers with Docker. But what happens when you need to run hundreds of containers across multiple servers? You need an orchestrator. Today you start your Kubernetes journey — understand the architecture, set up a local cluster, and run your first `kubectl` commands.

This is where things get real.

---

## Challenge Tasks

### Task 1: Recall the Kubernetes Story
Before touching a terminal, write down from memory:

1. Why was Kubernetes created? What problem does it solve that Docker alone cannot?
- Kubernetes was created by Google to automate the management, scaling, and deployment of containerized applications across clusters of servers, solving the problem of coordination and management at scale that Docker alone cannot handle.

- Docker allows to build and run containers,but it mainly focuses on running containers on a single machine.
- When applications grow and require many containers running across multiple servers, managing them manually becomes difficult. Tasks like scaling containers, restarting failed ones
- Kubernetes solves these issues by acting as a container orchestration system, which can automatically:
    - Scale containers based on demand
    - Restart containers when they fail
    - Manage and schedule containers across multiple machines
- In short, Docker runs containers, while Kubernetes manages large numbers of containers across a cluster of servers.

2. Who created Kubernetes and what was it inspired by?
- Google introduced **Kubernetes** in 2014.
- The project was inspired by Borg, an internal system used by Google to manage containers at massive scale.
- Borg could automatically handle tasks such as scaling and restarting containers.
- Google later released Kubernetes as an open-source project.
- Today it is maintained by the (CNCF) Cloud Native Computing Foundation, which is part of the Linux Foundation.

3. What does the name "Kubernetes" mean?
- The name Kubernetes comes from a Greek word meaning “helmsman” or “ship pilot.” It refers to someone who steers a ship.
- This name reflects the role of Kubernetes, which guides and manages containers, similar to how a helmsman controls a ship.
- Kubernetes is often shortened to **K8s**, where the number 8 represents the eight letters between K and S.

---

### Task 2: Draw the Kubernetes Architecture
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

[k8s Architechture](<img width="732" height="852" alt="image" src="https://github.com/user-attachments/assets/c585b0b7-8964-4b42-9731-59a3392d2f62" />)

After drawing, verify your understanding:
- What happens when you run `kubectl apply -f pod.yaml`? Trace the request through each component.

  1. kubectl reads the pod.yaml file.
  2. The request is sent to the Kubernetes API Server.
  3. API Server performs: Authentication, Authorization
  4. If valid, the Pod object is stored in etcd.
  5. The Kubernetes Scheduler detects the unscheduled Pod and assigns it to a node.
  6. The kubelet on that node sees the Pod and instructs the container runtime (e.g., containerd) to start the container.
  7. The container starts and the Pod status is updated to Running in the API Server.

- What happens if the API server goes down?
  - You cannot run kubectl commands or make changes to the cluster.
  - Running pods and services continue working, but no new deployments or scheduling happen.

- What happens if a worker node goes down?
  - Pods on that node stop running.
  - Kubernetes detects the failure and reschedules those pods on other healthy nodes.
    
---

### Task 3: Install kubectl
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

---

### Task 4: Set Up Your Local Cluster
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

### Task 5: Explore Your Cluster
Now that your cluster is running, explore it:

```bash
# See cluster info
kubectl cluster-info

# List all nodes
kubectl get nodes

# Get detailed info about your node
kubectl describe node <node-name>

# List all namespaces
kubectl get namespaces

# See ALL pods running in the cluster (across all namespaces)
kubectl get pods -A
```

Look at the pods running in the `kube-system` namespace:
```bash
kubectl get pods -n kube-system
```

You should see pods like `etcd`, `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `coredns`, and `kube-proxy`. These are the architecture components you drew in Task 2 — running as pods inside the cluster.

**Verify:** Can you match each running pod in `kube-system` to a component in your architecture diagram?

---

### Task 6: Practice Cluster Lifecycle
Build muscle memory with cluster operations:

```bash
# Delete your cluster
kind delete cluster --name devops-cluster
# (or: minikube delete)

# Recreate it
kind create cluster --name devops-cluster
# (or: minikube start)

# Verify it is back
kubectl get nodes
```

Try these useful commands:
```bash
# Check which cluster kubectl is connected to
kubectl config current-context

# List all available contexts (clusters)
kubectl config get-contexts

# See the full kubeconfig
kubectl config view
```

Write down: What is a kubeconfig? Where is it stored on your machine?

---

## Hints
- kind requires Docker to be running (it creates clusters using containers)
- minikube can use Docker, VirtualBox, or other drivers
- The default kubeconfig file is at `~/.kube/config`
- `kubectl get pods -A` is short for `kubectl get pods --all-namespaces`
- If `kubectl` cannot connect, check if your cluster is running: `kind get clusters` or `minikube status`
- `-o wide` flag gives extra details: `kubectl get nodes -o wide`

---

## Learn in Public
Share on LinkedIn: "Started my Kubernetes journey today. Set up a local cluster, explored the architecture, and saw the control plane components running as actual pods. The orchestration chapter begins."

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
