# Day 31 – Dockerfile: Build Your Own Images

## Task
Today's goal is to **write Dockerfiles and build custom images**.

## Challenge Tasks

### Task 1: Your First Dockerfile
1. Create a folder called `my-first-image`
2. Inside it, create a `Dockerfile` that:
   - Uses `ubuntu` as the base image
   - Installs `curl`
   - Sets a default command to print `"Hello from my custom image!"`
3. Build the image and tag it `my-ubuntu:v1`
<img width="621" height="123" alt="image" src="https://github.com/user-attachments/assets/3faceb27-935b-4fa1-a8c6-35171862daaf" />
<img width="777" height="607" alt="image" src="https://github.com/user-attachments/assets/46d0c22a-660b-4215-9e51-c61d00dba7bd" />
<img width="811" height="353" alt="image" src="https://github.com/user-attachments/assets/a6ee3e46-1e2d-48b6-bb2b-202ef76dd269" />

4. Run a container from your image
<img width="612" height="113" alt="image" src="https://github.com/user-attachments/assets/f56016ea-4bd0-466e-a151-9d905dcc0b1c" />

**Verify:** The message prints on `docker run`

### 🐳 Docker Errors Faced and debugged

❌ Error 1: [echo: not found
 ``/bin/sh: 1: [echo: not found ``

Reason :

 - Image  ``(my-ubuntu:v1) `` was built earlier with an  ``incorrect CMD ``

 - Dockerfile was fixed later, but image was  ``not rebuilt ``

 - Docker kept using the old broken image

Fix :

docker build -t my-ubuntu:v2 .
docker run my-ubuntu:v2

Key Learning :

Docker images are  ``immutable — always rebuild after Dockerfile changes. ``

 ❌ Error 2: ``Wrong Dockerfile Name``

 Docker only auto-detects a file named exactly Dockerfile
(case-sensitive).
Fix: If the file is named incorrectly (e.g. DockerFile, dockerfile, Dockerfile-dev), Docker will fail to build unless explicitly     told which file to use.

❌ Error 3:  ``Container name already in use ``

Conflict. The container name "/first-container" is already in use
Reason :
 - A container named first-container already exists
 - Docker does not allow  ``duplicate container names ``
Fix :
docker rm first-container
or
`docker run --name first-container-v2 my-ubuntu:v1`

Key Learning :
Container names must be unique.

---

### Task 2: Dockerfile Instructions
Create a new Dockerfile that uses **all** of these instructions:
- `FROM` `python:3.12-alpine`
Uses lightweight Python image based on Alpine Linux.

- `WORKDIR` `/app`
Sets /app as working directory inside container.

- `COPY . .`
Copies everything from your my-first-image folder into /app inside container.

- `RUN` `pip install -r requirements.txt`
Installs all Python dependencies.

- `EXPOSE 5000`
Documents that container uses port 5000.

- `CMD ["python","app.py"]`

<img width="738" height="260" alt="image" src="https://github.com/user-attachments/assets/700bb18e-a43e-43ea-8ae4-f3efe2752c33" />
<img width="868" height="778" alt="image" src="https://github.com/user-attachments/assets/6c6a7b62-4a3d-4dec-b265-a5100c66bdb3" />

---

### Task 3: CMD vs ENTRYPOINT
1. Create an image with `CMD ["echo", "hello"]` — run it, then run it with a custom command. What happens?
<img width="736" height="882" alt="image" src="https://github.com/user-attachments/assets/c9c70996-d2f0-40b7-8cea-3ec4c41cbbb1" />
- Run without arguments: The container runs the default command echo hello and outputs:

`hello`

- Run with a custom command: When you run the container with a custom command (e.g., echo "custom command"), the custom command completely overrides the CMD, so the output is:

`custom command`

2. Create an image with `ENTRYPOINT ["echo"]` — run it, then run it with additional arguments. What happens?

<img width="758" height="668" alt="image" src="https://github.com/user-attachments/assets/4cb17689-3865-4348-91ee-269e6d99cf5b" />

- Run without arguments: The container runs echo with no arguments,resulting in a blank line (no output).

- Run with additional arguments: When you pass arguments (e.g., hello-world), they are appended to the ENTRYPOINT, so it runs echo hello-world and outputs:

`hello-world`

3. Write in your notes: When would you use CMD vs ENTRYPOINT?

- Use CMD when you want to provide a default command that can be changed easily when you run the container.
- Use ENTRYPOINT when you want to set a fixed command that always runs.

## CMD vs ENTRYPOINT — Quick Memory Table

| Aspect | CMD | ENTRYPOINT |
|------|-----|-----------|
| Purpose | Provides a default command | Defines the main executable |
| Overridden by `docker run` | ✅ Yes | ❌ No (unless `--entrypoint`) |
| User input treated as | New command | Arguments to the executable |
| Flexibility | High | Low (fixed behavior) |
| Best use case | Dev, utility, base images | Apps, CLIs, production services |
| Common example | `CMD ["bash"]` | `ENTRYPOINT ["nginx"]` |
| If both are used | CMD is replaced | ENTRYPOINT always runs |
| Interview memory line | “CMD is a default” | “ENTRYPOINT is mandatory” |

### One-Line Memory Trick
**CMD = suggestion | ENTRYPOINT = rule**

---

### Task 4: Build a Simple Web App Image
1. Create a small static HTML file (`index.html`) with any content
<img width="585" height="123" alt="image" src="https://github.com/user-attachments/assets/37ebe298-0d49-44f8-925b-da5c8bf109d1" />

2. Write a Dockerfile that:
   - Uses `nginx:alpine` as base
   - Copies your `index.html` to the Nginx web directory
3. Build and tag it `my-website:v1`
4. Run it with port mapping and access it in your browser
<img width="585" height="123" alt="image" src="https://github.com/user-attachments/assets/88e4ea57-49ee-4b88-a03f-6610c2601175" />
<img width="851" height="543" alt="image" src="https://github.com/user-attachments/assets/3c355701-67ed-4c96-88da-c65c378ec47c" />
<img width="862" height="430" alt="image" src="https://github.com/user-attachments/assets/fd0af181-b206-41d7-8e53-6781be8a27bc" />

---

### Task 5: .dockerignore
1. Create a `.dockerignore` file in one of your project folders
2. Add entries for: `node_modules`, `.git`, `*.md`, `.env`
3. Build the image — verify that ignored files are not included
<img width="862" height="492" alt="image" src="https://github.com/user-attachments/assets/855998e9-be59-4ae6-8ced-6eb24812ce10" />
<img width="905" height="123" alt="image" src="https://github.com/user-attachments/assets/d96b0beb-d624-4d12-bd7f-d6da9761b0f6" />

- node_modules, .git, any .md files, and .env are not present.
- index.html or required files are present.

---

### Task 6: Build Optimization
1. Build an image, then change one line and rebuild — notice how Docker uses **cache**

```bash
FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python","app.py"]
```
Observation: The image is built successfully and all layers are created.

Change one line and rebuild: change in app.py

```bash
FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python","app.py"]
```

Observation:
Even though only the application code changed
Docker re-ran pip install -r requirements.txt
Any change in source code invalidated the cache for all following layers.

2. Reorder your Dockerfile so that frequently changing lines come **last**
```bash
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python","app.py"]

Observation:
Docker reused cached layers for: Base image, Working directory, Dependency installation.

3. Write in your notes: Why does layer order matter for build speed?
- Docker builds images in layers and caches each layer.
- If a layer changes, Docker Rebuilds that layer and all layers after it.
- By placing:
    - Rarely changing files (dependencies) first.
    - Frequently changing files (source code) last.
- Docker can reuse cached layers,resulting in faster rebuilds.

##Docker Layer Order and Build Speed
Why Layer Order Matters for Build Speed?
- Docker uses caching to speed up builds. When you build an image, Docker checks each instruction in your Dockerfile:
- Caching Logic: If a layer hasn't changed, Docker reuses the cached version. However, once a layer is modified, all subsequent layers must be rebuilt from scratch.
- Optimal Order: You should place infrequently changed instructions (like installing OS packages or dependencies) at the top and frequently changed instructions (like your source code) at the bottom.
- Result: This ensures that when you edit your code, Docker only has to rebuild the very last layer, keeping builds fast.

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
