# Day 35 – Multi-Stage Builds & Docker Hub

## Challenge Tasks

### Task 1: The Problem with Large Images
1. Write a simple Go, Java, or Node.js app (even a "Hello World" is fine)
2. Create a Dockerfile that builds and runs it in a **single stage**
3. Build the image and check its **size**

Note down the size — you'll compare it later.

```docker build -t java-single-stage .```
<img width="778" height="500" alt="image" src="https://github.com/user-attachments/assets/16b10fdb-75b8-4969-a87e-6aafb55c7ecb" />
<img width="751" height="222" alt="image" src="https://github.com/user-attachments/assets/c1773e65-360c-4890-98ae-7b1b8eb2e684" />

[Dockerfile](java-app/Dockerfile)

---

### Task 2: Multi-Stage Build
1. Rewrite the Dockerfile using **multi-stage build**:
   - Stage 1: Build the app (install dependencies, compile)
   - Stage 2: Copy only the built artifact into a minimal base image (`alpine`, `distroless`, or `scratch`)

2. Build the image and check its size again

3. Compare the two sizes

- First image size is 638 MB
- Multi-stage image size is 256 MB

[Dockerfile](java-app/Dockerfile.multistage)

```docker build -f Dockerfile.multistage -t java-multi-stage:v1 .```

<img width="750" height="977" alt="image" src="https://github.com/user-attachments/assets/b8199a8c-7927-4b4a-af28-763b02475b70" />

Write in your notes: Why is the multi-stage image so much smaller?

- Multi-stage builds smaller images because they separate “build” from “runtime”, copying only what’s necessary into the final image.

---

### Task 3: Push to Docker Hub
1. Create a free account on [Docker Hub](https://hub.docker.com) (if you don't have one)
2. Log in from your terminal
3. Tag your image properly: `yourusername/image-name:tag`
4. Push it to Docker Hub
5. Pull it on a different machine (or after removing locally) to verify

<img width="742" height="256" alt="image" src="https://github.com/user-attachments/assets/0f2a76ca-5c68-4a93-9b03-a9266a764f05" />
<img width="757" height="265" alt="image" src="https://github.com/user-attachments/assets/1bd36b25-fe32-47f5-b4b6-da39c93dc2dc" />
<img width="1902" height="592" alt="image" src="https://github.com/user-attachments/assets/ac4a2d78-8d18-4d4a-8f56-8f35974afeca" />

---

### Task 4: Docker Hub Repository
1. Go to Docker Hub and check your pushed image
2. Add a **description** to the repository
3. Explore the **tags** tab — understand how versioning works
4. Pull a specific tag vs `latest` — what happens?

---

### Task 5: Image Best Practices
Apply these to one of your images and rebuild:
1. Use a **minimal base image** (alpine vs ubuntu — compare sizes)
2. **Don't run as root** — add a non-root USER in your Dockerfile
3. Combine `RUN` commands to **reduce layers**
4. Use **specific tags** for base images (not `latest`)

Check the size before and after.

---

## Learn in Public
Share your before/after image sizes on LinkedIn — the difference is always impressive.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
