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
<img width="1917" height="893" alt="image" src="https://github.com/user-attachments/assets/fa3910a6-9e60-4d0a-941b-25a190500398" />

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
- **Yes** - It is back.
<img width="1902" height="601" alt="image" src="https://github.com/user-attachments/assets/ddfa0995-5dc5-4839-8f7a-86bd5cf989cf" />

3. Try `restart: on-failure` — how is it different?
- Did't Restart But showing like healthy.

<img width="1798" height="778" alt="image" src="https://github.com/user-attachments/assets/164d3ea8-f2a7-4b26-9f87-1e75afe9b96d" />

4. Write in your notes: When would you use each restart policy?

    - `restart:always` `Use When:`
         Databases,
         Backend APIs,
         Production services,
         Anything that must always run,

    - `restart:on-failure` `Use When`:
         Data processing jobs
         One-time migration scripts

---

### Task 4: Custom Dockerfiles in Compose
1. Instead of using a pre-built image for your app, use `build:` in your compose file to build from a Dockerfile
2. Make a code change in your app
3. Rebuild and restart with one command

[Dockerfile](web_db_cache/app/Dockerfile)

<img width="1897" height="777" alt="image" src="https://github.com/user-attachments/assets/b8d6b981-1e05-4a09-bbdc-dc8f8b40f271" />

<img width="1908" height="930" alt="image" src="https://github.com/user-attachments/assets/074cd077-5a8d-4138-b52e-0c78ab763fee" />
<img width="1902" height="967" alt="image" src="https://github.com/user-attachments/assets/6ee320c9-ea0f-4ccf-b5fb-b6f2e198c104" />

---

### Task 5: Named Networks & Volumes
1. Define **explicit networks** in your compose file instead of relying on the default
2. Define **named volumes** for database data
3. Add **labels** to your services for better organization

[Compose](web_db_cache/docker-compose.yml)

---

### Task 6: Scaling (Bonus)
1. Try scaling your web app to 3 replicas using `docker compose up --scale`

2. What happens? What breaks?

3. Write in your notes: Why doesn't simple scaling work with port mapping?

<img width="1902" height="458" alt="image" src="https://github.com/user-attachments/assets/30a52f6d-efe9-4139-afe9-720271c3697c" />

- First container started

- It binds host port 3000 = container port 3000.

- Second and third containers failed

- Status Created means Docker couldn’t start them, port-3000 - **Showing**- Like this - Bind for 0.0.0.0:3000 failed: port is already allocated.

- Docker can’t bind multiple containers to the same host port.

---

Happy Learning!
**TrainWithShubham**
