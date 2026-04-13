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

<img width="682" height="102" alt="image" src="https://github.com/user-attachments/assets/d003e146-cd4d-4e93-83a9-4df4cce98753" />
<img width="1171" height="220" alt="image" src="https://github.com/user-attachments/assets/d3119bc5-6159-498d-a80b-f28e950a6499" />

+ Resolved conflict
<img width="686" height="242" alt="image" src="https://github.com/user-attachments/assets/012460b2-2d80-48c4-9486-8bfdf9de9f98" />

+ git log
<img width="680" height="143" alt="image" src="https://github.com/user-attachments/assets/e25e6fa7-bff5-442d-aab1-0ffb151f824e" />

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
+ Create a branch feature-dashboard from main, add 2-3 commits
  + ``` git checkout -b feature-dashboard ```
+ While on main, add a new commit (so main moves ahead)
  
<img width="911" height="743" alt="image" src="https://github.com/user-attachments/assets/74a5376b-0878-4ea8-b962-2eebb0d3cf7e" />

2. While on `main`, add a new commit (so `main` moves ahead)
<img width="900" height="211" alt="image" src="https://github.com/user-attachments/assets/506f3880-fe35-46d6-aab7-92be84da572b" />

3. Switch to `feature-dashboard` and rebase it onto `main`
+ Switch to feature-dashboard and rebase it onto main
+ ``` git checkout -b feature-dashboard ```
+ ``` git rebase main ```

<img width="671" height="207" alt="image" src="https://github.com/user-attachments/assets/d25eadd0-065a-4940-ac5a-f4c15fd7626d" />

4. Observe your `git log --oneline --graph --all` — how does the history look compared to a merge?
+ git merge creates a branching history with a merge commit while rebase creates a linear history by rewriting commits without merge commit.

<img width="705" height="263" alt="image" src="https://github.com/user-attachments/assets/9c57b067-de65-4a91-b389-451f10d1809c" />

5. Answer in your notes:
   - What does rebase actually do to your commits?
      - Rebase "rewrites history" by taking your feature-dashboard branch commits and replaying them one by one on top of the latest version of main.
      or- Rebase rewrites your commits by replaying them on top of another branch , creating new commit ids and changing their base.
      or - Git Rebase is the process of moving or combining a sequence of commits to a new base commit. It effectively "rewrites" the history of your branch.

    - How is the history different from a merge?
      - `merge`preserves history exactly as it happened.creates a merge commit.
      - `rebase`rewrites history. moves your commits on top of feature-dashboard branch,creates a linear,clean history.no merge commit.
      - or difference between Merge and Rebase lies in how they treat time and the "story" of your project.
   
   - Why should you **never rebase commits that have been pushed and shared** with others?
      - because rebase changes commit id's, if others pulled the old commits:their history won’t match yours anymore causes conflicts,duplicated commits.

   - When would you use rebase vs merge?

      - `rebase`: keeping history linear
      or- we can rebase when we are working on private or a local branch
      - `merge`: working on shared branches.you want full history preserved.
      or- merge for safe collabration and shared branches

---

### Task 3: Squash Commit vs Merge Commit
1. Create a branch `feature-profile`, add 4-5 small commits (typo fix, formatting, etc.)

<img width="515" height="912" alt="image" src="https://github.com/user-attachments/assets/50296301-602a-4408-b0be-dd9b82a51475" />

2. Merge it into `main` using `--squash` — what happens?
+ ```git switch main```
+ ```git merge --squash feature-profile```

<img width="723" height="235" alt="image" src="https://github.com/user-attachments/assets/eda794ea-dc10-4fef-a593-b9f2166860d1" />

3. Check `git log` — how many commits were added to `main`?

<img width="711" height="248" alt="image" src="https://github.com/user-attachments/assets/680a4167-5f0c-4101-a6ab-d14ce54976eb" />

4. Now create another branch `feature-settings`, add a few commits
+ ```git checkout -b feature-setting```

5. Merge it into `main` **without** `--squash` (regular merge) — compare the history

<img width="713" height="257" alt="image" src="https://github.com/user-attachments/assets/e5c413ac-0bfa-4810-9a59-bb90eefde7ce" />
<img width="725" height="201" alt="image" src="https://github.com/user-attachments/assets/edcd7c74-630e-4fa9-ab4c-11b86cfc6413" />

6. Answer in your notes:

   - What does squash merging do?
   + A sqaush merge applies the changes of a branch but not its individual commit history

   - When would you use squash merge vs regular merge?
    + use squash merge for a clean, simplified history.
    + and use regular merge when you need to preserve full commit history.
   
   - What is the trade-off of squashing?
   + `trade-off` squashing is cleaner history at the cost if losing detailed commit .
   + or - The `trade-off` of squashing is that while it keeps the main branch history clean and linear,it removes the detailed commit history of the feature branch by combining everything into a single commit.

---

### Task 4: Git Stash — Hands-On
1. Start making changes to a file but **do not commit**
<img width="772" height="571" alt="image" src="https://github.com/user-attachments/assets/9fb212ca-b3dc-4da5-8636-3c9edcc9242d" />

2. Now imagine you need to urgently switch to another branch — try switching. What happens?
+ git allows switching branches with uncommited changes if they dont conflict with the target the branch
+ If there is no conflict,git allows the switch and your changes move with you.
+ If there is a conflict,git blocks the switch to prevent overwriting your changes.

3. Use `git stash` to save your work-in-progress

<img width="752" height="477" alt="image" src="https://github.com/user-attachments/assets/11dd210d-5d0c-4735-b3a8-f29a0e56aee0" />

4. Switch to another branch, do some work, switch back
5. Apply your stashed changes using `git stash pop`
6. Try stashing multiple times and list all stashes
7. Try applying a specific stash from the list
8. Answer in your notes:
   - What is the difference between `git stash pop` and `git stash apply`?

      `git stash pop`: brings your stashed changes back to your working directory.deletes that entry from your stash list immediately.

      `git stash apply`: brings the stashed changes back to your working directory.keeps the entry in your stash list.

   - When would you use stash in a real-world workflow?
      - If I’m working on a feature and need to urgently switch branches to fix a production bug,I would use git stash to temporarily save my unfinished changes before switching.

---

### Task 5: Cherry Picking
1. Create a branch `feature-hotfix`, make 3 commits with different changes
<img width="487" height="982" alt="image" src="https://github.com/user-attachments/assets/33d18403-a594-4654-ba5a-7aa425de670d" />

2. Switch to `main`

```git switch main```

3. Cherry-pick **only the second commit** from `feature-hotfix` onto `main`
<img width="717" height="522" alt="image" src="https://github.com/user-attachments/assets/40de458d-3572-4c86-a6c1-e7ee872cb291" />
<img width="702" height="615" alt="image" src="https://github.com/user-attachments/assets/6ad24bb4-a77d-432d-9eb3-ec806162debf" />


4. Verify with `git log` that only that one commit was applied

<img width="615" height="196" alt="image" src="https://github.com/user-attachments/assets/6c401521-14f4-4ea2-b157-65c324140538" />
<img width="666" height="196" alt="image" src="https://github.com/user-attachments/assets/2e94e2e7-62fc-4f61-b90a-277decb359d8" />

5. Answer in your notes:
   - What does cherry-pick do?
   + git cherry-pick is like copy-pasting a specific commit from one branch to another.
   + or - copy a specific commit from one branch and apply it onto our current branch.
    
   - When would you use cherry-pick in a real project?
   + when i need specific commit but do not want the enitre branch to be commit.
     
   - What can go wrong with cherry-picking?
   + merge conflicts if same file was modified.
   + Commit history confusion because it creates new commit ids.

---

Happy Learning!
**TrainWithShubham**
