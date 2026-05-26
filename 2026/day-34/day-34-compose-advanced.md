# Day 34 – Docker Compose: Real-World Multi-Container Apps

## Challenge Tasks

### Task 1: Build Your Own App Stack
Create a `docker-compose.yml` for a 3-service stack:
- A **web app** (use Python Flask, Node.js, or any language you know)
- A **database** (Postgres or MySQL)
- A **cache** (Redis)

 [Code](web_db_cache/)

- Run and build all images - ```docker compose up -d```

<img width="1062" height="161" alt="image" src="https://github.com/user-attachments/assets/313f7a61-1ffb-46df-b8e3-d42e17570ce8" />

---

### Task 2: depends_on & Healthchecks
1. Add `depends_on` to your compose file so the app starts **after** the database
2. Add a **healthcheck** on the database service
3. Use `depends_on` with `condition: service_healthy` so the app waits for the database to be truly ready, not just started

**Test**: checking everything on docker compose **UP** & **DOWN** — does the app wait for the DB?
- **Yes**

<img width="781" height="136" alt="image" src="https://github.com/user-attachments/assets/73cb7c0c-9e1c-49a1-8003-9b0bf092802e" />
<img width="937" height="90" alt="image" src="https://github.com/user-attachments/assets/fe7eb737-351d-45eb-8be9-5d24445faff0" />

- Postgres container starts first.
- Healthcheck waits until DB is ready.
- App container starts only after DB is healthy

---

### Task 3: Restart Policies
1. Add `restart: always` to your database service
2. Manually kill the database container — does it come back?
3. Try `restart: on-failure` — how is it different?
4. Write in your notes: When would you use each restart policy?

---

### Task 4: Custom Dockerfiles in Compose
1. Instead of using a pre-built image for your app, use `build:` in your compose file to build from a Dockerfile
2. Make a code change in your app
3. Rebuild and restart with one command

---

### Task 5: Named Networks & Volumes
1. Define **explicit networks** in your compose file instead of relying on the default
2. Define **named volumes** for database data
3. Add **labels** to your services for better organization

---

### Task 6: Scaling (Bonus)
1. Try scaling your web app to 3 replicas using `docker compose up --scale`
2. What happens? What breaks?
3. Write in your notes: Why doesn't simple scaling work with port mapping?

---

Happy Learning!
**TrainWithShubham**
