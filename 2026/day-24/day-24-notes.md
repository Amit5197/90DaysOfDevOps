# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge — Hands-On

1. Create a new branch `feature-login` from `main`, add a couple of commits to it
2. Switch back to `main` and merge `feature-login` into `main`
3. Observe the merge — did Git do a **fast-forward** merge or a **merge commit**?
  * **fast-forward**
  
     ![snapshot](images/ff_merge.png)
     
4. Now create another branch `feature-signup`, add commits to it — but also add a commit to `main` before merging
5. Merge `feature-signup` into `main` — what happens this time?
 * **merge commit**
 
    ![snapshot](images/commit_merge.png)
    
6. Answer in your notes:
  - What is a fast-forward merge?
     * It merges two branches without creating a new commit. Instead, it simply moves the current branch’s 
       pointer forward to match the branch being merged. 
  - When does Git create a merge commit instead?
     * When you try to merge two branches that have diverged. Git makes a new commit to combine the incoming changes.
  - What is a merge conflict? (try creating one intentionally by editing the same line in both branches)
     * A merge conflict occurs when the same part of a file is changed in two branches. 
       When merging, Git cannot automatically  decide which change to keep. 
       Git will pause and require you to resolve the conflict before completing the merge.
---

## Task 2: Git Rebase — Hands-On

1. Create a branch `feature-dashboard` from `main`, add 2-3 commits
2. While on `main`, add a new commit (so `main` moves ahead)
3. Switch to `feature-dashboard` and rebase it onto `main`
4. Observe your `git log --oneline --graph --all` — how does the history look compared to a merge?

    ![snapshot](images/rebase.png)
    
5. Answer in your notes:
   - What does rebase actually do to your commits?
     * Rebase creates linear history.
   - How is the history different from a merge?
     * Merge doesn’t change history, it shows commits as they were. What rebase did is it changed history of commits, 
       it showed main commit first then the `feature-dashboard` commit to make it linear.
       It is as if I started `feature-dashboard` from newest `master` commit.
   - Why should you **never rebase commits that have been pushed and shared** with others?
     * Because rebase rewrites commit history. If others have already pulled those commits,
       then it will create confusion and conflicts.
   - When would you use rebase vs merge?
     * Merge, as it preserves when the commit was exactly made.

---

## Task 3: Squash Commit vs Merge Commit

1. Create a branch `feature-profile`, add 4-5 small commits (typo fix, formatting, etc.)
2. Merge it into `main` using `--squash` — what happens?

    ![snapshot](images/squash.png)
    
3. Check `git log` — how many commits were added to `main`?
4. Now create another branch `feature-settings`, add a few commits
5. Merge it into `main` **without** `--squash` (regular merge) — compare the history

    ![snapshot](images/simple.png)
    
6. Answer in your notes:
   - What does squash merging do?
     * It combines multiple commits from a branch and merges them into another branch as a single commit.
   - When would you use squash merge vs regular merge?
     * If one file has multiple commits, then squashing is better. Else regular merge.
   - What is the trade-off of squashing?
     * Detailed commit history is lost from feature branch as only one commit will be shown in main branch.

---

## Task 4: Git Stash — Hands-On

1. Start making changes to a file but **do not commit**
2. Now imagine you need to urgently switch to another branch — try switching. What happens?

    ![snapshot](images/stash.png)
    
    * If changes doesn't conflict with the branch you are switching to it will let you switch, else it will not allow switch.
    
3. Use `git stash` to save your work-in-progress
4. Switch to another branch, do some work, switch back
5. Apply your stashed changes using `git stash pop`
6. Try stashing multiple times and list all stashes
7. Try applying a specific stash from the list

    ![snapshot](images/stash1.png)
    
    ![snapshot](images/stash2.png)
    
8. Answer in your notes:
   - What is the difference between `git stash pop` and `git stash apply`?
     * `git stash pop` applies stash changes to your working directory and deletes the stash entry.
     * `git stash apply` applies stash changes to your working directory but keeps the stash entry.
   - When would you use stash in a real-world workflow?
     * When an urgent fix comes up, I would stash changes from my current branch and switch to another branch 
       to work on urgent fix first.

---

## Task 5: Cherry Picking

1. Create a branch `feature-hotfix`, make 3 commits with different changes
2. Switch to `main`
3. Cherry-pick **only the second commit** from `feature-hotfix` onto `main` 
4. Verify with `git log` that only that one commit was applied

    ![snapshot](images/cherry1.png)
    
    ![snapshot](images/cherry2.png)
    
5. Answer in your notes:
   - What does cherry-pick do?
     * It lets you pick and apply one/range commit from another branch to your current branch instead of merging all.
   - When would you use cherry-pick in a real project?
     * Suppose I made 3 changes but I wantonly one changes to be applied to main branch. Then I would cherry-pick
       that single commit instead of merging the whole branch.
   - What can go wrong with cherry-picking?
     * If the same branch is merged then it will create duplicate commits.
     * It may create conflicts if the commit depends on previous commits.

---
