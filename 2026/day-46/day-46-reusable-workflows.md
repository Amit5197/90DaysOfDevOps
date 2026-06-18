# Day 46 – Reusable Workflows & Composite Actions

## Task
You've been writing workflows from scratch every time. In the real world, teams **don't repeat themselves** — they create reusable workflows that any repo can call like a function. Today you learn `workflow_call` and composite actions.

---

## Challenge Tasks

### Task 1: Understand `workflow_call`
Before writing any code, research and answer in your notes:
1. What is a **reusable workflow**?
- A `reusable workflow` is a GitHub Actions workflow that can be called from another workflow, allowing you to REUSE the same automation logic across multiple workflows.

2. What is the `workflow_call` trigger?
- `workflow_call` is a GitHub Actions trigger that allows a workflow to be executed by another workflow instead of events like push or pull_request.

3. How is calling a reusable workflow different from using a regular action (`uses:`)?
- `Reusable Workflow` is used at the workflow level and written inside `jobs.<job_id>.uses.` It is used to reuse a complete workflow with jobs and steps,for example calling a build pipeline.
- `Regular Action` is used at the `step level` and written inside `steps.uses`. It is used to reuse a single task,for example checking out code or running Docker.

4. Where must a reusable workflow file live?
- It must be inside the folder: `.github/workflows/`

---

### Task 2: Create Your First Reusable Workflow
Create `.github/workflows/reusable-build.yml`:
1. Set the trigger to `workflow_call`
2. Add an `inputs:` section with:
   - `app_name` (string, required)
   - `environment` (string, required, default: `staging`)
3. Add a `secrets:` section with:
   - `docker_token` (required)
4. Create a job that:
   - Checks out the code
   - Prints `Building <app_name> for <environment>`
   - Prints `Docker token is set: true` (never print the actual secret)

**Verify:** This file alone won't run — it needs a caller. That's next.

<img width="1457" height="597" alt="image" src="https://github.com/user-attachments/assets/5a9f4c81-0257-4ee9-8441-73935b0977fe" />

(https://github.com/Amit5197/github-actions-practice/actions/workflows/Reusable-build.yml)

---

### Task 3: Create a Caller Workflow
Create `.github/workflows/call-build.yml`:
1. Trigger on push to `main`
2. Add a job that uses your reusable workflow:
   ```yaml
   jobs:
     build:
       uses: ./.github/workflows/reusable-build.yml
       with:
         app_name: "my-web-app"
         environment: "production"
       secrets:
         docker_token: ${{ secrets.DOCKER_TOKEN }}
   ```
3. Push to `main` and watch it run

**Verify:** In the Actions tab, do you see the caller triggering the reusable workflow? Click into the job — can you see the inputs printed?

<img width="1857" height="572" alt="image" src="https://github.com/user-attachments/assets/cfa22b70-bf0b-4f55-9e36-91bbd4ff52a6" />

<img width="1872" height="891" alt="image" src="https://github.com/user-attachments/assets/bb96eef4-c79f-408b-9d44-bbda3f58beb9" />

---

### Task 4: Add Outputs to the Reusable Workflow
Extend `reusable-build.yml`:
1. Add an `outputs:` section that exposes a `build_version` value
2. Inside the job, generate a version string (e.g., `v1.0-<short-sha>`) and set it as output
3. In your caller workflow, add a second job that:
   - Depends on the build job (`needs:`)
   - Reads and prints the `build_version` output

**Verify:** Does the second job print the version from the reusable workflow?

---

### Task 5: Create a Composite Action
Create a **custom composite action** in your repo at `.github/actions/setup-and-greet/action.yml`:
1. Define inputs: `name` and `language` (default: `en`)
2. Add steps that:
   - Print a greeting in the specified language
   - Print the current date and runner OS
   - Set an output called `greeted` with value `true`
3. Use the composite action in a new workflow with `uses: ./.github/actions/setup-and-greet`

**Verify:** Does your custom action run and print the greeting?

---

### Task 6: Reusable Workflow vs Composite Action
Fill this in your notes:

| | Reusable Workflow | Composite Action |
|---|---|---|
| Triggered by | `workflow_call` | `uses:` in a step |
| Can contain jobs? | ? | ? |
| Can contain multiple steps? | ? | ? |
| Lives where? | ? | ? |
| Can accept secrets directly? | ? | ? |
| Best for | ? | ? |

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
