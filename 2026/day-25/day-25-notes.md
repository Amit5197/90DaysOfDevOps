# Day 25 – Git Reset vs Revert & Branching Strategies

## Challenge Tasks

### Task 1: Git Reset — Hands-On
1. Make 3 commits in your practice repo (commit A, B, C)

# Use git reset --soft to go back one commit — what happens to the changes?
  + After doing ```git rest --soft Head~1``` head~1 means (c) so the c is removed from the history
  + heand is pointing to B
  + and in ``` git status ``` i see the changes of (C) is in staging area
# OUTPUT
<img width="742" height="683" alt="image" src="https://github.com/user-attachments/assets/c9b1b47c-0c4b-4e39-8731-622bbeac2fc9" />

2. Use `git reset --soft` to go back one commit — what happens to the changes?
<img width="752" height="521" alt="image" src="https://github.com/user-attachments/assets/99788a72-b317-4cd3-b1bc-4e80e7d38cd1" />

+ The changes are still staged and the last commit C is ready to be committed again

3. Re-commit, then use `git reset --mixed` to go back one commit — what happens now?
  + After doing ``` git reset --mixed HEAD~1 ``` commit (C)is removed
  + heand pointing to (B)
  + but they move to working directory (unstaged)
# OUTPUT
<img width="742" height="776" alt="image" src="https://github.com/user-attachments/assets/80d82455-7400-46bf-9160-f8d17cc0e1d9" />
+ Commit C removed from history.Changes from commit C remain in working directory. Changes are unstaged.

4. Re-commit, then use `git reset --hard` to go back one commit — what happens this time?
 + after doing ``` git reset --hard HEAD~1 ``` commit (C) will removed
  + Head pointing to (B)
  + All changes are deleted from c
  + working directory is clean
# OUTPUT
<img width="816" height="472" alt="image" src="https://github.com/user-attachments/assets/07175566-3539-499c-826a-000d915dba07" />
+ Commit C removed. Changes deleted permanently.Working directory reset to previous commit.
+ All changes from commit C are lost.

5. Answer in your notes:
   - What is the difference between `--soft`, `--mixed`, and `--hard`?
       + ``` --soft ``` :- it removes the commit, But keeps the changes staged
       + ``` --mixed ```:- it removes the commit and unstaged the changes
       + ``` --hard ``` :- it delete the commit and make working direcotry clean

    - Which one is destructive and why?
       + git --hard is distructive because it deletes commits + staging changes + working directory changes so data will loss

   - When would you use each one?
       + ``` --soft ``` : when i want to change commit message or keep changes staged
       + ``` -- mixed ``` : when i want to re-edit files and re-stage file properly
       + ``` --hard ``` : when i want to completely delete the changes nd clean the brnach

   - Should you ever use `git reset` on commits that are already pushed?
      + No, Once commits are pushed, others may have already pulled and worked on them,so resetting them can cause confusion and conflicts.
---

### Task 2: Git Revert — Hands-On
1. Make 3 commits (commit X, Y, Z)
<img width="765" height="933" alt="image" src="https://github.com/user-attachments/assets/dda17cd8-7ff4-440e-bdf8-eab5ab90df8a" />

2. Revert commit Y (the middle one) — what happens?
```git revert 1a91427````
<img width="653" height="52" alt="image" src="https://github.com/user-attachments/assets/98e24476-db9f-4b70-ad35-d7fb7c1a63bd" />
<img width="802" height="426" alt="image" src="https://github.com/user-attachments/assets/d6e12f06-4cf7-44a3-bcde-c14e9afb2dc6" />

+ A new commit is created that undoes the changes from commit Y. The original commit Y remains in the history, but its changes are reversed in the codebase.

3. Check `git log` — is commit Y still in the history?
+ Yes, commit Y is still in the history, but it has been reverted by a new commit that undoes its changes.

4. Answer in your notes:
   ### How is `git revert` different from `git reset`?
     + git reset removes commits from branch history and also delete when we use --hard
     + git revert does not commit that undoes the changes ,keep history safe

   ### Why is revert considered **safer** than reset for shared branches?
     + git revert is safer because it does not rewrite history it creates a new commit that undoes changes so everyone in the team stay in sync.
     + git reset changes hisotry and requires force push which can break other developers branches.

   ### When would you use revert vs reset?
    +  Will use git revert when i am working on a Shared Branches.
    +  Will use git reset when the commit is not Pushed yet.
---

### Task 3: Reset vs Revert — Summary
Create a comparison in your notes:

| | `git reset` | `git revert` |
|---|---|---|
| What it does | git reset moves the branch pointer and rewrites history | git revert creates a new commit that cancels the previous one |
| Removes commit from history? | Yes | No |
| Safe for shared/pushed branches? | No | Yes |
| When to use | When working on locally and commit is not pushed yet | When working on shered or pushed branches |

---

### Task 4: Branching Strategies
Research the following branching strategies and document each in your notes with:
- How it works (short description)
- A simple diagram or flow (text-based is fine)
- When/where it's used
- Pros and cons

<img width="1263" height="779" alt="image" src="https://github.com/user-attachments/assets/d19917e3-7855-4736-b980-774540df3d2c" />

1. **GitFlow** — develop, feature, release, hotfix branches
1. **GitFlow**
    **How it works:**

    - `main`      : Contains production-ready code.Every commit here is a stable release.
        
    - `develop`   : The integration branch where new features are merged before they’re ready to go live.
    
    - `feature`   : For building out new functionality.Created from develop and merged back when complete.
        
    - `release`   : Used to prep a new version for production.Created from develop and merged into both main and develop.

    - `hotfix`   : For urgent fixes on production.Created from main,then merged back into both main and develop.

    **Text Diagram:**
    ```text
    [main] (Production-ready)
    |
    o <----------------------------------------- (Start)
    | \
    |  \ [develop] (Integration)
    |   |
    |   o <------------------------------------- (Develop Start)
    |   | \
    |   |  \ [feature/login] (New functionality)
    |   |   |
    |   |   o (Feature Commit)
    |   |   |
    |   |   o (Feature Complete)
    |   |  /
    |   o / (Merge feature to develop)
    |   |
    |   | \
    |   |  \ [release/1.0] (Prep for production)
    |   |   |
    |   |   o (Release Prep/Bug Fix)
    |   |   |
    |   |   o (Release Ready)
    |   |  / \
    |   o /   o (Merge release to develop)
    |  /
    o / (Merge release to main & tag v1.0)
    |
    | \
    |  \ [hotfix/1.0.1] (Urgent fix)
    |   |
    |   o (Apply Fix)
    |  / \
    o /   o (Merge hotfix to develop)
    |
    V
    ```

    **When/where it's used:**

    - Team follows scheduled release cycles

    - Need to maintain multiple versions

    **Pros:** 
    - Clear separation of concerns across features,releases,and hotfixes.

    **Cons:** 
    - Can result in long-lived branches,increasing the risk of merge conflicts.

2. **GitHub Flow** — simple, single main branch + feature branches
   **How it works:**

    - Create a `feature branch` from `main`
    - Push commits to the `feature branch`
    - Open a pull request for code review and automated tests.
    - Once approved, merge back to `main`.
    - Deploy immediately.
    - Everything in main should always be production-ready.

    **Text Diagram:**
    ```text  
   
      [main] (Always Production-Ready)
        |
        o (Start)
        |
        |\_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
        |                               \
        |                                \ [feature/login]
        |                                 |
        |                                 o (Commit 1)
        |                                 |
        |                                 o (Commit 2)
        |                                 |
        |                                 o (Pull Request & Review)
        |<_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _/
        |                               
        o (Merge & Auto-Deploy)
        |
        v
    ```

    **When/where it's used:**
    - ship frequent,small releases

     **Pros:**
    - Fast merge & deploy
    
     **Cons:**
     - In large teams,it can result in frequent merge conflicts

3. **Trunk-Based Development** — everyone commits to main, short-lived branches
**How it works:**

    - There’s one `main` branch, often called main or trunk. All development happens here
    - Developers commit directly to `main`, often multiple times per day
    - Changes are small,incremental

     **Text Diagram:**
     ```text
      [main] (The Trunk)
        |
        o (Start)
        |
        |\_ _ _ _ _ _ _ 
        |             \
        |              o (Dev A: Small Change)
        |<_ _ _ _ _ _ /
        |             /
        o (Merge & Test)
        |
        |\_ _ _ _ _ _ _ 
        |             \
        |              o (Dev B: Small Change)
        |<_ _ _ _ _ _ /
        |             /
        o (Merge & Test)
        |
        v
    ```

4. Answer:
   - Which strategy would you use for a startup shipping fast?
     + I would use Trunk-Based Development for a startup that needs to ship fast
   
   - Which strategy would you use for a large team with scheduled releases?
    + GitFlow

<img width="1362" height="741" alt="image" src="https://github.com/user-attachments/assets/bf226bfb-2fef-4d50-bb7b-f4ebb63abeca" />

   - Which one does your favorite open-source project use? (check any repo on GitHub)
   + https://github.com/Amit5197/Git-Practice (GitHub Flow)

---
Happy Learning!
**TrainWithShubham**
