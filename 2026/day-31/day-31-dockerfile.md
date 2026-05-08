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

---

### Task 4: Build a Simple Web App Image
1. Create a small static HTML file (`index.html`) with any content
2. Write a Dockerfile that:
   - Uses `nginx:alpine` as base
   - Copies your `index.html` to the Nginx web directory
3. Build and tag it `my-website:v1`
4. Run it with port mapping and access it in your browser

---

### Task 5: .dockerignore
1. Create a `.dockerignore` file in one of your project folders
2. Add entries for: `node_modules`, `.git`, `*.md`, `.env`
3. Build the image — verify that ignored files are not included

---

### Task 6: Build Optimization
1. Build an image, then change one line and rebuild — notice how Docker uses **cache**
2. Reorder your Dockerfile so that frequently changing lines come **last**
3. Write in your notes: Why does layer order matter for build speed?

---

## Hints
- Build: `docker build -t name:tag .`
- The `.` at the end is the build context
- `COPY . .` copies everything from host to container
- Nginx serves files from `/usr/share/nginx/html/`

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
