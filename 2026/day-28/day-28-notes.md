# Day 28 – Revision Day: Everything from Day 1 to Day 27

## What You've Covered So Far

| Days | Topic | Key Concepts |
|------|-------|-------------|
| 1 | DevOps & Cloud Intro | What is DevOps, SDLC, Cloud basics |
| 2–7 | Linux Fundamentals | Architecture, commands, processes, systemd, file system hierarchy, troubleshooting, text files |
| 8 | Cloud Server Setup | Docker, Nginx, web deployment |
| 9–11 | Users, Permissions & Ownership | User/group management, file permissions, chown/chgrp |
| 12 | Revision Day 1 | Days 1–11 recap |
| 13 | Volume Management | LVM — physical volumes, volume groups, logical volumes |
| 14–15 | Networking | Fundamentals, DNS, IP, subnets, ports, hands-on checks |
| 16–18 | Shell Scripting | Basics, loops, arguments, error handling, functions |
| 19–20 | Shell Scripting Projects | Log rotation, backup, crontab, log analyzer |
| 21 | Shell Scripting Cheat Sheet | Personal reference guide |
| 22–25 | Git & GitHub | Init, branching, merge, rebase, stash, cherry pick, reset, revert, branching strategies |
| 26 | GitHub CLI | Managing GitHub from the terminal |
| 27 | GitHub Profile | Profile README, repo organization, developer branding |

---

## Challenge Tasks

### Task 1: Self-Assessment Checklist
Go through the checklist below. For each item, mark yourself honestly:
- **Can do confidently**

#### Linux
- ✅ Navigate the file system, create/move/delete files and directories
- ✅ Manage processes — list, kill, background/foreground
- ✅ Work with systemd — start, stop, enable, check status of services
- ✅ Read and edit text files using vi/vim or nano
- ✅ Troubleshoot CPU, memory, and disk issues using top, free, df, du
- ✅ Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
- ✅ Create users and groups, manage passwords
- ✅ Set file permissions using chmod (numeric and symbolic)
- ✅ Change file ownership with chown and chgrp
- ✅ Check network connectivity — ping, curl, netstat, ss, dig, nslookup
- ✅ Explain DNS resolution, IP addressing, subnets, and common ports

#### Shell Scripting
- [ ] Write a script with variables, arguments, and user input
- [ ] Use if/elif/else and case statements
- [ ] Write for, while, and until loops
- [ ] Define and call functions with arguments and return values
- [ ] Use grep, awk, sed, sort, uniq for text processing
- [ ] Handle errors with set -e, set -u, set -o pipefail, trap
- [ ] Schedule scripts with crontab

#### Git & GitHub
- ✅ Initialize a repo, stage, commit, and view history
- ✅ Create and switch branches
- ✅ Push to and pull from GitHub
- ✅ Explain clone vs fork
- ✅ Merge branches — understand fast-forward vs merge commit
- ✅ Rebase a branch and explain when to use it vs merge
- ✅ Use git stash and git stash pop
- ✅ Cherry-pick a commit from another branch
- ✅ Explain squash merge vs regular merge
- ✅ Use git reset (soft, mixed, hard) and git revert
- ✅ Explain GitFlow, GitHub Flow, and Trunk-Based Development
- ✅ Use GitHub CLI to create repos, PRs, and issues

- **Need to revisit**
- 🟥 Create and manage LVM volumes
- 🟥 Write a script with variables, arguments, and user input
- 🟥 Use if/elif/else and case statements
- 🟥 Write for, while, and until loops
- 🟥 Define and call functions with arguments and return values
- 🟥 Use grep, awk, sed, sort, uniq for text processing
- 🟥 Handle errors with set -e, set -u, set -o pipefail, trap
- 🟥 Schedule scripts with crontab

---

### Task 2: Revisit Your Weak Spots
1. Pick **3 topics** from the checklist where you marked "Need to revisit"
2. Go back to that day's challenge and redo the hands-on tasks
3. Document what you re-learned in `day-28-notes.md`

---

### Task 3: Quick-Fire Questions
Answer these from memory (no Googling). Then verify your answers:

1. What does `chmod 755 script.sh` do?
+ `chmod` helps to change mode 7 means `read` , `write`, `executable` for owner , 5 means `user` & `other` can `reads` and `write`
So, 7 (4+2+1) is full access, and 5 (4+1) is read and execute. After running this, if you type `ls -l`, you will see the permissions displayed as `-rwxr-xr-x`
```
4: Read (r)
2: Write (w)
1: Execute (x)
```
```
Owner (7): Can Read, Write, and Execute the script.
Group (5): Can Read and Execute, but cannot modify it.
Others (5): Can Read and Execute, but cannot modify it. 
```

2. What is the difference between a process and a service?
+ Process can be start/stop
+ But services can not be start/stop its running services in background.

3. How do you find which process is using port 8080?
+ netstat -tulp | grep : 8080

4. What does `set -euo pipefail` do in a shell script?
+ `e` - this will stop the script imidieatly after erorr occur
+ `u` - if any undefined erorr came
+ `o` pipefail - this will stop when any command inside the pipe fail

5. What is the difference between `git reset --hard` and `git revert`?
+ `git reset - hard` - will delete the commit and changes too
or
+ `git reset --hard` -  when you are working on a private branch and want to completely discard a mistake as if it never happened. It is destructive, so use it only for local changes that haven't been pushed to a remote.

+ `git revert` - this will not change the history
or
+ `git revert` - when you need to undo changes on a public or shared branch. Because it adds a new commit instead of erasing old ones, it won't break the history for your teammates. create a new commit that undoes the changes.

6. What branching strategy would you recommend for a team of 5 developers shipping weekly?
+ `GitHub Flow` is highly recommended because it is simple, reduces merge conflicts, and encourages frequent communication

7. What does `git stash` do and when would you use it?
+ git stash will hide changes for temporarly.
+ this can be use while you are working on something and dont want to commit it or make changes.

8. How do you schedule a script to run every day at 3 AM?
+ Open your terminal.
Type `crontab -e` to edit your schedule.
Add the following line to run at 3 AM every day:
`0 3 * * * /path/to/your/script.sh`
Syntax Breakdown:

```
`0` : Minute (0)
`3` : Hour (3 AM)
`*` : Every day of the month
`*` : Every month
`*` : Every day of the week
```
Save and exit (for vim, press Esc, then type :wq and hit Enter).

9. What is the difference between `git fetch` and `git pull`?
+ `git fetch` - use for downloading changes without merging it
+ `git pull` - use for fetch and merge

10. What is LVM and why would you use it instead of regular partitions?
+ `LVM` (Logical Volume Manager) - lvm resize volumes, combine disks, and take snapshots without downtime

---

### Task 5: Teach It Back
Pick **one topic** you've learned and write a short explanation (5-10 lines) as if you're teaching it to someone who has never heard of it. Add it to your `day-28-notes.md`.

Examples:
- Explain Git branching to a non-developer
- Explain file permissions to a new Linux user
- Explain what a crontab is and why sysadmins use it

# Explain What is lvm?
+ LVM (Logical Volume Manager) is a way to manage computer storage smartly.
+ In normal systems, storage is fixed.
+ If one part becomes full, we cannot change it easily.
+ LVM allows us to increase or decrease space anytime without stopping the system. That’s why it is very useful for servers.
   - we can create the storage usiing these three :
     + Physical volume
       - suppose we create three space (volume)
     + Vloume group
       - now we combined it by group
     + logical volume
       - by that group we created we will make logical vloume means this will break the space to use

---

**Teaching is the best test of understanding.**

---

Happy Learning!
**TrainWithShubham**
