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

<img width="732" height="852" alt="image" src="https://github.com/user-attachments/assets/c585b0b7-8964-4b42-9731-59a3392d2f62" />

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
<img width="715" height="147" alt="image" src="https://github.com/user-attachments/assets/0303a819-cb6a-49fa-8e07-bc942d6788a3" />

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
<img width="690" height="462" alt="image" src="https://github.com/user-attachments/assets/914513d1-3a1a-4657-ac99-83c57e8770bb" />

<img width="1007" height="292" alt="image" src="https://github.com/user-attachments/assets/4856c53b-b1d8-4edb-be14-67eeb8677348" />

- The cluster initialized successfully, and the control plane node became Ready.

Cluster endpoint: (https://127.0.0.1:57030)
Node name: cluster-control-plane
Role: control-plane
Kubernetes version:  v1.35.0

Write down: Which one did you choose and why?
- I chose **KIND (Kubernetes IN Docker)** because it is lightweight and easy to set up for local testing. 
- It runs a **Kubernetes** Cluster inside Docker containers, so I can quickly create & delete clusters without needing VMs or a cloud environment.
- This makes it ideal for **development, CI testing, and experimenting with Kubernetes features**.

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

<img width="1237" height="702" alt="image" src="https://github.com/user-attachments/assets/e4ec8c9f-d296-4ee9-8f65-2ca3421c5e54" />

- This kubectl command in Kubernetes shows detailed information about the node devops-cluster-control-plane, including its status,resources,conditions,running pods and events.

# List all namespaces
kubectl get namespaces

<img width="702" height="166" alt="image" src="https://github.com/user-attachments/assets/af70447e-d8bb-45fa-83a2-fed5d56aa49d" />

# See ALL pods running in the cluster (across all namespaces)
kubectl get pods -A
```
<img width="952" height="300" alt="image" src="https://github.com/user-attachments/assets/d2c77448-ca6d-48b0-bb1c-8896e9d67436" />

Look at the pods running in the `kube-system` namespace:
```bash
kubectl get pods -n kube-system
```
<img width="787" height="281" alt="image" src="https://github.com/user-attachments/assets/19869d90-707b-4271-8143-b0fb6d90e2e8" />

kube-system Contains core Kubernetes system components such as:

- CoreDNS – cluster DNS service
   - etcd – cluster key-value database
   - kube-apiserver – API server for the cluster
   - kube-controller-manager – manages controllers
   - kube-scheduler – schedules pods to nodes
   - kube-proxy – manages networking rules
   - kindnet – networking plugin

- local-path-storage
   - local-path-provisioner – provides dynamic local storage for pods.

You should see pods like `etcd`, `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `coredns`, and `kube-proxy`. These are the architecture components you drew in Task 2 — running as pods inside the cluster.

**Verify:** Can you match each running pod in `kube-system` to a component in your architecture diagram?

**Status**

- All pods show READY 1/1 and STATUS Running, meaning the cluster components are working correctly.
   - Look at the pods running in the kube-system namespace:

```kubectl get pods -n kube-system```

<img width="782" height="267" alt="image" src="https://github.com/user-attachments/assets/1174968c-a36b-4e2f-a215-ed520390a078" />


### Kubernetes System Pods

| Pod Name | Purpose |
|---|---|
| coredns | Provides DNS services so pods can communicate using service names. |
| etcd-devops-cluster-control-plane | Distributed key-value store that holds all cluster configuration and state. |
| kindnet | Networking plugin used by KIND to enable pod networking. |
| kube-apiserver-devops-cluster-control-plane | Main API server that handles all Kubernetes API requests. |
| kube-controller-manager-devops-cluster-control-plane | Runs controllers that manage cluster state such as nodes, replicas, and endpoints. |
| kube-proxy | Manages network rules and enables service networking for pods. |
| kube-scheduler-devops-cluster-control-plane | Assigns newly created pods to available nodes. |

### Status

**READY 1/1**: All containers inside the pod are running.

**STATUS Running**: Pod is functioning correctly.

**RESTARTS 0**: No container crashes occurred.

**AGE 30m**: Pod has been running for 30 minutes.

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
<img width="837" height="662" alt="image" src="https://github.com/user-attachments/assets/4f6b9eb2-d1f9-4ec7-a0b4-91dc723887e4" />

Try these useful commands:
```bash
# Check which cluster kubectl is connected to
kubectl config current-context

# List all available contexts (clusters)
kubectl config get-contexts

# See the full kubeconfig
kubectl config view
```

<img width="752" height="662" alt="image" src="https://github.com/user-attachments/assets/cfd1a2a4-f3f7-4075-8719-36b1182f2652" />

Write down: What is a kubeconfig? Where is it stored on your machine?
- kubeconfig is a configuration file used by Kubernetes clients kubectl to connect to a Kubernetes cluster.
- It stores cluster details, user credentials, and contexts.
- Location: ~/.kube/config

- `-o wide` flag gives extra details: `kubectl get nodes -o wide`
- 
---

## Hints
- kind requires Docker to be running (it creates clusters using containers)
- minikube can use Docker, VirtualBox, or other drivers
- The default kubeconfig file is at `~/.kube/config`
- `kubectl get pods -A` is short for `kubectl get pods --all-namespaces`
- If `kubectl` cannot connect, check if your cluster is running: `kind get clusters` or `minikube status`

## `-o wide` flag gives extra details: `kubectl get nodes -o wide`

<img width="1292" height="197" alt="image" src="https://github.com/user-attachments/assets/81278d49-12ee-44ee-be02-f735bd32b584" />

---

Happy Learning!
**TrainWithShubham**
