# Docker Cheat Sheet

## Container commands

- Run a container interactively from an image on Docker Hub:
  - `docker run -id <image>`
- Run a container in detached mode:
  - `docker run -d <image>`
- List running containers:
  - `docker ps`
- List all containers (including stopped):
  - `docker ps -a`
- Stop a running container:
  - `docker stop <container_name_or_id>`
- Remove a stopped container:
  - `docker rm <container_name_or_id>`
- Remove a container even if it’s running:
  - `docker rm -f <container_name_or_id>`
- Execute a command inside a running container:
  - `docker exec -it <container_name_or_id> <command>` (e.g., `sh`,`bash`)
- See logs of a container:
  - `docker logs <container_name_or_id>`

---

## Image commands

- Build an image from a Dockerfile in the current directory:
  - `docker build -t <image_name:tag> .`
- Pull an image from Docker Hub (or registry):
  - `docker pull <image_name:tag>`
- Push a tagged image to Docker Hub:
  - `docker push <username/image_name:tag>`
- Tag an existing image:
  - `docker tag <source_image:tag> <target_image:tag>`
- List local images:
  - `docker images` or `docker image ls`
- Remove an image:
  - `docker rmi <image_name_or_id>`

---

## Volume commands

- Create a named volume:
  - `docker volume create <volume_name>`
- List volumes:
  - `docker volume ls`
- Inspect a volume:
  - `docker volume inspect <volume_name>`
- Remove a volume:
  - `docker volume rm <volume_name>`

---

## Network commands

- Create a custom bridge network:
  - `docker network create <network_name>`
- List networks:
  - `docker network ls`
- Inspect a network:
  - `docker network inspect <network_name>`
- Connect a running container to a network:
  - `docker network connect <network_name> <container_name_or_id>`

---

## Compose commands

- Start services defined in docker-compose.yml:
  - `docker compose up`
- Start services in detached mode:
  - `docker compose up -d`
- Stop and remove services:
  - `docker compose down`
- Stop services and remove named volumes too:
  - `docker compose down -v`
- List running services:
  - `docker compose ps`
- View logs of services:
  - `docker compose logs`
- Build images defined in compose (without starting):
  - `docker compose build`

---

## Cleanup commands

- Remove stopped containers, unused networks, dangling images:
  - `docker system prune`
- Remove stopped containers, unused networks, all dangling images, and unused build cache:
  - `docker system prune -a`
- Show Docker disk usage:
  - `docker system df`

---

## Dockerfile instructions (in your own words)

- `FROM <base_image>` – start the image from a base (e.g., `alpine`, `debian`, `node:18`).
- `RUN <command>` – run a command during build (e.g., `apt update && apt install -y ...`).
- `COPY <src> <dest>` – copy files from the host context into the image.
- `WORKDIR <path>` – set the working directory for subsequent instructions.
- `EXPOSE <port>` – document that the container listens on a port (no binding by default).
- `CMD ["cmd", "arg1"]` – default command to run when the container starts (can be overridden).
- `ENTRYPOINT ["cmd"]` – main executable; `CMD` becomes default arguments (harder to override).
- Multi‑stage build example:
  - Use `FROM <builder>` for build‑time tools, then `FROM <runtime>` for final image, copying only needed artifacts.
- `HEALTHCHECK` – define how Docker should check if the container is healthy.
- `ENV <KEY>=<VALUE>` – set environment variables in the image.

- `RUN ls -la` - show all running steps in dockerfile 
