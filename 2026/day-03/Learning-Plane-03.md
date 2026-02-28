Task-03
Today’s goal is to build your Linux command confidence.

You will create a cheat sheet of commands focused on:

Process management
File system
Networking troubleshooting

What Is Linux Process management?
Linux process management is the operating system's core function of controlling and monitoring all running programs (processes) to ensure efficient resource utilization and system stability. This involves tasks such as process creation, scheduling, termination, and managing communication between processes.

# Linux 🐧 Command Cheat Sheet
1- Process Management
2- File system
3- Networking troubleshooting

## ⚙️ Process Management
**Manage system resources, view running tasks, and control process execution.**

| Command | Usage Example | Description |
| :--- | :--- | :--- |
| **`ps`** | `ps aux` | Displays a detailed snapshot of all currently running processes. |
| **`top`** | `top` | Shows real-time system statistics and a dynamic list of processes. |
| **`htop`** | `htop` | An interactive, colorful process viewer. |
| **`kill`** | `kill 1234` | Terminates the process with PID `1234`. |
| **`killall`** | `killall firefox` | Kills all processes named "firefox". |
| **`pkill`** | `pkill -u user` | Signals processes based on name or other attributes (e.g., specific user). |
| **`bg`** | `bg %1` | Resumes a suspended job in the background. |
| **`fg`** | `fg %1` | Brings a background job to the foreground. |
| **`du -ah`** | `du -ah` | Show disk usages of current directory. |
| **`free -h`** | `free -h` | Display Free and used memory in Human redable units. |

## 📂 File System
**Navigate directories, manipulate files, and manage permissions.**

| Command | Usage Example | Description |
| :--- | :--- | :--- |
| **`ls`** | `ls -lah` | Lists directory contents with details, including hidden files. |
| **`cd`** | `cd /var/log` | Changes the current working directory. |
| **`pwd`** | `pwd` | Prints the full path of the current working directory. |
| **`cp`** | `cp -r source dest` | Copies files or directories recursively. |
| **`mv`** | `mv file.txt new.txt` | Moves or renames files and directories. |
| **`rm`** | `rm -rf dir_name` | Removes files or directories (use caution with `-rf`). |
| **`mkdir`** | `mkdir -p /a/b/c` | Creates a new directory (and parent directories). |
| **`chmod`** | `chmod 755 script.sh` | Changes file access permissions (read, write, execute). |
| **`chown`** | `chown user:group file` | Changes file owner and group. |
| **`df`** | `df -h` | Displays disk space usage for file systems in human-readable format. |
| **`du`** | `du -sh folder` | Estimates file space usage for a specific directory. |

## 🌐 Networking Troubleshooting
**Diagnose connectivity issues, check configurations, and transfer data.**

| Command | Usage Example | Description |
| :--- | :--- | :--- |
| **`ip addr`** | `ip addr show` | Displays IP addresses and network interface properties. |
| **`ping`** | `ping -c 100 google.com` | Checks connectivity to a host by sending ICMP echo requests. |
| **`curl`** | `curl -I https://example.com` | Transfers data from or to a server; `-I` fetches headers only. |
| **`dig`** | `dig google.com` | DNS lookup utility to query DNS name servers. |
| **`traceroute`** | `traceroute google.com` | Traces the route packets take to a network host. |

🎯 Today’s Goal:

✔ Process Management
✔ File System Handling
✔ Networking Troubleshooting

What I practiced:

🔹 Checked running processes using (ps, top,htop,df, df -h, df -ha, du, du -ah, du -sh, du -i, fdisk -l, free -h, free -m, free -g).
🔹 Killed processes using kill
🔹 Created, moved, deleted files and folders
🔹 Used ping, netstat, and curl for network troubleshooting
