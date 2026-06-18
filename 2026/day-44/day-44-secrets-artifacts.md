# Day 44 – Secrets, Artifacts & Running Real Tests in CI

## Task
Today your pipeline starts doing **real work** — storing sensitive values securely, saving build outputs, and running actual tests from your previous days.

---

## Challenge Tasks

### Task 1: GitHub Secrets
1. Go to your repo → Settings → Secrets and Variables → Actions
2. Create a secret called `MY_SECRET_MESSAGE`
3. Create a workflow that reads it and prints: `The secret is set: true` (never print the actual value)
4. Try to print `${{ secrets.MY_SECRET_MESSAGE }}` directly — what does GitHub show?

Write in your notes: Why should you never print secrets in CI logs?

<img width="1907" height="580" alt="image" src="https://github.com/user-attachments/assets/2c6c1914-abb6-44b6-8aca-99fc0d4d5c60" />
<img width="1067" height="312" alt="image" src="https://github.com/user-attachments/assets/afce415a-b6bb-4a66-b275-08e07facfc2a" />

GitHub automatically replaces secrets with ***

<img width="1912" height="772" alt="image" src="https://github.com/user-attachments/assets/fd76d95b-5cba-4bc2-b8a3-6d81dd0e8226" />

---

### Task 2: Use Secrets as Environment Variables
1. Pass a secret to a step as an environment variable
2. Use it in a shell command without ever hardcoding it
3. Add `DOCKER_USERNAME` and `DOCKER_TOKEN` as secrets (you'll need these on Day 45)

<img width="1876" height="787" alt="image" src="https://github.com/user-attachments/assets/e836693c-725f-483f-acd8-97e25512e956" />

<img width="1402" height="422" alt="image" src="https://github.com/user-attachments/assets/47be4a0e-4be0-4b8b-8e8c-a1f15ef07857" />

---

### Task 3: Upload Artifacts
1. Create a step that generates a file — e.g., a test report or a log file
2. Use `actions/upload-artifact` to save it
3. After the workflow runs, download the artifact from the Actions tab

**Verify:** Can you see and download it from GitHub?

- Yes, downloaded it.

<img width="1912" height="692" alt="image" src="https://github.com/user-attachments/assets/807f5211-0423-4b06-a3e7-cbc60b8fd322" />

---

### Task 4: Download Artifacts Between Jobs
1. Job 1: generate a file and upload it as an artifact
2. Job 2: download the artifact from Job 1 and use it (print its contents)

Write in your notes: When would you use artifacts in a real pipeline?
Artifacts are used to store and transfer files generated during pipelines.
Test reports,

<img width="1901" height="552" alt="image" src="https://github.com/user-attachments/assets/92493f49-64d1-49b5-827b-dbd44c99d1e0" />

<img width="1887" height="832" alt="image" src="https://github.com/user-attachments/assets/42da654a-66df-494d-9031-e2f251b24ca1" />

---

### Task 5: Run Real Tests in CI
Take any script from your earlier days (Python or Shell) and run it in CI:
1. Add your script to the `github-actions-practice` repo
2. Write a workflow that:
   - Checks out the code
   - Installs any dependencies needed
   - Runs the script
   - Fails the pipeline if the script exits with a non-zero code
3. Intentionally break the script — verify the pipeline goes red
4. Fix it — verify it goes green again

<img width="1917" height="817" alt="image" src="https://github.com/user-attachments/assets/1a753e52-4143-41d7-89ef-82e87867c056" />

<img width="1896" height="547" alt="image" src="https://github.com/user-attachments/assets/08e26eab-38b9-48c5-94dc-6af6e9992de3" />

<img width="1917" height="907" alt="image" src="https://github.com/user-attachments/assets/5d0f232f-a701-4bca-bf64-311592495e1a" />

---

### Task 6: Caching
1. Add `actions/cache` to a workflow that installs dependencies
2. Run it twice — observe the time difference
3. Write in your notes: What is being cached and where is it stored?

- What is cache: Python packages downloaded by pip from requirements.txt.
- Where it’s stored: On GitHub Actions servers, restored to the runner at ~/.cache/pip.

<img width="1480" height="557" alt="image" src="https://github.com/user-attachments/assets/6fcb6b1b-40fa-4a0b-a8d5-107a82667fa1" />

---

**What I lerned from Secret Management**

- **Store sensitive data (like API keys, tokens, passwords) in GitHub Actions Secrets, not in code.**
- **They are encrypted, injected at runtime, and never exposed in logs.**

**The Secret Management Lifecycle**
- Encryption at Rest: When you save a token (like DOCKER_TOKEN) in GitHub's settings, GitHub immediately encrypts it using strong asymmetric encryption before it ever hits their databases.

- Injected on Demand: The secret is only decrypted and injected into the runner environment at the exact moment a specific job or step requests it via the ${{ secrets.YOUR_SECRET }} syntax.

- Automatic Log Masking: If a script accidentally tries to print out or echo that secret to the standard output, GitHub Actions automatically intercepts it and replaces the value with in the build logs.

---

Happy Learning!
**TrainWithShubham**
