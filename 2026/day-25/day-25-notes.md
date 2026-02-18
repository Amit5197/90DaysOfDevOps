# Day 25 – Git Reset vs Revert & Branching Strategies

## Task 1: Git Reset — Hands-On

1. Make 3 commits in your practice repo (commit A, B, C)

2. Use `git reset --soft` to go back one commit — what happens to the changes?
  * `git reset --soft` Moves HEAD back to the given commit. All commits after that point are removed from history, 
     but the changes remain in your working directory and are staged (ready to commit again).
     
3. Re-commit, then use `git reset --mixed` to go back one commit — what happens now?
  * `git reset --mixed` Moves HEAD back to the given commit. All commits after that point are removed from history, 
     but the changes remain in your working directory as unstaged. They show up in git diff and need to be added 
     again with git add before committing.
    
4. Re-commit, then use `git reset --hard` to go back one commit — what happens this time?
  * `git reset --hard` Moves HEAD back to the given commit. All commits after that point are removed from history, 
     and the changes are deleted completely from your working directory.
   
5. Answer in your notes:
   - What is the difference between `--soft`, `--mixed`, and `--hard`?
     * `--soft` - Removes commits but keeps changes still staged.
     * `--mixed` - Removes commits and keeps changes unstaged.
     * `--hard` - Removes commits and completely deletes changes.
   
   - Which one is destructive and why?
     * `--hard` is destructive because it permanently deletes history and changes.
   
   - When would you use each one?
     * `--soft` - to change commit message.
     * `--mixed` - to modify changes.
     * `--hard` - to remove all changes.
   
   - Should you ever use `git reset` on commits that are already pushed?
     * No, already pushed commits could have been pulled and used by other people so it will create confusion and conflicts.

---

## Task 2: Git Revert — Hands-On
specified
1. Make 3 commits (commit X, Y, Z)
2. Revert commit Y (the middle one) — what happens?
3. Check `git log` — is commit Y still in the history?
  * Yes, `git revert` adds a new commit that undoes the changes from specified commit and keeps the original commit.
4. Answer in your notes:
   - How is `git revert` different from `git reset`?
     * `git reset` rewrites history by removes the specified commit and undoing its changes. 
     * `git revert` doesn't rewrite history, it keeps original commit, and adds new commit that reverses its changes.
   - Why is revert considered **safer** than reset for shared branches?
     * Because it preserves history.
   - When would you use revert vs reset?
     * When you don't want to changes history use `revert`. If you want the commit to be deleted from history use `reset`.

---

## Task 3: Reset vs Revert — Summary

| | `git reset` | `git revert` |
|---|---|---|
| What it does | Rewrites history and undoes changes from the specified commit. | Preserves history, adds a new commit that reverses the specified commit’s changes. |
| Removes commit from history? | Yes | No |
| Safe for shared/pushed branches? | No | Yes |
| When to use | To completely remove commit and its changes. | To preserve history while safely undoing changes. |

---

## Task 4: Branching Strategies

1. **GitFlow** — 
   - **master** : Always reflects the production‑ready state.
   - **develop** : Always reflects a state with the latest delivered development changes for the next release.
   - **release** : Created from develop when the desired release state is met and assigned a release number. 
       Minor fixes can be made here. Eventually merged into both master and develop.
   - **feature** : Created from develop for new feature development. Merged back into develop once complete.
   - **hotfix** : Created from master to fix urgent bugs. Changes are merged back into both master and develop.

   - Used for a large team with scheduled releases.
   - Pros : Everything perfectly tracked.
   - Cons : Can be complex and difficult to manage.

    ![snapshot](gitflow.jpeg)

2. **GitHub Flow** — 
   - **main** : Production ready state.
   - **feature branches** : Created from main. Develop and test the feature, submit for review, approve, 
       and merge back into   main.
   - Ideal for continuous deployment/continuous delivery (CD) workflows.
   - Pros : Simple, lightweight.
   - Cons : Not properly structured. Can become messy if not disciplined, since everything merges directly into main. 
   
3. **Trunk-Based Development** — everyone commits to main, short-lived branches
   - **trunk/main** : The single branch where all developers commits frequently. Always reflects the latest working state.
   - **short lived feature branches** : Short lived branches created for a change, merged back quickly.
   - Ideal for startup.
   - Pros : Simple, fast.
   - Cons : Risky if anyone pushed unstable code directly to trunk.

4. Answer:
   - Which strategy would you use for a startup shipping fast?
     * Trunk Based
     
   - Which strategy would you use for a large team with scheduled releases?
     * Git Flow
     
   - Which one does your favorite open-source project use? (check any repo on GitHub)
     * Trunk Based

---


