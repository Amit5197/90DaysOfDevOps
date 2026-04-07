# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Challenge Tasks

### Task 1: Git Merge — Hands-On
1. Create a new branch `feature-login` from `main`, add a couple of commits to it

```
# Create and switch to the new branch
` git checkout -b feature-login `

# Create a file and commit
` echo "Login logic" > login.txt `
` git add login.txt ` 
` git commit -m "Add login logic" `

# Add a second commit
echo "Login styles" >> login.txt
git commit -am "Add login styles"
```

<img width="836" height="501" alt="image" src="https://github.com/user-attachments/assets/d81999aa-cf94-47ae-aa7c-1758ee2f0784" />

2. Switch back to `main` and merge `feature-login` into `main`
# Switch back to main
` git checkout main `

# Merge the feature branch
` git merge feature-login `

3. Observe the merge — did Git do a **fast-forward** merge or a **merge commit**?
` fast-forward `
+ What happened? You will likely see the message Fast-forward.
Since main had no new commits of its own, Git didn't need to combine any divergent histories; it just pointed main to the same commit as feature-login.

4. Now create another branch `feature-signup`, add commits to it — but also add a commit to `main` before merging

<img width="947" height="992" alt="image" src="https://github.com/user-attachments/assets/9bbd3dc1-8c72-47ef-bdbf-3e2de5aef6b2" />

5. Merge `feature-signup` into `main` — what happens this time?
# Merge feature-signup into main
` git merge feature-signup `
+ Merge conflicts happen because the same file is edited in two branches.

6. Answer in your notes:
   - What is a fast-forward merge?
     A fast-forward merge occurs when the current branch (main) has no additional commits relative to the feature branch (feature-login). In this case, Git simply        moves the pointer of the target branch forward to the latest commit of the feature branch. No new "merge commit" is created because the history remains a          single, straight line.
     <img width="601" height="112" alt="image" src="https://github.com/user-attachments/assets/dd3d3d0b-da66-4f07-94f8-3802366ad872" />

   - When does Git create a merge commit instead?
     A merge commit is created when the histories of the two branches you are trying to join have diverged.
<img width="700" height="143" alt="image" src="https://github.com/user-attachments/assets/b7e79e2b-e744-4cd9-a25a-fa97f96fcabd" />

   - What is a merge conflict? (try creating one intentionally by editing the same line in both branches)
    Merge conflicts happen because the same file is edited in two branches. Git can’t figure out which version of a file to keep during a merge.

---

### Task 2: Git Rebase — Hands-On
1. Create a branch `feature-dashboard` from `main`, add 2-3 commits
2. While on `main`, add a new commit (so `main` moves ahead)
3. Switch to `feature-dashboard` and rebase it onto `main`
4. Observe your `git log --oneline --graph --all` — how does the history look compared to a merge?
5. Answer in your notes:
   - What does rebase actually do to your commits?
   - How is the history different from a merge?
   - Why should you **never rebase commits that have been pushed and shared** with others?
   - When would you use rebase vs merge?

---

### Task 3: Squash Commit vs Merge Commit
1. Create a branch `feature-profile`, add 4-5 small commits (typo fix, formatting, etc.)
2. Merge it into `main` using `--squash` — what happens?
3. Check `git log` — how many commits were added to `main`?
4. Now create another branch `feature-settings`, add a few commits
5. Merge it into `main` **without** `--squash` (regular merge) — compare the history
6. Answer in your notes:
   - What does squash merging do?
   - When would you use squash merge vs regular merge?
   - What is the trade-off of squashing?

---

### Task 4: Git Stash — Hands-On
1. Start making changes to a file but **do not commit**
2. Now imagine you need to urgently switch to another branch — try switching. What happens?
3. Use `git stash` to save your work-in-progress
4. Switch to another branch, do some work, switch back
5. Apply your stashed changes using `git stash pop`
6. Try stashing multiple times and list all stashes
7. Try applying a specific stash from the list
8. Answer in your notes:
   - What is the difference between `git stash pop` and `git stash apply`?
   - When would you use stash in a real-world workflow?

---

### Task 5: Cherry Picking
1. Create a branch `feature-hotfix`, make 3 commits with different changes
2. Switch to `main`
3. Cherry-pick **only the second commit** from `feature-hotfix` onto `main`
4. Verify with `git log` that only that one commit was applied
5. Answer in your notes:
   - What does cherry-pick do?
   - When would you use cherry-pick in a real project?
   - What can go wrong with cherry-picking?

---

## Hints
- Visualize history: `git log --oneline --graph --all`
- To intentionally create a merge conflict: edit the **same line** of the **same file** on two branches
- Stash with a message: `git stash push -m "description"`
- Cherry-pick needs a commit hash — find it with `git log --oneline`

---

## Submission
1. Add your `day-24-notes.md` to `2026/day-24/`
2. Update `git-commands.md` with all new commands and commit
3. Push to your fork

---

## Learn in Public

Share your merge vs rebase comparison on LinkedIn — a diagram or screenshot of `git log --graph` goes a long way!

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
