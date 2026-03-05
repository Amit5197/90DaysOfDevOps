# Day 40 – Your First GitHub Actions Workflow

## Task 1: Set Up
1. Create a new **public** GitHub repository called `github-actions-practice`
2. Clone it locally
3. Create the folder structure: `.github/workflows/`

   [Link to github-actions-practice](https://github.com/Afroz-J-Shaikh/github-actions-practice/tree/main/.github/workflows)

---

## Task 2: Hello Workflow
Create `.github/workflows/hello.yml` with a workflow that:
1. Triggers on every `push`
2. Has one job called `greet`
3. Runs on `ubuntu-latest`
4. Has two steps:
   - Step 1: Check out the code using `actions/checkout`
   - Step 2: Print `Hello from GitHub Actions!`

Push it. Go to the **Actions** tab on GitHub and watch it run.

**Verify:** Is it green? Click into the job and read every step.

   ![snapshot](images/2.png)

---

## Task 3: Understand the Anatomy
Look at your workflow file and write in your notes what each key does:
- `on:` 
    - Defines the events(push,pull_request) that 
      trigger the workflow to run.
- `jobs:` 
    - A collection of one or more jobs. Runs parallely by 
      default.
- `runs-on:` 
    - Github's or selfhosted environment that provides 
      container or virtual machine for a job to execute.
- `steps:` 
    - A ordered list of tasks within a job.
- `uses:` 
    - Refers to pre-built GitHub Actions or reusable 
      workflows.
- `run:` 
    - Executes a command or a script in the runner's shell.
- `name:` 
    - A description for workflow, jobs/steps.

---

## Task 4: Add More Steps
Update `hello.yml` to also:
1. Print the current date and time
2. Print the name of the branch that triggered the run (hint: GitHub provides this as a variable)
3. List the files in the repo
4. Print the runner's operating system

   ![snapshot](images/4.png)

---

## Task 5: Break It On Purpose
1. Add a step that runs a command that will **fail** (e.g., `exit 1` or a misspelled command)
2. Push and observe what happens in the Actions tab
3. Fix it and push again

   *`"` Error
   ![snapshot](images/4.png)

   *After solving error
   ![snapshot](images/4.png)

---
