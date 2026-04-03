# Day 23 – Git Branching & Working with GitHub

## Challenge Tasks

### Task 1: Understanding Branches
Answer these in your `day-23-notes.md`:
1. What is a branch in Git?
2. Why do we use branches instead of committing everything to `main`?
3. What is `HEAD` in Git?
4. What happens to your files when you switch branches?

## Answer->
# 1. What is a branch in Git?
+ A branch is a parallel workspace that lets you work on new features or fixes without touching the stable "main" code.
+ Meanwhile a brach is a movaable pointer to a specific commit.
Why it helps: It keeps your project organized and lets you experiment safely. If a branch breaks, you just delete it; your main code stays perfect.

# 2. Why do we use branches instead of committing everything to `main`?
+ Branches let us work on new features or fixes safely without breaking main branch, which always holds the stable, production-ready code.
+ Main branch is highly important and stable so its best practice to not interrupt it.

# 3. What is `HEAD` in Git?
+ HEAD is a pointer that tells you where you are currently working.
+ It always points to the latest commit on the branch you are working on.

# 4. What happens to your files when you switch branches?
+ Git updates your project files to look like the branch you switched to.
+ Files that exist in the current branch but not in the new branch will disappear temporarily.
+ Files that are different in the new branch will be replaced with the new branch version.

---

### Task 2: Branching Commands — Hands-On
In your `devops-git-practice` repo, perform the following:
1. List all branches in your repo
- `git branch`

<img width="1618" height="490" alt="image" src="https://github.com/user-attachments/assets/7b82c71f-a2f7-48d0-b290-7699999dc8fa" />
<img width="1230" height="132" alt="image" src="https://github.com/user-attachments/assets/267a224b-0c06-4836-ac29-11c582dc214e" />

2. Create a new branch called `feature-1`
- `git branch feature-1`

<img width="1385" height="125" alt="image" src="https://github.com/user-attachments/assets/228ecd10-00a9-4382-88c1-284631fd3463" />

3. Switch to `feature-1`
- `git switch feature-1`

<img width="810" height="72" alt="image" src="https://github.com/user-attachments/assets/1691392c-b99f-4685-8b66-d44e5adc4037" />

4. Create a new branch and switch to it in a single command — call it `feature-2`
- `git checkout -b feature-2`

<img width="1427" height="82" alt="image" src="https://github.com/user-attachments/assets/cbf89389-84db-486d-82a7-5f9f02ea8a97" />

5. Try using `git switch` to move between branches — how is it different from `git checkout`?
- `git switch <branch>`   :only switches branches.  
- `git checkout <branch>` :switches branches and can also restore files.

<img width="840" height="77" alt="image" src="https://github.com/user-attachments/assets/1e8541c9-0623-4d8c-86b0-6c5deeb92202" />

6. Make a commit on `feature-1` that does **not** exist on `main`
- `git commit -m "Add git branch command section to git-commands.md"`

<img width="1242" height="63" alt="image" src="https://github.com/user-attachments/assets/4f84e5b5-40f4-45fd-af7b-80db6bcb4f58" />

7. Switch back to `main` — verify that the commit from `feature-1` is not there

<img width="908" height="177" alt="image" src="https://github.com/user-attachments/assets/fe0a98f5-f72c-4050-a730-16ce07e6484b" />

8. Delete a branch you no longer need
- `git branch -d feature-2`

<img width="1397" height="261" alt="image" src="https://github.com/user-attachments/assets/ae6f8776-1a58-43ab-bdd6-989a7ef4d92b" />

9. Add all branching commands to your `git-commands.md`

---

### Task 3: Push to GitHub
1. Create a **new repository** on GitHub (do NOT initialize it with a README)
2. Connect your local `devops-git-practice` repo to the GitHub remote
3. Push your `main` branch to GitHub
4. Push `feature-1` branch to GitHub
5. Verify both branches are visible on GitHub
6. Answer in your notes: What is the difference between `origin` and `upstream`?

---

### Task 4: Pull from GitHub
1. Make a change to a file **directly on GitHub** (use the GitHub editor)
2. Pull that change to your local repo
3. Answer in your notes: What is the difference between `git fetch` and `git pull`?

---

### Task 5: Clone vs Fork
1. **Clone** any public repository from GitHub to your local machine
2. **Fork** the same repository on GitHub, then clone your fork
3. Answer in your notes:
   - What is the difference between clone and fork?
   - When would you clone vs fork?
   - After forking, how do you keep your fork in sync with the original repo?

---

## Hints
- When you create a branch, it starts from the commit you're currently on
- `git switch` is the modern alternative to `git checkout` for switching branches
- To push a new branch: `git push -u origin <branch-name>`
- A fork is a GitHub concept, not a Git concept

---

## Submission
1. Add your `day-23-notes.md` to `2026/day-23/`
2. Update `git-commands.md` with all new commands and commit
3. Push to your fork

---


`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
