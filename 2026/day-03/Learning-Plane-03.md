Today I focused on something very basic but very powerful — Linux commands.

What Is Linux Process management?
Linux process management is the operating system's core function of controlling and monitoring all running programs (processes) to ensure efficient resource utilization and system stability. This involves tasks such as process creation, scheduling, termination, and managing communication between processes.

Actually practice inside WSL and create my own cheat sheet.

🎯 Today’s Goal:
Build confidence with Linux commands in three areas:

✔ Process Management
✔ File System Handling
✔ Networking Troubleshooting

What I practiced:

🔹 Checked running processes using (ps, top,htop,df, df -h, df -ha, du, du -ah, du -sh, du -i, fdisk -l, free -h, free -m, free -g).
🔹 Killed processes using kill
🔹 Created, moved, deleted files and folders
🔹 Used ping, netstat, and curl for network troubleshooting

Consistency over perfection. 💪

#90DaysOfDevOps #Linux #DevOpsJourney #Trainwithshubham #WSL

2️⃣ Focused Areas:

1. Process Management

2. File System

3. Networking Troubleshooting

🔹 1. Process Management
View Running Processes
ps
ps -ef
<img width="827" height="371" alt="image" src="https://github.com/user-attachments/assets/06fc95bc-6ffb-4c63-ab8b-1274c13901f0" />

ps aux
top (Find Specific Process)
ps aux | grep nginx
pgrep nginx
pidof nginx

Kill Process
kill PID (Kill The process) 
kill -9 PID
pkill nginx

pstree (Check Process Tree)

<img width="487" height="610" alt="image" src="https://github.com/user-attachments/assets/f3536385-3a86-433f-936a-6e4b91a42b3a" />

🔹 2. File System Commands
Check Current Directory
pwd
List Files
ls
ls -l
ls -la
Create Files & Directories
mkdir testfolder
touch file1.txt
Copy / Move / Delete
cp file1.txt file2.txt
mv file2.txt newfile.txt
rm newfile.txt
rm -r testfolder
Check Disk Usage
df -h
du -sh *

🔹 3. Networking Troubleshooting
Check Connectivity
ping google.com
Check Open Ports
netstat -tulnp
Check IP Address
ip a
Test HTTP Request
curl google.com

Linux commands are simple when practiced daily.

Process management is important for production servers.

Networking troubleshooting is critical in DevOps.

3️⃣ Hashnode Blog (Long Form – Student Style)

Title:
Building My Linux Command Confidence – Real Practice Inside WSL

When I started learning DevOps, Linux looked scary.

Too many commands.
Too many options.
Too many things to remember.

But today I decided to stop overthinking and just practice.

Instead of copying commands from YouTube, I opened WSL and started typing commands myself.

My goal was simple:

👉 Build command confidence in:

Process Management

File System

Networking Troubleshooting

🐧 Process Management

First, I checked running processes:

ps
ps -ef
top

Seeing real processes running on my system made things practical.

Then I tried killing a process using:

kill PID

I understood the difference between normal kill and force kill (kill -9).

Now I feel more comfortable managing services.

📁 File System Practice

Then I moved to file system commands.

Created folders:
mkdir devops-practice

Created files:
touch notes.txt

Moved files:
mv

Deleted files:
rm

Earlier I was afraid of using rm.
Now I understand what I’m deleting.

🌐 Networking Troubleshooting

This part felt very important for DevOps.

I tested:

ping google.com
ip a
netstat -tulnp
curl google.com

Now I understand how to check:

Internet connectivity

IP address

Open ports

HTTP response
