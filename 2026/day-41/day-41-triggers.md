# Day 41 – Triggers & Matrix Builds

## Task
Your pipeline runs on push. Today you learn **every way to trigger a workflow** and how to run jobs across multiple environments at once.

---

## Challenge Tasks

### Task 1: Trigger on Pull Request
1. Create `.github/workflows/pr-check.yml`
2. Trigger it only when a pull request is **opened or updated** against `main`
3. Add a step that prints: `PR check running for branch: <branch name>`
4. Create a new branch, push a commit, and open a PR
5. Watch the workflow run automatically

**Verify:** Does it show up on the PR page? - **Yes**

[pr-check.yml file](https://github.com/Amit5197/github-actions-practice/blob/main/.github/workflows/pr-check.yml)

- After creating pull request
  
<img width="1917" height="701" alt="image" src="https://github.com/user-attachments/assets/cab5b107-cc3d-411f-a357-ac8c5b5718c0" />

- After updating pull request

<img width="1481" height="512" alt="image" src="https://github.com/user-attachments/assets/959ec7d2-11f7-4cea-8fbb-d410d04843c2" />

---

### Task 2: Scheduled Trigger
1. Add a `schedule:` trigger to any workflow using cron syntax
2. Set it to run every day at midnight UTC - (`0 0 * * *`)
3. Write in your notes: What is the cron expression for every Monday at 9 AM?
 > 0 9 * * 1

[shedule.yml file](https://github.com/Amit5197/github-actions-practice/actions/workflows/schedule.yml)

---

### Task 3: Manual Trigger
1. Create `.github/workflows/manual.yml` with a `workflow_dispatch:` trigger
2. Add an **input** that asks for an `environment` name (staging/production)
3. Print the input value in a step
4. Go to the **Actions** tab → find the workflow → click **Run workflow**

**Verify:** Can you trigger it manually and see your input printed?

[Manual.yml file](https://github.com/Amit5197/github-actions-practice/blob/main/.github/workflows/manual.yml)

<img width="1913" height="725" alt="image" src="https://github.com/user-attachments/assets/71e61c14-9526-4de4-bbee-6aa14adcff75" />

---

### Task 4: Matrix Builds
Create `.github/workflows/matrix.yml` that:
1. Uses a matrix strategy to run the same job across:
   - Python versions: `3.10`, `3.11`, `3.12`
2. Each job installs Python and prints the version
3. Watch all 3 run in parallel

Then extend the matrix to also include 2 operating systems — how many total jobs run now?

<img width="1918" height="913" alt="image" src="https://github.com/user-attachments/assets/a54014b0-a8cf-453a-917d-a8c311561056" />

---

### Task 5: Exclude & Fail-Fast
1. In your matrix, **exclude** one specific combination (e.g., Python 3.10 on Windows)
- After adding exclude for python-3.10 on macos it skipped that job.
<img width="1918" height="913" alt="image" src="https://github.com/user-attachments/assets/e9c54d71-d8f9-4715-868a-95d450bab63e" />

2. Set `fail-fast: false` — trigger a failure in one job and observe what happens to the rest
 - `fail-fast: false`

<img width="1918" height="768" alt="image" src="https://github.com/user-attachments/assets/003a6aa9-5446-4b77-8459-7a706a80df93" />

3. Write in your notes: What does `fail-fast: true` (the default) do vs `false`?

- `fail-fast: true`

<img width="1895" height="786" alt="image" src="https://github.com/user-attachments/assets/615b9c4b-1c55-4cc3-8e07-931a5c12a44e" />

- Observation

- `fail-fast: false`):
     - In the workflow, a failure was triggered for Python 3.11 using exit 1. 
     - As shown in the screenshot,the jobs (`windows-latest, 3.11`) and (`ubuntu-latest, 3.11`) `failed`,but the other jobs continued running and completed successfully.
     - This shows that `fail-fast: false` allows all matrix jobs to run even if some fail.

  - `fail-fast: true (default)`: If one job fails, the remaining matrix jobs are cancelled.
  - `fail-fast: false`: If one job fails, the other jobs continue running until completion.

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
