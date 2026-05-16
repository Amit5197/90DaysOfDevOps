# Day 32 – Docker Volumes & Networking

## Challenge Tasks

### Task 1: The Problem
1. Run a Postgres or MySQL container
<img width="1007" height="532" alt="image" src="https://github.com/user-attachments/assets/c8fc2f03-049a-4420-a68e-f748e01916b4" />

2. Create some data inside it (a table, a few rows — anything)
<img width="751" height="807" alt="image" src="https://github.com/user-attachments/assets/6f1b794f-04e2-4c1b-a1ef-359522a57b2a" />

3. Stop and remove the container
<img width="721" height="197" alt="image" src="https://github.com/user-attachments/assets/c3a37d9f-00b8-4d2c-85cd-69d2aa7afc3f" />

4. Run a new one — is your data still there?
<img width="767" height="740" alt="image" src="https://github.com/user-attachments/assets/9237a79b-c411-4214-8b38-9ec14a270ee7" />

## What happened and why----> Data is Still there- No, Data is lost when a container is removed because containers are ephemeral and do not persist data by default.

---

### Task 2: Named Volumes
1. Create a named volume
<img width="762" height="212" alt="image" src="https://github.com/user-attachments/assets/0d16540b-c9c1-4968-b1de-c623289c3e95" />

2. Run the same database container, but this time **attach the volume** to it
<img width="802" height="73" alt="image" src="https://github.com/user-attachments/assets/30880eb9-d4c0-4fe5-a9c8-e8a849433dd1" />

3. Add some data, stop and remove the container
<img width="770" height="862" alt="image" src="https://github.com/user-attachments/assets/e2f70566-7e8c-471a-8ac7-87fba47a25be" />
<img width="720" height="190" alt="image" src="https://github.com/user-attachments/assets/a9ed26a2-15f6-4895-ba63-16c543a5d15b" />

4. Run a brand new container with the **same volume**
<img width="793" height="802" alt="image" src="https://github.com/user-attachments/assets/12ffc116-a58e-40bb-a465-9e0178072d7c" />

5. Is the data still there?
- Yes, all previous data ,tables and rows are still there.

Verify: `docker volume ls`, `docker volume inspect`

<img width="722" height="408" alt="image" src="https://github.com/user-attachments/assets/1eb5c509-a027-452d-81dd-bcfe61429c8e" />

---

### Task 3: Bind Mounts
1. Create a folder on your host machine with an `index.html` file
<img width="732" height="221" alt="image" src="https://github.com/user-attachments/assets/c51d99db-0327-4bd5-ab53-650e850c33a3" />
<img width="837" height="581" alt="image" src="https://github.com/user-attachments/assets/64dfc0e3-88ed-471f-9d82-5a813f220843" />

2. Run an Nginx container and **bind mount** your folder to the Nginx web directory
3. Access the page in your browser
<img width="837" height="581" alt="image" src="https://github.com/user-attachments/assets/a7130d70-f56a-4ec9-85fc-e584533598b0" />

4. Edit the `index.html` on your host — refresh the browser
<img width="935" height="662" alt="image" src="https://github.com/user-attachments/assets/994691e4-95cf-498b-a7bd-0abdb638d551" />

## What is the difference between a named volume and a bind mount?

**Volumes vs Bind Mounts**
**Volumes:**
- Managed by Docker.
- Stored in a part of the host filesystem which is managed by Docker.
- Preferred method for data persistence.

**Bind Mounts:**
- Maps a file or directory on the host to a file or directory in the container.
- More complex but provides flexibility to interact with the host system.
---

### Task 4: Docker Networking Basics
1. List all Docker networks on your machine
<img width="451" height="91" alt="image" src="https://github.com/user-attachments/assets/fc405960-3235-4860-96ed-b0cdb045899d" />

2. Inspect the default `bridge` network
<img width="550" height="916" alt="image" src="https://github.com/user-attachments/assets/59f61e36-c3cb-40cc-b8ba-f73aa36942d0" />
- `docker network inspect` is the command used to retrieve detailed configuration and status information about a specific Docker network.
- The `bridge network` is indeed the default network in Docker.

3. Run two containers on the default bridge — can they ping each other by **name**?
- NO

<img width="721" height="360" alt="image" src="https://github.com/user-attachments/assets/d271ab16-7eac-4b7b-b7b3-eb7adf5abfc9" />

4. Run two containers on the default bridge — can they ping each other by **IP**?

---

### Task 5: Custom Networks
1. Create a custom bridge network called `my-app-net`
2. Run two containers on `my-app-net`
3. Can they ping each other by **name** now?
4. Write in your notes: Why does custom networking allow name-based communication but the default bridge doesn't?

---

### Task 6: Put It Together
1. Create a custom network
2. Run a **database container** (MySQL/Postgres) on that network with a volume for data
3. Run an **app container** (use any image) on the same network
4. Verify the app container can reach the database by container name

---

## Hints
- Volumes: `docker volume create`, `-v volume_name:/path`
- Bind mount: `-v /host/path:/container/path`
- Networking: `docker network create`, `--network`
- Ping: `docker exec container1 ping container2`

---

## Submission
1. Add your `day-32-volumes-networking.md` to `2026/day-32/`
2. Commit and push to your fork

---

## Learn in Public
Share what happened when you deleted a container without a volume on LinkedIn. The "aha moment" is real.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
