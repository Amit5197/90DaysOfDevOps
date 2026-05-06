# Day 29 – Introduction to Docker

### Task 1:

### What is Docker?

- Docker is an open-source platform that enables developers to build, ship, and run applications inside lightweight, isolated environments called containers.

### Why we need?
- You can build locally,deploy to the cloud and run anywhere on any server.
- Shares the host kernel, making them much more efficient in therms of system resources than vitual machine.
- Makes collaboration easier, same environment for everyone.
- No version mismatch issues.

### Containers vs Virtual Machines

| Feature | Virtual Machines (VMs) | Containers |
|----------|------------------------|------------|
| **Virtualization Level** | Hardware-level virtualization | OS-level virtualization |
| **Architecture** | Includes full guest OS + hypervisor | Shares host OS kernel |
| **Size** | Large (GBs) | Small (MBs) |
| **Startup Time** | Slow (minutes) | Fast (seconds) |
| **Performance** | Slower due to OS overhead | Faster, lightweight |
| **Isolation** | Strong (separate OS per VM) | Process-level isolation |
| **Resource Usage** | High CPU, RAM, Storage usage | Efficient resource usage |
| **Portability** | Less portable | Highly portable |
| **Management** | Complex (manage full OS) | Simple (manage app + dependencies) |
| **Best For** | Legacy apps, multiple OS environments | Microservices, CI/CD, cloud-native apps |

### Docker architecture

<img width="938" height="518" alt="image" src="https://github.com/user-attachments/assets/50f5a280-d3b8-45f4-8795-9c3d5b6d5d57" />

---

### Docker Client

### What it is ?
The Docker client is the command-line interface (CLI) used to interact with Docker. It acts as the command center.

### How it works ?
You type commands in the Docker client, and it sends those requests to the Docker daemon, which performs the actual work.

### Example Commands
- `docker build`
- `docker run`
- `docker pull`
- `docker push`

---

### Docker Daemon

### What it is ?
The Docker daemon (`dockerd`) is the background service that manages Docker objects such as images, containers, networks, and volumes.

### How it works ?
The daemon:
- Listens for Docker API requests from the Docker client
- Builds images
- Runs and manages containers
- Handles networking and storage

---

### Docker Hub

### What it is
Docker Hub is a cloud-based public registry for Docker images.

### How it works
It works like an app store for container images. 

You can:
- **Pull** images created by others
- **Push** your own images

### Usage
When you need an image to create a container, you can pull it from Docker Hub.

---

### Docker Registry

### What it is ?
+ A Docker registry is a system that stores and distributes Docker images. Docker Hub is the most popular public registry,
but you can also create private registries.

Like- Username & password as a registry.

### How it works ?
Registries:
- Store Docker images
- Allow users to pull images
- Allow users to push images

Private registries are commonly used by companies to securely store internal application images.

---

### Task 2: Install Docker
1. Install Docker on your machine (or use a cloud instance)
2. Verify the installation
3. Run the `hello-world` container
4. Read the output carefully — it explains what just happened

---

### Task 3: Run Real Containers
1. Run an **Nginx** container and access it in your browser
2. Run an **Ubuntu** container in interactive mode — explore it like a mini Linux machine
3. List all running containers
4. List all containers (including stopped ones)
5. Stop and remove a container

---

### Task 4: Explore
1. Run a container in **detached mode** — what's different?
2. Give a container a custom **name**
3. Map a **port** from the container to your host
4. Check **logs** of a running container
5. Run a command **inside** a running container

---

## Hints
- `docker run`, `docker ps`, `docker stop`, `docker rm`
- Interactive mode: `-it` flag
- Detached mode: `-d` flag
- Port mapping: `-p host:container`
- Naming: `--name`
- Logs: `docker logs`
- Exec into container: `docker exec`

---

## Why This Matters for DevOps
Docker is the foundation of modern deployment. Every CI/CD pipeline, Kubernetes cluster, and microservice architecture starts with containers. Today you took the first step.

---

## Submission
1. Add your `day-29-docker-basics.md` to `2026/day-29/`
2. Commit and push to your fork

---

## Learn in Public
Share your first Docker container screenshot on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
