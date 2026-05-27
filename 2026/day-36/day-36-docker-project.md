# Day 36 – Docker Project: Dockerize a Full Application

## Challenge Tasks

### Task 1: Pick Your App
Choose **one** of these (or use your own project):
- A **Python Flask/Django** app with a database
- A **Node.js Express** app with MongoDB
- A **static website** served by Nginx with a backend API
- Any app from your GitHub that doesn't have Docker yet

A **Python Flask/Django** app with a database

[Python-Flash-App](Python-Flash-App)

<img width="1897" height="263" alt="image" src="https://github.com/user-attachments/assets/ea8a1b6d-f011-4105-ba15-bb62b4947c67" />

---

### Task 2: Write the Dockerfile
1. Create a Dockerfile for your application
2. Use a **multi-stage build** if applicable
3. Use a **non-root user**
4. Keep the image **small** — use alpine or slim base images
5. Add a `.dockerignore` file

[Dockerfile](Python-Flash-App/Dockerfile)

Build and test it locally.

---

### Task 3: Add Docker Compose
Write a `docker-compose.yml` that includes:
1. Your **app** service (built from Dockerfile)
2. A **database** service (Postgres, MySQL, MongoDB — whatever your app needs)
3. **Volumes** for database persistence
4. A **custom network**
5. **Environment variables** for configuration (use `.env` file)
6. **Healthchecks** on the database

Run `docker compose up` and verify everything works together.

[Docker Compose](./Python-Flash-App/docker-compose.yml)

---

### Task 4: Ship It
1. Tag your app image
2. Push it to Docker Hub
3. Share the Docker Hub link
4. Write a `README.md` in your project with:
   - What the app does
   - How to run it with Docker Compose
   - Any environment variables needed

<img width="1897" height="263" alt="image" src="https://github.com/user-attachments/assets/6726d9c2-0a82-4714-902d-dcfebf2e0335" />

---

### Task 5: Test the Whole Flow
1. Remove all local images and containers
2. Pull from Docker Hub and run using only your compose file
3. Does it work fresh? If not — fix it until it does

<img width="1063" height="200" alt="image" src="https://github.com/user-attachments/assets/afbdb55f-62f1-4fc9-a7eb-f90ebca1fa80" />

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
