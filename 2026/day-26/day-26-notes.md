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
<img width="820" height="212" alt="image" src="https://github.com/user-attachments/assets/c90be3a7-456a-4201-9c44-d173c23e0b7d" />
<img width="1710" height="482" alt="image" src="https://github.com/user-attachments/assets/f5e66447-7d87-4081-9a46-6ad502e8041b" />
2. List all open issues on that repo
<img width="922" height="188" alt="image" src="https://github.com/user-attachments/assets/6c20a233-8148-420a-b338-fb0598f57dfb" />

3. View a specific issue by its number
<img width="922" height="188" alt="image" src="https://github.com/user-attachments/assets/6c20a233-8148-420a-b338-fb0598f57dfb" />

4. Close an issue from the terminal
<img width="922" height="98" alt="image" src="https://github.com/user-attachments/assets/46ff578f-50c1-4264-a7e5-01b7d570219e" />
<img width="1282" height="767" alt="image" src="https://github.com/user-attachments/assets/d9384b52-5e66-4c03-b1c5-a9610b5146e9" />

5. Answer in your notes: How could you use `gh issue` in a script or automation?
- By combining gh issue commands in a script,you can automatically:
        - Check open issues
        - Add comments
        - Close issues

    - Example:
        ```
        gh issue list --repo Amit5197/gh-cli-task-day26
        gh issue comment 1 --repo Amit5197/gh-cli-task-day26 --body "Checked automatically."
        gh issue close 1 --repo Amit5197/gh-cli-task-day26
        ```

        # For Uninstall GITHUB from CLI

      ```winget uninstall GitHub.cli```
---

### Task 4: Pull Requests
1. Create a branch, make a change, push it, and create a **pull request** entirely from the terminal
<img width="773" height="616" alt="image" src="https://github.com/user-attachments/assets/db25c158-170c-4f30-a82e-86fd92ff56c3" />
<img width="1292" height="845" alt="image" src="https://github.com/user-attachments/assets/c14f42ea-0456-4bac-8d8e-4670dc64b711" />

2. List all open PRs on a repo
```gh pr list```

4. View the details of your PR — check its status, reviewers, and checks
<img width="577" height="132" alt="image" src="https://github.com/user-attachments/assets/cbe5b433-1fd5-4f6c-afc4-d87e35fa8f9e" />

5. Merge your PR from the terminal
<img width="1277" height="837" alt="image" src="https://github.com/user-attachments/assets/056b2e55-4c30-4130-a30f-88b14b57dc80" />

6. Answer in your notes:
   - What merge methods does `gh pr merge` support?
     + Merge Commit
     + Squash and Merge
     + Rebase and Merge

   - How would you review someone else's PR using `gh`?
     + ```gh pr review <PR-number>```
---

### Task 5: GitHub Actions & Workflows (Preview)
1. List the workflow runs on any public repo that uses GitHub Actions
```gh run list --repo aws-containers/retail-store-sample-app```

2. View the status of a specific workflow run
<img width="1136" height="725" alt="image" src="https://github.com/user-attachments/assets/09077c7c-e1b2-4218-90ae-4cdc5b0f2268" />
<img width="1305" height="321" alt="image" src="https://github.com/user-attachments/assets/b9e19eec-68c0-4074-9cd6-269dec9542a3" />

3. Answer in your notes: How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?
```gh run``` : Monitoring and Troubleshooting
+ gh run is focused on the execution of your pipelines. It is the command-line equivalent of the "Actions" tab in your browser.

```gh workflow``` : Management and Manual Control
+ gh workflow focuses on the definition and triggering of the pipelines. This is where you manage the "logic" of your CI/CD.

---

Happy Learning!
**TrainWithShubham**
