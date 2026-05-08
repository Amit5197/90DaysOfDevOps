# Day 30 – Docker Images & Container Lifecycle

## Task
Today's goal is to **understand how images and containers actually work**.

You will:
- Learn the relationship between images and containers
- Understand image layers and caching
- Master the full container lifecycle

---

### Task 1: Docker Images
1. Pull the `nginx`, `ubuntu`, and `alpine` images from Docker Hub
<img width="720" height="387" alt="image" src="https://github.com/user-attachments/assets/76402d45-49d6-4c1f-8b4d-722e5e1ffcd8" />

2. List all images on your machine — note the sizes
<img width="720" height="155" alt="image" src="https://github.com/user-attachments/assets/82a7db31-c7ab-4836-8956-93670ea92ca0" />

| Image         | Disk Usage | Content Size |
    | ------------- | ---------- | ------------ |
    | alpine:latest | 13.1MB     | 3.95MB       |
    | nginx:latest  | 240MB      | 65.8MB       |
    | ubuntu:latest | 119MB      | 31.7MB       |

    **Local Size(Disk usage) is actual image size**

    **Transfer Size(Content Size) is amount of data used when pulling the inage over a network**

3. Compare `ubuntu` vs `alpine` — why is one much smaller?

- `Ubuntu` is a full-featured Linux distribution, while `Alpine` is a minimal distribution optimized for containers. 
- `Ubuntu` is larger because it includes GNU tools and glibc, whereas `Alpine` uses BusyBox and musl, making it much smaller.

4. Inspect an image — what information can you see?
<img width="510" height="916" alt="image" src="https://github.com/user-attachments/assets/43346e75-4084-4c0b-9d72-35df57c04c00" />

    - Image ID: sha256:6d7c150df58d41c...
    - Image: nginx:latest
    - Exposed Port: 80/tcp (HTTP)
    - Repository: docker.io/library/nginx
    - Environment variable
    - NGINX Version: 1.29.8
    - ENTRYPOINT
    - CMD
    - Lables,maintainer
    - Filesystem | Uses layered filesystem | 7 layers

5. Remove an image you no longer need
<img width="776" height="352" alt="image" src="https://github.com/user-attachments/assets/81f3892b-7f9a-4f6a-86eb-8ab958c0b69c" />
<img width="718" height="125" alt="image" src="https://github.com/user-attachments/assets/445aeaef-c037-42ac-80fe-f8f9ab728ffe" />

---

### Task 2: Image Layers
1. Run `docker image history nginx` — what do you see?
<img width="877" height="690" alt="image" src="https://github.com/user-attachments/assets/3426910c-7060-4dd5-bb9d-b40d6e0d61c7" />

- A list of instructions used to build the nginx image (e.g., CMD, EXPOSE, ENTRYPOINT, COPY, RUN, ENV, LABEL) Each instruction corresponds to a layer.
  
2. Each line is a **layer**. Note how some layers show sizes and some show 0B
+ Layers with a size (MB or kB) were created by instructions that modify the filesystem,such as RUN, COPY, or ADD.
+ Layers showing 0B were created by instructions that only change metadata, such as ENV, CMD, EXPOSE, LABEL, or ENTRYPOINT.These do not change the filesystem.

3. Write in your notes: What are layers and why does Docker use them?
- Docker layers are read-only filesystem snapshots created by each instruction in a Dockerfile.
- Docker uses layers because:
    - They allow build caching (faster builds)
    - They allow images to share
 common layers (saves storage).
    - They make image downloads faster (only new layers are pulled)

---

### Task 3: Container Lifecycle
Practice the full lifecycle on one container:
1. **Create** a container (without starting it)
2. **Start** the container
3. **Pause** it and check status
4. **Unpause** it
5. **Stop** it
6. **Restart** it
7. **Kill** it
8. **Remove** it

<img width="862" height="400" alt="image" src="https://github.com/user-attachments/assets/8dd2c2e6-dfcf-4ddc-ab53-df065d1eef78" />
<img width="871" height="947" alt="image" src="https://github.com/user-attachments/assets/f9367495-c75d-4600-b579-f545543b79ee" />

---

### Task 4: Working with Running Containers
1. Run an Nginx container in detached mode
2. View its **logs**
3. View **real-time logs** (follow mode)
<img width="797" height="872" alt="image" src="https://github.com/user-attachments/assets/c431e500-083c-423a-9ea3-a72fd558a1db" />


4. **Exec** into the container and look around the filesystem
<img width="720" height="696" alt="image" src="https://github.com/user-attachments/assets/a230a63b-a1f1-43d4-a7b7-a71932f7d9e5" />

5. Run a single command inside the container without entering it
<img width="697" height="277" alt="image" src="https://github.com/user-attachments/assets/827f96e6-17e9-4da1-8da0-efbe4312bec5" />

6. **Inspect** the container — find its IP address, port mappings, and mounts
<img width="560" height="925" alt="image" src="https://github.com/user-attachments/assets/bc582756-f116-42cd-bb2e-8da32d80375e" />
<img width="907" height="352" alt="image" src="https://github.com/user-attachments/assets/c38dda7c-5ad4-4eba-af37-3bf9173345fa" />
<img width="451" height="256" alt="image" src="https://github.com/user-attachments/assets/cf8b8fd5-7015-4fab-a969-758c4d83502d" />
<img width="372" height="101" alt="image" src="https://github.com/user-attachments/assets/aa5a19ea-9f55-4c4e-b4cd-988a375d9699" />

---

### Task 5: Cleanup
1. Stop all running containers in one command
2. Remove all stopped containers in one command
3. Remove unused images
4. Check how much disk space Docker is using

---

## Hints
- Image history: `docker image history`
- Create without starting: `docker create`
- Follow logs: `docker logs -f`
- Inspect: `docker inspect`
- Cleanup: `docker system df`, `docker system prune`

---

## Submission
1. Add your `day-30-images.md` to `2026/day-30/`
2. Commit and push to your fork

---

## Learn in Public
Share what surprised you about image layers or container states on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
