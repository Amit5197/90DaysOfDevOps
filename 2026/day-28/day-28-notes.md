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
- **Need to revisit**
- **Haven't done yet**

#### Linux
- [x] Navigate the file system, create/move/delete files and directories
- [x] Manage processes — list, kill, background/foreground
- [x] Work with systemd — start, stop, enable, check status of services
- [x] Read and edit text files using vi/vim or nano
- [x] Troubleshoot CPU, memory, and disk issues using top, free, df, du
- [x] Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
- [x] Create users and groups, manage passwords
- [x] Set file permissions using chmod (numeric and symbolic)
- [x] Change file ownership with chown and chgrp
- [x] Create and manage LVM volumes
- [x] Check network connectivity — ping, curl, netstat, ss, dig, nslookup
- [x] Explain DNS resolution, IP addressing, subnets, and common ports

#### Shell Scripting
- [x] Write a script with variables, arguments, and user input
- [x] Use if/elif/else and case statements
- [x] Write for, while, and until loops
- [x] Define and call functions with arguments and return values
- [x] Use grep, awk, sed, sort, uniq for text processing
- [x] Handle errors with set -e, set -u, set -o pipefail, trap
- [x] Schedule scripts with crontab

#### Git & GitHub
- [x] Initialize a repo, stage, commit, and view history
- [x] Create and switch branches
- [x] Push to and pull from GitHub
- [x] Explain clone vs fork
- [x] Merge branches — understand fast-forward vs merge commit
- [x] Rebase a branch and explain when to use it vs merge
- [x] Use git stash and git stash pop
- [x] Cherry-pick a commit from another branch
- [x] Explain squash merge vs regular merge
- [x] Use git reset (soft, mixed, hard) and git revert
- [x] Explain GitFlow, GitHub Flow, and Trunk-Based Development
- [x] Use GitHub CLI to create repos, PRs, and issues

---

### Task 2: Revisit Your Weak Spots

#### Revisited DNS resolution, IP addressing, subnets
* Revisioned about DNS and subnests.

---

### Task 3: Quick-Fire Questions
Answer these from memory (no Googling). Then verify your answers:

1. What does `chmod 755 script.sh` do?
* Give execute permission to file - rwxr-xr-x

2. What is the difference between a process and a service?
* A process is an instance of a running program. Start when you run a command/program and stops when it finishes.
  Ex:(ls,script.sh,top,chrome).
* A service is also a process but it runs in the background and is managed by systemd and are often started 
  automatically on boot, they support ongoing functionality to your system, long running processes.
  Ex:(ssh,cron,nginx).

3. How do you find which process is using port 8080?
* `sudo netstat -tulpn | grep 8080`

4. What does `set -euo pipefail` do in a shell script?
*     `set -e` - Exit on error
      `set -u` - Undefined variable error
      `set -o pipefail` - Exit when one ouput from pipe fails
      
5. What is the difference between `git reset --hard` and `git revert`?
* `git reset --hard` - Deletes evry commit until the specified commit and its changes from working directory.
* `git revert` - Adds a commit that undoes the changes until the given commit also keeps the original commit.

6. What branching strategy would you recommend for a team of 5 developers shipping weekly?
* Trunk-based development

7. What does `git stash` do and when would you use it?
* It is used to temporarily store your uncommited changes in stash, when you have sone urgent fix to do so you use git `stash`.

8. How do you schedule a script to run every day at 3 AM?
* add in crontab file - `0 3 * * *`

9. What is the difference between `git fetch` and `git pull`?
* `git fetch` - gets all the changes of remote but doesn't merge them.
* `git pull` - gets all the changes from specified branch of remote and merges them.

10. What is LVM and why would you use it instead of regular partitions?
* `Logical Volume Manager` - It allows flexible storage management. First you attach a volume create a PV(physical volume) then
  VG(volume group) then from VG you create LV(Logical Volume) that can be increased or decreased according to needs.
  Unlike regular partition that are fixed. If you want to increase regular partition you attach a new volume and use it.

---

### Task 4: Organize Your Work
1. [x] Make sure all your daily submissions (day-1 through day-27) are committed and pushed 
2. [x] Check that your `git-commands.md` is up to date
3. [x] Check that your shell scripting cheat sheet is complete 
4. [x] Verify your GitHub profile and repos are clean (from Day 27) 

---

### Task 5: Teach It Back

## Topic
* DNS resolution - 
     When you search any domain(www.example.com) it searches locally in cache for its ip address, If not present
     then it sends a request to DNS requesting IP address. DNS send the ip address back, your system connects to
     the domain using that ip address.
* Subnets - 
     Subnets are created using CIDR. Subnets are needed to divide large network into smaller, manageable network.
     192.168.1.0/24 - This means we can use last 8 bits to create IP addresses, total would b 256.

---

