# Day 42 – Runners: GitHub-Hosted & Self-Hosted

## Task
Every job needs a machine to run on. Today you understand **runners** — GitHub's hosted ones and how to set up your own self-hosted runner on a real server.

---

## Challenge Tasks

### Task 1: GitHub-Hosted Runners
1. Create a workflow with 3 jobs, each on a different OS:
   - `ubuntu-latest`
   - `windows-latest`
   - `macos-latest`
2. In each job, print:
   - The OS name
   - The runner's hostname
   - The current user running the job
3. Watch all 3 run in parallel

<img width="1907" height="837" alt="image" src="https://github.com/user-attachments/assets/1b049c19-2308-4c12-86f8-7e0e92b9265a" />

<img width="1911" height="682" alt="image" src="https://github.com/user-attachments/assets/b9e91a5b-46a3-4491-9ecb-90329a378e12" />

<img width="1902" height="697" alt="image" src="https://github.com/user-attachments/assets/4108f894-be6a-4864-a187-6c309fba02e4" />

<img width="1897" height="891" alt="image" src="https://github.com/user-attachments/assets/3660f4c0-6f2f-4093-85ff-59da38782d6f" />


**What is a GitHub-hosted runner? Who manages it?**

    What is a GitHub-hosted runner? Who manages it?

    - `Github-hosted` runner is a temporary virtual machine provided by GitHub that runs GitHub Actions workflows.

    - `GitHub-hosted` runners are managed by GitHub on Microsoft Azure infrastructure.
    
    - Responsible for:
        - Creating the virtual machine
        - Installing software
        -  Maintaining security
        - Deleting the machine after the job completes.
        
---

### Task 2: Explore What's Pre-installed
1. On the `ubuntu-latest` runner, run a step that prints:
   - Docker version
   - Python version
   - Node version
   - Git version
2. Look up the GitHub docs for the full list of pre-installed software on `ubuntu-latest`

<img width="1918" height="812" alt="image" src="https://github.com/user-attachments/assets/e48442bf-12cd-4028-9854-bb156f1da3a2" />

**Write in your notes: Why does it matter that runners come with tools pre-installed?**

- It matters because pre-installed tools make workflows faster and easier to configure. Developers can run builds and tests immediately without installing common tools like Docker, Python, Node.js, and Git, while GitHub maintains and updates the environment.

---

### Task 3: Set Up a Self-Hosted Runner
1. Go to your GitHub repo → Settings → Actions → Runners → **New self-hosted runner**
2. Choose Linux as the OS
3. Follow the instructions to download and configure the runner on:
   - Your local machine, OR
   - A cloud VM (EC2, Utho, or any VPS)
4. Start the runner — verify it shows as **Idle** in GitHub

**Verify:** Your runner appears in the Runners list with a green dot.

<img width="1567" height="545" alt="image" src="https://github.com/user-attachments/assets/00fc5a6c-4321-422f-a0b4-e478cd1745c6" />

---

### Task 4: Use Your Self-Hosted Runner
1. Create `.github/workflows/self-hosted.yml`
2. Set `runs-on: self-hosted`
3. Add steps that:
   - Print the hostname of the machine (it should be YOUR machine/VM)
   - Print the working directory
   - Create a file and verify it exists on your machine after the run
4. Trigger it and watch it run on your own hardware

**Verify:** Check your machine — is the file there?

---

### Task 5: Labels
1. Add a **label** to your self-hosted runner (e.g., `my-linux-runner`)
2. Update your workflow to use `runs-on: [self-hosted, my-linux-runner]`
3. Trigger it — does it still pick up the job? - **Yes**

Write in your notes: Why are labels useful when you have multiple self-hosted runners?
- When you have multiple self‑hosted runners, labels let you choose exactly which runner should execute a job.

---

### Task 6: GitHub-Hosted vs Self-Hosted
Fill this in your notes:

| | GitHub-Hosted | Self-Hosted |
|---|---|---|
| Who manages it? | GitHub | We manage it |
| Cost | Free 2000 mins (per month, public repos unlimited) | As per our own infrastructure usage |
| Pre-installed tools | Yes (common languages, build tools, Docker, etc.) | No (we install and maintain ourselves) |
| Good for | Small independent jobs, quick CI/CD setup | Production workloads, specialized environments |
| Security concern | Controlled by GitHub —so must be handled carefully | Our responsibility — we must secure the machine, patch OS/tools, and protect secrets |

---

**TrainWithShubham**
