# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

## Task
Apply everything from Days 16–18 in real-world mini projects.

You will:
- Write a **log rotation** script
- Write a **server backup** script
- Schedule them with **crontab**

---

## Expected Output
- A markdown file: `day-19-project.md`
- All scripts you write during the tasks

---

## Challenge Tasks

### Task 1: Log Rotation Script
Create `log_rotate.sh` that:
1. Takes a log directory as an argument (e.g., `/var/log/myapp`)
2. Compresses `.log` files older than 7 days using `gzip`
3. Deletes `.gz` files older than 30 days
4. Prints how many files were compressed and deleted
5. Exits with an error if the directory doesn't exist

#Output
1. we need to ensure the directory exists and that the files have "old" timestamps. If we just touch them now, they will be 0 days old, and the script won't find anything to compress or delete!

# Create the directory
sudo mkdir -p /var/log/myapp

# Create the files
sudo touch /var/log/myapp/text1.log /var/log/myapp/text2.log /var/log/myapp/text3.log /var/log/myapp/text4.log /var/log/myapp/text5.log

2. Backdate the Files (Crucial Step)
Since your script looks for files older than 7 days, we need to "trick" the system into thinking these files were created a long time ago using the touch -d command.

# Set these to 10 days ago so the script catches them
sudo touch -d "10 days ago" /var/log/myapp/text1.log /var/log/myapp/text2.log /var/log/myapp/text3.log /var/log/myapp/text4.log /var/log/myapp/text5.log

3. Verify the Setup
Before running your script, you can check the timestamps of your new files to make sure they look "old" to the system:

```
ls -l /var/log/myapp
```
4. Run your Script
Now that the files exist and are "old" enough, run your script. Note that since /var/log is a system directory, you will likely need to use sudo to give the script permission to modify files there:

```
sudo ./log_rotate.sh /var/log/myapp
```
What should happen:
The script will see the 5 .log files.
It will compress them into .log.gz files.
It will print: Files compressed (.log > 7 days): 5.

* To see the script work perfectly from start to finish, I recommend clearing the folder and creating only the .log files first. Run these commands:
* # 1. Clear the folder so it's fresh
sudo rm /var/log/myapp/*

# 2. Create only the .log files
sudo touch /var/log/myapp/text{1..5}.log

# 3. Backdate them so the script sees them as "Old"
sudo touch -d "10 days ago" /var/log/myapp/text{1..5}.log

Now, Run Your Script
Once the folder only contains the 5 .log files, execute your script:

```sudo ./log_rotate.sh /var/log/myapp
```
What you should see after running it:

The console should print: Files compressed (.log > 7 days): 5.

If you run ls /var/log/myapp, the .log files will be gone, and you will only see text1.log.gz through text5.log.gz.

<img width="1902" height="478" alt="image" src="https://github.com/user-attachments/assets/e2819130-d4fb-46c5-9cd5-290929dc2885" />

---

### Task 2: Server Backup Script
Create `backup.sh` that:
1. Takes a source directory and backup destination as arguments
2. Creates a timestamped `.tar.gz` archive (e.g., `backup-2026-02-08.tar.gz`)
3. Verifies the archive was created successfully
4. Prints archive name and size
5. Deletes backups older than 14 days from the destination
6. Handles errors — exit if source doesn't exist

### Output:
* This script is a classic "Set and Forget" backup utility. It uses tar for archiving and includes a verification step to ensure your data is actually safe before it starts cleaning up old files.
* The Backup Script (backup.sh)

**Create the file: nano backup.sh and paste the code.
Permissions: chmod +x backup.sh
Run it: ```` ./backup.sh /var/log/myapp /home/ubuntu/backups ```**

<img width="1026" height="487" alt="image" src="https://github.com/user-attachments/assets/cddd35ae-71c9-4b79-99e7-d674ae38cc01" />

---

### Task 3: Crontab
1. Read: `crontab -l` — what's currently scheduled?
2. Understand cron syntax:
   ```
   * * * * *  command
   │ │ │ │ │
   │ │ │ │ └── Day of week (0-7)
   │ │ │ └──── Month (1-12)
   │ │ └────── Day of month (1-31)
   │ └──────── Hour (0-23)
   └────────── Minute (0-59)
   ```
3. Write cron entries (in your markdown, don't apply if unsure) for:
   - Run `log_rotate.sh` every day at 2 AM
   - Run `backup.sh` every Sunday at 3 AM
   - Run a health check script every 5 minutes
  
### Output

1. Reading your current schedule- To see what is already running on your user account, run-
``` crontab -l ``` output- ``` no crontab for ubuntu ```


---

### Task 4: Combine — Scheduled Maintenance Script
Create `maintenance.sh` that:
1. Calls your log rotation function
2. Calls your backup function
3. Logs all output to `/var/log/maintenance.log` with timestamps
4. Write the cron entry to run it daily at 1 AM

---

## Hints
- Compress old files: `find /path -name "*.log" -mtime +7 -exec gzip {} \;`
- Timestamp: `date +%Y-%m-%d`
- Tar: `tar -czf backup.tar.gz /source/dir`
- Cron edit: `crontab -e`
- Log with timestamp: `echo "$(date): message" >> logfile`

---

## What I learned

* Validation: Used if [ ! -d "$DIR" ] to prevent scripts from running on missing paths.

* Arguments: Mastered $1,$2,$# to create dynamic,reusable scripts.

* Advanced File Handling: find command: Combined -mtime, -exec, and -delete for automated file cleanup.

* Compression: Used tar and gzip to compress large files and keep the server from running out of disk space.

* Understood the cron syntax (* * * * *) to schedule tasks during off-peak hours (e.g., 1 AM `0 1 * * *` )  .

* Combined log rotation and backups into one maintenance.sh script to keep the crontab organized and easy to manage.

* Tee Command: Implemented tee to view real-time output while saving to a log file.

