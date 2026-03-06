# Day 42 – Runners: GitHub-Hosted & Self-Hosted

## Task 1: GitHub-Hosted Runners
1. Create a workflow with 3 jobs, each on a different OS:
   - `ubuntu-latest`
   - `windows-latest`
   - `macos-latest`
2. In each job, print:
   - The OS name
   - The runner's hostname
   - The current user running the job
3. Watch all 3 run in parallel

   [GitHub-Hosted Runners demo](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/0ad39cbcad0ba600223ccd6b87d87cfb7da699ef/.github/workflows/github-hosted.yml)

   ![snapshot](images/1.png)

Write in your notes: What is a GitHub-hosted runner? Who manages it?
   * A GitHub‑hosted runner is a temporary virtual machine (VM) or container that 
     GitHub provides to execute your workflow jobs.
   * It spins up fresh for each job, and comes preinstalled with common tools, languages.
   * After job completion runner is discarded.
   * GitHub manages it entirely on Microsoft Azure Infrastructure as GitHub is 
     owned by Microsoft.

---

## Task 2: Explore What's Pre-installed
1. On the `ubuntu-latest` runner, run a step that prints:
   - Docker version
   - Python version
   - Node version
   - Git version

   [Pre-installed yaml file](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/0ac4b4d1f36066fc26c6367f38d61d0d14d28ddc/.github/workflows/pre-installed.yml)

   ![snapshot](images/2.png)

2. Look up the GitHub docs for the full list of pre-installed software on `ubuntu-latest`

Write in your notes: Why does it matter that runners come with tools pre-installed?
   * Certain tools & languages needs to be pre-installed for smooth & fast workflow run.
     For example, code checkout needs git, building needs docker. 
     It saves writing long setup steps & installing them.

---

## Task 3: Set Up a Self-Hosted Runner
1. Go to your GitHub repo → Settings → Actions → Runners → **New self-hosted runner**
2. Choose Linux as the OS
3. Follow the instructions to download and configure the runner on:
   - Your local machine, OR
   - A cloud VM (EC2, Utho, or any VPS)
4. Start the runner — verify it shows as **Idle** in GitHub

**Verify:** Your runner appears in the Runners list with a green dot.

   ![snapshot](images/3.png)

---

## Task 4: Use Your Self-Hosted Runner
1. Create `.github/workflows/self-hosted.yml`
2. Set `runs-on: self-hosted`
3. Add steps that:
   - Print the hostname of the machine (it should be YOUR machine/VM)
   - Print the working directory
   - Create a file and verify it exists on your machine after the run
4. Trigger it and watch it run on your own hardware

**Verify:** Check your machine — is the file there? - **YES**

   [self-hosted yml file](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/main/.github/workflows/self-hosted.yml)

   ![snapshot](images/4-a.png)

   ![snapshot](images/4-b.png)

---

## Task 5: Labels
1. Add a **label** to your self-hosted runner (e.g., `my-linux-runner`)
2. Update your workflow to use `runs-on: [self-hosted, my-linux-runner]`
3. Trigger it — does it still pick up the job? - **YES**

Write in your notes: Why are labels useful when you have multiple self-hosted runners?
  * When you have multiple self‑hosted runners, labels let you choose exactly 
    which runner should execute a job.

---

## Task 6: GitHub-Hosted vs Self-Hosted
Fill this in your notes:

| | GitHub-Hosted | Self-Hosted |
|---|---|---|
| Who manages it? | GitHub | We manage it |
| Cost | Free 2000 mins (per month, public repos unlimited) | As per our own infrastructure usage |
| Pre-installed tools | Yes (common languages, build tools, Docker, etc.) | No (we install and maintain ourselves) |
| Good for | Small independent jobs, quick CI/CD setup | Production workloads, specialized environments |
| Security concern | Controlled by GitHub —so must be handled carefully | Our responsibility — we must secure the machine, patch OS/tools, and protect secrets |

---


