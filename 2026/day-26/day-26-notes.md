# Day 26 – GitHub CLI: Manage GitHub from Your Terminal

## Task

Every time you switch to the browser to create a PR, check an issue, or manage a repo — you lose context. The **GitHub CLI (`gh`)** lets you do all of that without leaving your terminal. For DevOps engineers, this is essential — especially when you start automating workflows, scripting PR reviews, and managing repos at scale.

## Challenge Tasks

### Task 1: Install and Authenticate
1. Install the GitHub CLI on your machine
2. Authenticate with your GitHub account
3. Verify you're logged in and check which account is active
<img width="1141" height="313" alt="image" src="https://github.com/user-attachments/assets/4cf0acc1-cb74-4532-bb79-73a5eb1a9a7e" />
<img width="916" height="535" alt="image" src="https://github.com/user-attachments/assets/d3e3b2a1-75ae-458d-ae34-1dc6a7cf4132" />

4. Answer in your notes: What authentication methods does `gh` support?
+ Browser-based OAuth
+ Personal Access Token (PAT)
+ SSH Key-based

---

### Task 2: Working with Repositories
1. Create a **new GitHub repo** directly from the terminal — make it public with a README
<img width="1156" height="417" alt="image" src="https://github.com/user-attachments/assets/56c5e27c-48cc-454f-bbd1-9c3efe1d274e" />

2. Clone a repo using `gh` instead of `git clone`
<img width="882" height="200" alt="image" src="https://github.com/user-attachments/assets/815da254-22e3-4049-9035-447a5e0619d2" />

3. View details of one of your repos from the terminal
<img width="926" height="280" alt="image" src="https://github.com/user-attachments/assets/e5dcaf60-ae9d-42cd-ab69-625138882928" />

4. List all your repositories
<img width="1070" height="476" alt="image" src="https://github.com/user-attachments/assets/eb04cc4b-d371-4017-a4a0-8336624a0377" />

5. Open a repo in your browser directly from the terminal
<img width="862" height="62" alt="image" src="https://github.com/user-attachments/assets/e2f505c3-9a4d-4ae1-a770-e2e91d019f68" />
<img width="1282" height="677" alt="image" src="https://github.com/user-attachments/assets/85fff7a4-da44-46a4-be87-312bb962f81d" />

6. Delete the test repo you created (be careful!)
<img width="932" height="418" alt="image" src="https://github.com/user-attachments/assets/2e2affcb-e7c7-4afe-8b42-44d81c2541ed" />

---

### Task 3: Issues
1. Create an issue on one of your repos from the terminal — give it a title, body, and a label
2. List all open issues on that repo
3. View a specific issue by its number
4. Close an issue from the terminal
5. Answer in your notes: How could you use `gh issue` in a script or automation?

---

### Task 4: Pull Requests
1. Create a branch, make a change, push it, and create a **pull request** entirely from the terminal
2. List all open PRs on a repo
3. View the details of your PR — check its status, reviewers, and checks
4. Merge your PR from the terminal
5. Answer in your notes:
   - What merge methods does `gh pr merge` support?
   - How would you review someone else's PR using `gh`?

---

### Task 5: GitHub Actions & Workflows (Preview)
1. List the workflow runs on any public repo that uses GitHub Actions
2. View the status of a specific workflow run
3. Answer in your notes: How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?

(Don't worry if you haven't learned GitHub Actions yet — this is a preview for upcoming days)

---

### Task 6: Useful `gh` Tricks
Explore and try these — add the ones you find useful to your `git-commands.md`:
1. `gh api` — make raw GitHub API calls from the terminal
2. `gh gist` — create and manage GitHub Gists
3. `gh release` — create and manage releases
4. `gh alias` — create shortcuts for commands you use often
5. `gh search repos` — search GitHub repos from the terminal

---

## Hints
- `gh help` and `gh <command> --help` are your best friends
- Most `gh` commands work with `--repo owner/repo` to target a specific repo
- Use `--json` flag with most commands to get machine-readable output (useful for scripting)
- `gh pr create --fill` auto-fills the PR title and body from your commits

---

## Submission
1. Add your `day-26-notes.md` to `2026/day-26/`
2. Update `git-commands.md` with `gh` commands — this completes your Git & GitHub reference from Days 22–26
3. Push to your fork

---

Happy Learning!
**TrainWithShubham**
