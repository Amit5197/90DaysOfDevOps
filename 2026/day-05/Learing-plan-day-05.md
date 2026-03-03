
Hands-on with Linux Processes & Logs today. 🖥️

It’s one thing to use a service, but understanding how to track its specific process IDs and audit its logs is a whole different level of control.

Today's practice involved: 
🔹 #pgrep: Tracking specific process IDs to see what's really running. 
🔹 #systemctl status ssh: The command center for inspecting and managing system health.

🔹 #journalctl -u ssh -n 20: Viewing the latest service logs for troubleshooting. 

🔹 #tail -n 30 /var/log/auth.log: Auditing security logs to catch authentication events.

My Key Takeaways 📝

1.SSH isn't just one static thing—it creates multiple processes per user session.

2.Logs aren't just text files; they are your best friend for troubleshooting and security auditing. 🔐
