# Day 33 – Docker Compose: Multi-Container Basics

## Task 1: Install & Verify
1. Check if Docker Compose is available on your machine
2. Verify the version

   ![snapshot](images/1.png)
   
---

## Task 2: Your First Compose File
1. Create a folder `compose-basics`
2. Write a `docker-compose.yml` that runs a single **Nginx** container with port mapping
3. Start it with `docker compose up`
4. Access it in your browser
5. Stop it with `docker compose down`

   [Docker Compose File](compose-basics/docker-compose.yml)
   
   ![snapshot](images/2.png)
   
---

## Task 3: Two-Container Setup
Write a `docker-compose.yml` that runs:
- A **WordPress** container
- A **MySQL** container

They should:
- Be on the same network (Compose does this automatically)
- MySQL should have a named volume for data persistence
- WordPress should connect to MySQL using the service name

   [Docker Compose File](Two-Container/docker-compose.yml)
   
Start it, access WordPress in your browser, and set it up.

   ![snapshot](images/3-a.png)
   
   ![snapshot](images/before.png)
   
**Verify:** Stop and restart with `docker compose down` and `docker compose up` — is your WordPress data still there?

   ![snapshot](images/3-b.png)
   
   ![snapshot](images/after.png)
   
---

## Task 4: Compose Commands
Practice and document these:
1. Start services in **detached mode**

   ![snapshot](images/4-a.png)
   
2. View running services

   ![snapshot](images/4-b.png)
   
3. View **logs** of all services

   ![snapshot](images/4-c.png)
   
4. View logs of a **specific** service

   ![snapshot](images/4-d.png)
   
5. **Stop** services without removing

   ![snapshot](images/4-e.png)
   
6. **Remove** everything (containers, networks)

   ![snapshot](images/4-f.png)
   
7. **Rebuild** images if you make a change

   ![snapshot](images/4-g.png)

---

## Task 5: Environment Variables
1. Add environment variables directly in your `docker-compose.yml`
2. Create a `.env` file and reference variables from it in your compose file
3. Verify the variables are being picked up

   [All File](Two-Container)
   
   ![snapshot](images/5-g.png)
   
---
