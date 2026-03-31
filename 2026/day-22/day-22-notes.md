# Day 22 – Introduction to Git: Your First Repository

**What is GIt(Global Information Tracker) - Git is a Version Control System (VCS) that tracks every single change you make to your files.**

### Task 1: Install and Configure Git
1. Verify Git is installed on your machine
2. Set up your Git identity — name and email
3. Verify your configuration

<img width="872" height="166" alt="image" src="https://github.com/user-attachments/assets/92fff0e3-c822-4322-8488-74c512f77ac4" />

---

### Task 2: Create Your Git Project
1. Create a new folder called `devops-git-practice`
2. Initialize it as a Git repository
3. Check the status — read and understand what Git is telling you
4. Explore the hidden `.git/` directory — look at what's inside

<img width="1027" height="596" alt="image" src="https://github.com/user-attachments/assets/15fdc472-bc74-4e49-8bc6-552131ffd91e" />

---

### Task 3: Create Your Git Commands Reference
1. Create a file called `git-commands.md` inside the repo
2. Add the Git commands you've used so far, organized by category:
   - **Setup & Config**
   - **Basic Workflow**
   - **Viewing Changes**
3. For each command, write:
   - What it does (1 line)
   - An example of how to use it

## Setup & Config

  ### git init
  - Initializes a new Git repository.
  - **Example**: 
      ```
      git init 
      ```
  ### git config
  - Configures Git username or email.
  - **Example**:
    ```
        git config --global user.name "Your Name"
        git config --global user.email "Your Email"
     ```
  - View Config Values
    - **Example**:
      ```
        git config --global --list
      ```

      ## Basic Workflow

  ### git add
  - Stages files for commit.
  - **Example**:
      ```
      git add git-commands.md
      ```

  ### git commit
  - Save staged changes with a message explaining what you changed.
  - **Example**:
      ```
      git commit -m "Add git commands reference"
      ```

  ## Viewing Changes

  ### git status
  - Lists which files are modified and not yet stage
  - **Example**:
      ```
      git status
      ```

  ### git log
  - Shows the history of commits in your repository who changed what,when,and why.
  - Its also shows Commit hash,Author name & email,Date,Commit message
  - **Example**:
      ```
      git log
      ```
---

### Task 4: Stage and Commit
1. Stage your file
2. Check what's staged
3. Commit with a meaningful message
4. View your commit history

```
  git add git-command.md
  git status
  
  On branch master
  No commits yet
      Changes to be committed:
        (use "git rm --cached <file>..." to unstage)
        new file: git-command.md
        
  git commmit -m "Initial git command reference"
  
```
---

### Task 5: Make More Changes and Build History
1. Edit `git-commands.md` — add more commands as you discover them
2. Check what changed since your last commit
3. Stage and commit again with a different, descriptive message
4. Repeat this process at least **3 times** so you have multiple commits in your history
5. View the full history in a compact format

<img width="995" height="410" alt="image" src="https://github.com/user-attachments/assets/9688a852-0561-482c-b973-f6054bc107d7" />

---

### Task 6: Understand the Git Workflow
Answer these questions in your own words (add them to a `day-22-notes.md` file):
1. What is the difference between `git add` and `git commit`?
2. What does the **staging area** do? Why doesn't Git just commit directly?
3. What information does `git log` show you?
4. What is the `.git/` folder and what happens if you delete it?
5. What is the difference between a **working directory**, **staging area**, and **repository**?

## Answer
1. What is the difference between `git add` and `git commit`?
- `git add` tells Git which changes you want to include in the next commit. It moves changes from the Working Directory to the Staging Area.
- `git commit` saves staged changes with a message explaining what you changed.

2. What does the **staging area** do? Why doesn't Git just commit directly?
- The staging area is like a waiting room for changes. You choose what to include in your next commit.
- Git doesn't commit directly so you can decide exactly which changes to save and organize your commits better.

3. What information does `git log` show you?
- `git log` shows a history of commits in your repository.
- It includes the commit ID, author, date, and commit message for each change.

4. What is the `.git/` folder and what happens if you delete it?
- The `.git/` folder stores all Git information for your project: commits, branches, tags, and configuration.
- If you delete it, Git will no longer track your project, and you will lose all version history

5. What is the difference between a **working directory**, **staging area**, and **repository**?
+ **Working Directory** is your local filesystem — the actual files you see and edit in your project folder. Changes here are untracked until you explicitly tell Git about them.
+ **Staging Area** (also called the "index") is a preparation zone between your working directory and the repository. When you run ``` git add ``` , you're copying a snapshot of changes into the staging area. This lets you craft precise commits — you can stage some changes from a file while leaving others unstaged.
+ **Repository** (the .git folder) is Git's permanent database of committed snapshots. When you run ``` git commit ``` , everything in the staging area gets written here as a new commit object. This history is what gets pushed to GitHub, etc.

## Workflow:

Working Directory (edit files) →  git add  →  Staging Area (review/prep)  →  git commit  →  Repository (permanent history)
                                       
**Happy Learning**

     😊
---

