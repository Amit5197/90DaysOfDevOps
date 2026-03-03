# Day 05 – Linux Troubleshooting Drill: CPU, Memory, and Logs
Task - Today’s goal is to run a focused troubleshooting drill.

You will pick a running process/service on your system and:

Capture a quick health snapshot (CPU, memory, disk, network)
Trace logs for that service
Write a mini runbook describing what you did and what you’d do next if things were worse
Hands-on with Linux Processes & Logs today. 🖥️

It’s one thing to use a service, but understanding how to track its specific process IDs and audit its logs is a whole different level of control.

# Today's practice involved: 
🔹 #pgrep: Tracking specific process IDs to see what's really running. 
🔹 #systemctl status ssh: The command center for inspecting and managing system health.
<img width="1881" height="427" alt="image" src="https://github.com/user-attachments/assets/f62adfca-d060-4858-a08c-56afd70514ce" />

🔹 #journalctl -u ssh -n 20: Viewing the latest service logs for troubleshooting. 
<img width="1890" height="480" alt="image" src="https://github.com/user-attachments/assets/2e7cf62d-a12c-4952-b8b5-510c7c799457" />

🔹 #tail -n 30 /var/log/auth.log: Auditing security logs to catch authentication events.
<img width="1882" height="733" alt="image" src="https://github.com/user-attachments/assets/f208db83-1e8b-4877-9425-a358003b66e0" />

# Also Done Practice- Docker Install (Start/Stop) Process->
# systemd commands with output ##
# lsb_release -a -check operating system information
<img width="595" height="201" alt="image" src="https://github.com/user-attachments/assets/aec4fb09-7a0e-41b0-b259-045ca06ba280" />

# sudo apt update - done with checking install updates of ubuntu by doing this command
<img width="940" height="327" alt="image" src="https://github.com/user-attachments/assets/a5cebea5-b982-4fc9-86ac-6cf8145fd78c" />

# sudo apt install docker.io -after updating install the softwere which is docker
 <img width="940" height="368" alt="image" src="https://github.com/user-attachments/assets/87900cd3-8342-4007-b263-d157fef0214d" />

# sudo systemctl start docker -to start docker service
 <img width="940" height="368" alt="image" src="https://github.com/user-attachments/assets/17b8d139-497c-4c46-9aed-aa004c6702ab" />

# sudo systemctl status docker -to see docker is started or not
 <img width="940" height="274" alt="image" src="https://github.com/user-attachments/assets/b6357c8f-c20a-4700-839d-738fae0b916d" />

# sudo systemctl disable docker (to see docker is started or not)
#sudo systemctl stop docker.socket (for stop docker services)
#sudo systemctl stop docker (to see docker is started or not)
<img width="940" height="251" alt="image" src="https://github.com/user-attachments/assets/979c0ddd-3b76-4f10-af4e-fe04641a1007" />

My Key Takeaways 📝

1.SSH isn't just one static thing—it creates multiple processes per user session.

2.Logs aren't just text files; they are your best friend for troubleshooting and security auditing. 🔐

# Capture a quick health snapshot (CPU, memory, disk, network) (Refer- 01-04) Repository.
