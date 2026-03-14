# Day 47 – Advanced Triggers: PR Events, Cron Schedules & Event-Driven Pipelines

## Task 1: Pull Request Event Types
Create `.github/workflows/pr-lifecycle.yml` that triggers on `pull_request` with **specific activity types**:
1. Trigger on: `opened`, `synchronize`, `reopened`, `closed`
2. Add steps that:
   - Print which event type fired: `${{ github.event.action }}`
   - Print the PR title: `${{ github.event.pull_request.title }}`
   - Print the PR author: `${{ github.event.pull_request.user.login }}`
   - Print the source branch and target branch
3. Add a conditional step that only runs when the PR is **merged** (closed + merged = true)

   [PR lifecycle yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/9d570bac7505da2199e3b1a0de07256dab600a0d/.github/workflows/pr-lifecycle.yml)

Test it: create a PR, push an update to it, then merge it. Watch the workflow fire each time with a different event type.

   ### Opened

   ![snapshot](images/open.png)

   ### Synchronized

   ![snapshot](images/synch.png)

   ### Reopened

   ![snapshot](images/reopen.png)

   ### Merged

   ![snapshot](images/merged.png)

   ### Closed

   ![snapshot](images/closed.png)

---

## Task 2: PR Validation Workflow
Create `.github/workflows/pr-checks.yml` — a real-world PR gate:
1. Trigger on `pull_request` to `main`
2. Add a job `file-size-check` that:
   - Checks out the code
   - Fails if any file in the PR is larger than 1 MB
3. Add a job `branch-name-check` that:
   - Reads the branch name from `${{ github.head_ref }}`
   - Fails if it doesn't follow the pattern `feature/*`, `fix/*`, or `docs/*`
4. Add a job `pr-body-check` that:
   - Reads the PR body: `${{ github.event.pull_request.body }}`
   - Warns (but doesn't fail) if the PR description is empty

**Verify:** Open a PR from a badly named branch — does the check fail?

   [pr validation yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/5858a404ce743a2fb7716a6d3962beb7d3a81619/.github/workflows/pr-checks.yml)

   ### File size check
     * Valid
      
        ![snapshot](images/within-limit.png)

     * Invalid

        ![snapshot](images/limit-exceed.png)

   ### Branch name check
     * Valid
      
        ![snapshot](images/branch-valid.png)

     * Invalid
     
        ![snapshot](images/branch-invalid.png)

   ### PR body check
     * Valid
      
        ![snapshot](images/description-valid.png)

     * Invalid
     
        ![snapshot](images/description.png)

---

## Task 3: Scheduled Workflows (Cron Deep Dive)
Create `.github/workflows/scheduled-tasks.yml`:
1. Add a `schedule` trigger with cron: `'30 2 * * 1'` (every Monday at 2:30 AM UTC)
2. Add **another** cron entry: `'0 */6 * * *'` (every 6 hours)
3. In the job, print which schedule triggered using `${{ github.event.schedule }}`
4. Add a step that acts as a **health check** — curl a URL and check the response code

Write in your notes:
- The cron expression for: every weekday at 9 AM IST
   * `30 3 * * 1-5` (9AM IST is 3:30 UTC- github actions uses UTC time)
- The cron expression for: first day of every month at midnight
   * `0 0 1 * *`
- Why GitHub says scheduled workflows may be delayed or skipped on inactive repos
   * Every day thousands of workflows are triggered, so if a repository is inactive
     for more than 60 days github disables scheduled workflows, to manage their global compute resources and prevent wasting power on projects that aren't being actively maintained.
     

**Important:** Also add `workflow_dispatch` so you can test it manually without waiting for the schedule.

   [schedule workflow yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/d78025f65a5d3a70bbb9d6c55984fcdb03cc07d3/.github/workflows/scheduled-tasks.yml)

   ### using workflow_dispatch(will add on scheduled once it runs)

   ![snapshot](images/schedule.png)

---

## Task 4: Path & Branch Filters
Create `.github/workflows/smart-triggers.yml`:
1. Trigger on push but **only** when files in `src/` or `app/` change:
   ```yaml
   on:
     push:
       paths:
         - 'src/**'
         - 'app/**'
   ```

      [smart triggers yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/778aebbc46502f4282a2151d0e4001314a311e46/.github/workflows/smart-triggers.yml)

      ![snapshot](images/paths.png)


2. Add `paths-ignore` in a second workflow that skips runs when only docs change:
   ```yaml
   paths-ignore:
     - '*.md'
     - 'docs/**'
   ```
3. Add branch filters to only trigger on `main` and `release/*` branches
4. Test it: push a change to a `.md` file — does the workflow skip?
   * Yes it skips when pushed changes to .md or docs.
   * Below it shows it rab when pushed to github workflow

      [smart triggers 2 yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/6e555d014b964ac0a229cbbba8822b3db7bd32fe/.github/workflows/smart-triggers2.yml)

      ![snapshot](images/paths-ignore.png)

Write in your notes: When would you use `paths` vs `paths-ignore`?
   * `Paths` : When I want to run piepline only when code added to project src files.
   * `Paths-ignore` : When pipeline is set on push, but it should not run when added to
                      .ignore files or .md files.

---

## Task 5: `workflow_run` — Chain Workflows Together
Create two workflows:
1. `.github/workflows/tests.yml` — runs tests on every push
2. `.github/workflows/deploy-after-tests.yml` — triggers **only after** `tests.yml` completes successfully:
   ```yaml
   on:
     workflow_run:
       workflows: ["Run Tests"]
       types: [completed]
   ```
3. In the deploy workflow, add a conditional:
   - Only proceed if the triggering workflow **succeeded** (`${{ github.event.workflow_run.conclusion == 'success' }}`)
   - Print a warning and exit if it failed

**Verify:** Push a commit — does the test workflow run first, then trigger the deploy workflow? - **YES**

   [workflow_run yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/39b0618303bac5be98ef1db8bd67cf4d1b41ab51/.github/workflows/deploy-after-tests.yml)

   * Test success

   ![snapshot](images/test-deploy.png)

   ![snapshot](images/pass.png)

   * Test failure   

   ![snapshot](images/deploy-test-2.png)

   ![snapshot](images/fail.png)

---

## Task 6: `repository_dispatch` — External Event Triggers
1. Create `.github/workflows/external-trigger.yml` with trigger `repository_dispatch`
2. Set it to respond to event type: `deploy-request`
3. Print the client payload: `${{ github.event.client_payload.environment }}`
4. Trigger it using `curl` or `gh`:
   ```bash
   gh api repos/Afroz-J-Shaikh/github-actions-practice/dispatches \
   --method POST \
   --input - \
   -H "Accept: application/vnd.github+json" <<'EOF'
   {
   "event_type": "deploy-request",
   "client_payload": {
      "environment": "production"
   }
   }
EOF
   ```

   ![snapshot](images/external.png)

   ![snapshot](images/command.png)

   [repository dispatch yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/3558dca25d898413b2115d5fb8f341f603367050/.github/workflows/external-trigger.yml)

Write in your notes: When would an external system (like a Slack bot or monitoring tool) trigger a pipeline?

   * An external system would trigger a pipeline when an event outside GitHub needs 
     a workflow to run, such as:
       - Monitoring system detected health issue, needs some workflow run
       - Infrastructure-as-Code (IaC) updates: A change in your cloud provider 
         (like an AWS S3 bucket update or an Azure alert) triggers a configuration sync workflow.

---

## Explanation `workflow_run` vs `workflow_call`

| Workflow RUN | Workflow Call |
|--------------|---------------|
| An event that gets triggered when a workflow completes. | Enables one workflow to use another reusable “callable” workflow. |
| Chaining workflows based on the completion of a prior workflow. | Reusing the same workflow logic in multiple places.|
| Defined at the top level of a YAML file with the on: keyword. | Referenced inside a job using the uses keyword |
| Does not share secrets or variables automatically. | Can share secrets and inputs directly from the caller.|
| Runs as a separate workflow run in the Actions tab. | Appears as nested jobs inside the caller's workflow run.|
| Use workflow_call when you want to standardize logic (like a standard Docker build) across your own internal branches. | Use workflow_run when you need to protect your secrets while still processing data from external/untrusted contributors. |



