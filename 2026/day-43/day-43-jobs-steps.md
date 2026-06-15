# Day 43 – Jobs, Steps, Env Vars & Conditionals

## Task
Today you learn how to **control the flow** of your pipeline — multi-job workflows, passing data between jobs, environment variables, and running steps only when certain conditions are met.

---

## Challenge Tasks

### Task 1: Multi-Job Workflow
Create `.github/workflows/multi-job.yml` with 3 jobs:
- `build` — prints "Building the app"
- `test` — prints "Running tests"
- `deploy` — prints "Deploying"

Make `test` run only **after** `build` succeeds.
Make `deploy` run only **after** `test` succeeds.

**Verify:** Check the workflow graph in the Actions tab — does it show the dependency chain?

- Yes It show the dependency chain
  
<img width="1906" height="777" alt="image" src="https://github.com/user-attachments/assets/6e604607-1a38-40cc-9c2d-d23a4b03894e" />

- `needs` : tells gitHub actions which job must finish before another job can start.

[ Build ] ──► [ Test ] ──► [ Deploy ]

---

### Task 2: Environment Variables
In a new workflow, use environment variables at 3 levels:
1. **Workflow level** — `APP_NAME: myapp`
2. **Job level** — `ENVIRONMENT: staging`
3. **Step level** — `VERSION: 1.0.0`

Print all three in a single step and verify each is accessible.

Then use a **GitHub context variable** — print the commit SHA and the actor (who triggered the run).

<img width="1897" height="797" alt="image" src="https://github.com/user-attachments/assets/a9269024-b45f-4830-8996-fa1952cf7f3d" />

---

### Task 3: Job Outputs
1. Create a job that **sets an output** — e.g., today's date as a string
2. Create a second job that **reads that output** and prints it
3. Pass the value using `outputs:` and `needs.<job>.outputs.<name>`

<img width="1911" height="570" alt="image" src="https://github.com/user-attachments/assets/df8c8557-59ad-41fc-97b0-508d204cd0b6" />
<img width="1907" height="762" alt="image" src="https://github.com/user-attachments/assets/40bc008b-4b71-44fb-85ee-7c9acdcf666d" />

Write in your notes: 

**Why would you pass outputs between jobs?**

- Each job runs separately, so Job 2 cannot see what Job 1 created.
- Outputs are used to pass that result from Job 1 to Job 2.
- Example:
  
- Job 1 – Build Docker image
    - This job builds the image and creates a tag for example:myapp:1.0.0

- Job 2 – Push image to registry
    - This job must know which image tag was created so it can push the correct image.

- Job 3 – Deploy the app
    - The deployment job also needs the same tag myapp:1.0.0 to deploy that exact image.

- Why pass outputs?
    - The tag created in Job 1 is passed as an output so the other jobs know exactly which Docker image to use.

---

### Task 4: Conditionals
In a workflow, add:
1. A step that only runs when the branch is `main`
2. A step that only runs when the previous step **failed**
3. A job that only runs on **push** events, not on pull requests
4. A step with `continue-on-error: true` — what does this do?

<img width="1900" height="717" alt="image" src="https://github.com/user-attachments/assets/4105f830-e033-45e4-bf5a-2873ce9d7fc8" />

<img width="1895" height="747" alt="image" src="https://github.com/user-attachments/assets/c41f4fc0-9361-4b70-b871-46076cae130a" />

<img width="1875" height="712" alt="image" src="https://github.com/user-attachments/assets/6e3e526e-5437-47ff-b08f-2881fc1509d4" />

---

### Task 5: Putting It Together
Create `.github/workflows/smart-pipeline.yml` that:
1. Triggers on push to any branch
2. Has a `lint` job and a `test` job running in parallel
3. Has a `summary` job that runs after both, prints whether it's a `main` branch push or a feature branch push, and prints the commit message

---

## Hints
- Job dependency: `needs: [job-name]`
- Set output: `echo "date=$(date)" >> $GITHUB_OUTPUT`
- Read output: `${{ needs.job-name.outputs.date }}`
- Conditionals: `if: github.ref == 'refs/heads/main'`
- Commit message: `${{ github.event.commits[0].message }}`

---

## Documentation
Create `day-43-jobs-steps.md` with:
- Key workflow snippets
- What `needs:` and `outputs:` do in your own words

---

## Submission
1. Add `day-43-jobs-steps.md` to `2026/day-43/`
2. Commit and push to your fork

---

## Learn in Public
Share the dependency chain diagram from your multi-job workflow on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
