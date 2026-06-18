# Day 45 – Docker Build & Push in GitHub Actions

## Task
Today you build a **complete CI/CD pipeline** — code pushed to GitHub automatically builds a Docker image and ships it to Docker Hub. No manual steps.

This is exactly what happens in real production pipelines.

---

## Challenge Tasks

### Task 1: Prepare
1. Use the app you Dockerized on Day 36 (or any simple Dockerfile)
2. Add the Dockerfile to your `github-actions-practice` repo (or create a minimal one)
3. Make sure `DOCKER_USERNAME` and `DOCKER_TOKEN` secrets are set from Day 44

<img width="1365" height="747" alt="image" src="https://github.com/user-attachments/assets/28ea14f8-82fc-4130-925c-1938f1d89b64" />

---

### Task 2: Build the Docker Image in CI
Create `.github/workflows/docker-publish.yml` that:
1. Triggers on push to `main`
2. Checks out the code
3. Builds the Docker image and tags it

**Verify:** Check the build step logs — does the image build successfully?

- Yes,image build successfully

<img width="1205" height="792" alt="image" src="https://github.com/user-attachments/assets/8d104cef-07b4-4f8a-9b4c-fa26dcd5e385" />

---

### Task 3: Push to Docker Hub
Add steps to:
1. Log in to Docker Hub using your secrets
2. Tag the image as `username/repo:latest` and also `username/repo:sha-<short-commit-hash>`
3. Push both tags

**Verify:** Go to Docker Hub — is your image there with both tags?

- Yes, both tags are in Dockerhub

<img width="1217" height="786" alt="image" src="https://github.com/user-attachments/assets/2a790130-3cec-4c45-9264-d14d9079d561" />

---

### Task 4: Only Push on Main
Add a condition so the push step only runs on the `main` branch — not on feature branches or PRs.

Test it: push to a feature branch and verify the image is built but NOT pushed.

<img width="1892" height="847" alt="image" src="https://github.com/user-attachments/assets/8059f94e-7a5b-47a0-a23b-b5996f04741e" />

- On the `Amit5197-patch-1` branch, the image was built and the push step was skipped.
  
<img width="1895" height="850" alt="image" src="https://github.com/user-attachments/assets/a0f7ed9f-d43d-4d43-96d5-297a51716d1d" />

---

### Task 5: Add a Status Badge
1. Get the badge URL for your `docker-publish` workflow from the Actions tab
2. Add it to your `README.md`
3. Push — the badge should show green

<img width="882" height="300" alt="image" src="https://github.com/user-attachments/assets/60e1e2fe-36d1-4715-852b-5025d026f3b4" />

---

### Task 6: Pull and Run It
1. On your local machine (or a cloud server), pull the image you just pushed
2. Run it
3. Confirm it works

Write in your notes: What is the full journey from `git push` to a running container?

(Dockerhub)(https://hub.docker.com/repository/docker/amit5197/webapp/general)

- Yes,its woking

<img width="1750" height="452" alt="image" src="https://github.com/user-attachments/assets/096e8490-3510-4568-ac1a-ca236a8fb8fe" />

<img width="1792" height="897" alt="image" src="https://github.com/user-attachments/assets/682d249c-d76d-410d-95a8-e1a6929033c5" />

1. git push – Code is pushed to GitHub.

2. GitHub Actions triggers – The CI/CD workflow starts and Copleted all task or jobs.

3. Checkout code: `uses: actions/checkout@v4`

4. Login to Docker Hub: `uses: docker/login-action@v3`

5. Build Docker image using the Dockerfile.
    - If code is pushed to main: Docker image is built, tagged, and pushed to Docker Hub.
    - If pushed to other branches or PRs:Docker image is only built for testing. It is not pushed to Docker Hub.

6. Run the container: `docker run -d --name web -p 80:80 amit5197/webapp:latestimage_ID`

---

Happy Learning!
**TrainWithShubham**
