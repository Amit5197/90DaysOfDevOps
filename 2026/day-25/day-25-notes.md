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
2. Revert commit Y (the middle one) — what happens?
3. Check `git log` — is commit Y still in the history?
4. Answer in your notes:
   - How is `git revert` different from `git reset`?
   - Why is revert considered **safer** than reset for shared branches?
   - When would you use revert vs reset?

---

### Task 3: Reset vs Revert — Summary
Create a comparison in your notes:

| | `git reset` | `git revert` |
|---|---|---|
| What it does | ? | ? |
| Removes commit from history? | ? | ? |
| Safe for shared/pushed branches? | ? | ? |
| When to use | ? | ? |

---

### Task 4: Branching Strategies
Research the following branching strategies and document each in your notes with:
- How it works (short description)
- A simple diagram or flow (text-based is fine)
- When/where it's used
- Pros and cons

1. **GitFlow** — develop, feature, release, hotfix branches
2. **GitHub Flow** — simple, single main branch + feature branches
3. **Trunk-Based Development** — everyone commits to main, short-lived branches
4. Answer:
   - Which strategy would you use for a startup shipping fast?
   - Which strategy would you use for a large team with scheduled releases?
   - Which one does your favorite open-source project use? (check any repo on GitHub)

---

### Task 5: Git Commands Reference Update
Update your `git-commands.md` to cover everything from Days 22–25:
- Setup & Config
- Basic Workflow (add, commit, status, log, diff)
- Branching (branch, checkout, switch)
- Remote (push, pull, fetch, clone, fork)
- Merging & Rebasing
- Stash & Cherry Pick
- Reset & Revert

---

## Hints
- `git reflog` is your safety net — it shows everything Git has done, even after a hard reset
- For branching strategies, look at how projects like Kubernetes, React, or Linux kernel manage branches

---

## Submission
1. Add your `day-25-notes.md` to `2026/day-25/`
2. Update `git-commands.md` — commit and push
3. Push to your fork

---

## Learn in Public

Share your Reset vs Revert comparison or your branching strategy notes on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
