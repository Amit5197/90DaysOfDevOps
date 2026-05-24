# Day 33 – Docker Compose: Multi-Container Basics

## Challenge Tasks

### Task 1: Install & Verify
1. Check if Docker Compose is available on your machine
2. Verify the version
<img width="753" height="73" alt="image" src="https://github.com/user-attachments/assets/eb0d7d22-c4dd-473c-9554-8c3f6e35df70" />

---

### Task 2: Your First Compose File
1. Create a folder `compose-basics`
2. Write a `docker-compose.yml` that runs a single **Nginx** container with port mapping
3. Start it with `docker compose up`
4. Access it in your browser
5. Stop it with `docker compose down`

    [Dockerfile](compose-basics/Dockerfile)

   [Compose file](compose-basics/docker-compose.yml)

<img width="1898" height="781" alt="image" src="https://github.com/user-attachments/assets/388992e3-febe-4971-942c-711071ce84f9" />
<img width="1902" height="562" alt="image" src="https://github.com/user-attachments/assets/6e2931ab-f34e-4cbb-9f12-5a8a11250508" />

---

### Task 3: Two-Container Setup
Write a `docker-compose.yml` that runs:
- A **WordPress** container
- A **MySQL** container

They should:
- Be on the same network (Compose does this automatically)
- MySQL should have a named volume for data persistence
- WordPress should connect to MySQL using the service name

Start it, access WordPress in your browser, and set it up.

**Verify:** Stop and restart with `docker compose down` and `docker compose up` — is your WordPress data still there?
[Compose file](wordpress-mysql/docker-compose.yml)

<img width="862" height="342" alt="image" src="https://github.com/user-attachments/assets/62fc4796-144a-4a32-a799-af21f278982a" />
<img width="1850" height="961" alt="image" src="https://github.com/user-attachments/assets/9b3094de-b3e2-4237-ba9a-181b62fccb4e" />
<img width="1888" height="1016" alt="image" src="https://github.com/user-attachments/assets/c18dd864-6c39-4328-a2c0-625cf8cc4411" />
<img width="1917" height="971" alt="image" src="https://github.com/user-attachments/assets/9a14a9a4-88b6-4c62-9926-b0217398ddf3" />

- Yes Wordpress data is available there.

<img width="852" height="130" alt="image" src="https://github.com/user-attachments/assets/0fadc80f-2e25-4910-b446-3c7f450dd836" />
<img width="1592" height="898" alt="image" src="https://github.com/user-attachments/assets/92a02311-281c-48f4-92fd-399cdc2a1deb" />

---

### Task 4: Compose Commands
Practice and document these:
1. Start services in **detached mode**

```
docker compose up -d
```
<img width="906" height="118" alt="image" src="https://github.com/user-attachments/assets/d5c73d73-959a-4562-bc2c-8ee854aa58a0" />

2. View running services
```
docker compose ps
```
<img width="948" height="165" alt="image" src="https://github.com/user-attachments/assets/acf3e2ab-678d-4b35-b6c9-a069b5beb8f0" />

3. View **logs** of all services
```docker compose logs db && docker compose logs wordpress```

<img width="1000" height="702" alt="image" src="https://github.com/user-attachments/assets/19d5f251-c266-498c-b6b9-6af8e85588c0" />

5. View logs of a **specific** service

```docker compose logs db```

<img width="1902" height="307" alt="image" src="https://github.com/user-attachments/assets/ec7b2d22-04a3-4194-a52b-e52578274261" />

6. **Stop** services without removing
```docker compose stop```

<img width="947" height="106" alt="image" src="https://github.com/user-attachments/assets/70bc8196-04d4-47bf-8b7a-86fa3991e0d1" />

8. **Remove** everything (containers, networks)
```docker compose down```

<img width="947" height="116" alt="image" src="https://github.com/user-attachments/assets/d4aea21b-fcb7-4423-a42f-0c91c8382224" />

10. **Rebuild** images if you make a change
```docker compose up --build```

---

### Task 5: Environment Variables
1. Add environment variables directly in your `docker-compose.yml`
2. Create a `.env` file and reference variables from it in your compose file
3. Verify the variables are being picked up

---

## Hints
- Start: `docker compose up -d`
- Stop: `docker compose down`
- Logs: `docker compose logs -f`
- Compose creates a default network for all services automatically
- Service names in compose are the DNS names containers use to talk to each other

---

## Submission
1. Add your compose files and `day-33-compose.md` to `2026/day-33/`
2. Commit and push to your fork

---

## Learn in Public
Share your WordPress + MySQL running via Compose on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
