# Day 37 – Docker Revision & Cheat Sheet

## Goal

Take a **one-day pause** to consolidate everything from Days 29–36 so Docker actually sticks.

## Self-Assessment Checklist
Mark yourself honestly — **can do**, **shaky**, or **haven't done**:

- [✔️] Run a container from Docker Hub (interactive + detached)
- [✔️] List, stop, remove containers and images
- [✔️] Explain image layers and how caching works
- [✔️] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [✔️] Explain CMD vs ENTRYPOINT
- [✔️] Build and tag a custom image
- [✔️] Create and use named volumes
- [✔️] Use bind mounts
- [✔️] Create custom networks and connect containers
- [✔️] Write a docker-compose.yml for a multi-container app
- [✔️] Use environment variables and .env files in Compose
- [Shaky] Write a multi-stage Dockerfile
- [✔️] Push an image to Docker Hub
- [✔️] Use healthchecks and depends_on

---

## Quick-Fire Questions
Answer from memory, then verify:
1. What is the difference between an image and a container?
   - Image: read‑only template with instructions and filesystem (like a blueprint).
   - Container: running instance of that image, with its own writable layer and runtime state.

2. What happens to data inside a container when you remove it?
   - By default, data written directly inside the container’s filesystem is lost when the container is removed, unless you used a volume or bind mount outside that container.

3. How do two containers on the same custom network communicate?
   - They can talk over Docker’s internal DNS using the service/container name as the hostname (e.g., `db`, `redis`) on the assigned ports.

4. What does `docker compose down -v` do differently from `docker compose down`?
   - `docker compose down` stops and removes containers, networks, and anonymous volumes.
   - `docker compose down -v` also removes **named volumes** defined in the compose file.

5. Why are multi‑stage builds useful?
   - They let you separate build tools / dependencies from the final runtime image, so the final image is smaller and more secure (no compilers, build caches, etc.).

6. What is the difference between `COPY` and `ADD`?
   - `COPY` just copies local files or directories into the image.
   - `ADD` can also copy local files, but additionally supports URLs and auto‑extracting compressed archives (zip, tar, etc.), which can be less predictable and is discouraged for regular file copying.

7. What does `-p 8080:80` mean?
   - It maps **host port 8080** to **container port 80**, so traffic on `localhost:8080` on the host is forwarded to port 80 inside the container.

8. How do you check how much disk space Docker is using?
   - `docker system df` shows used disk space for images, containers, volumes, and build cache.

---

## Build Your Docker Cheat Sheet
Create `docker-cheatsheet.md` organized by category:
- **Container commands** — run, ps, stop, rm, exec, logs
- **Image commands** — build, pull, push, tag, ls, rm
- **Volume commands** — create, ls, inspect, rm
- **Network commands** — create, ls, inspect, connect
- **Compose commands** — up, down, ps, logs, build
- **Cleanup commands** — prune, system df
- **Dockerfile instructions** — FROM, RUN, COPY, WORKDIR, EXPOSE, CMD, ENTRYPOINT

Keep it short — one line per command, something you'd actually reference on the job.

[Docker-Cheatsheet](docker-cheatsheet.md)

---

Happy Learning!
**TrainWithShubham**
