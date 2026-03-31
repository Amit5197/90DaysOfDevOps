# Day 23 – Git Branching & Working with GitHub

## Task

Now that you know how to create repos, stage, and commit — it's time to learn the most powerful concept in Git: **branching**. Branches let you work on features, fixes, and experiments in isolation without breaking your main code. You'll also push your work to GitHub for the first time.

---

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
2. Create a new branch called `feature-1`
3. Switch to `feature-1`
4. Create a new branch and switch to it in a single command — call it `feature-2`
5. Try using `git switch` to move between branches — how is it different from `git checkout`?
6. Make a commit on `feature-1` that does **not** exist on `main`
7. Switch back to `main` — verify that the commit from `feature-1` is not there
8. Delete a branch you no longer need
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
