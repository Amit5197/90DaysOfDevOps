#Task-04
Today’s goal is to practice Linux fundamentals with real commands.

You will create a short practice note by actually running basic commands and capturing what you see:

1. Check running processes
2. Inspect one systemd service
3. Capture a small troubleshooting flow

##OutCome expected->

# Linux Practice – Process, Service & Log Commands

This note covers basic Linux process commands, systemd service commands, and log inspection. It also demonstrates what actually happens when a service is restarted.

---

## 1️ Process Commands

| Command | Simple Definition |
|----------|-------------------|
| `ps` | Displays currently running processes. |
| `top` | Shows real-time system resource usage and running processes. |
| `htop` | Interactive and improved version of `top`. |
| `pgrep <name>` | Finds the Process ID (PID) of a running process by name. |

---

## 2️ Service Commands (systemd)

| Command | Simple Definition |
|----------|-------------------|
| `systemctl status <service>` | Shows whether a service is running and displays its Main PID and logs. |
| `systemctl list-units --type=service` | Lists all active system services. |
| `sudo systemctl restart <service>` | Stops the service and starts it again. |

---

## 3️ Log Commands

| Command | Simple Definition |
|----------|-------------------|
| `journalctl -u <service>` | Displays logs for a specific service. |
| `tail -n 50 <file>` | Shows the last 50 lines of a log file. |
| `journalctl -f` | Shows logs in real time (live monitoring). |

---

while inspecting the SSH service, I realized that restarting a service doesn’t just refresh it , it actually kills the old Process ID (PID) and spawns a new one. Watching the PID change in real time made me understand what restart truly means at the process level.

 you can also explore this by entering :  (  command : systemctl status ssh now you can look for this line -  Main PID: 1234 (sshd) ) 

👉 Note down that PID number.

now lets Restart the service : sudo systemctl restart ssh ,  now this command stops the service, kills the current process , starts a new process.

 now lets check the PID again : use this command ( systemctl status ssh ) now you can see Main PID: 1458 (sshd)

<img width="1900" height="752" alt="image" src="https://github.com/user-attachments/assets/e2ddca66-ca0d-40c8-816f-30594075a8eb" />
<img width="1875" height="730" alt="image" src="https://github.com/user-attachments/assets/e168cb1c-e1ec-4603-be81-6697dd931a5a" />
<img width="1893" height="778" alt="image" src="https://github.com/user-attachments/assets/8325c21e-f6a1-410f-98eb-48e057bec289" />
<img width="1911" height="772" alt="image" src="https://github.com/user-attachments/assets/654f94a9-af4c-4beb-a30d-2c66ee417668" />

The PID will be different.
