# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

## Task
Today's goal is to **deploy a real web server on the cloud** and learn practical server management.

You will:
- Launch a cloud instance (AWS EC2 or Utho)
- Connect via SSH
- Install Nginx
- Configure security groups for web access (port 80 by default for nginx)
- Extract and save logs to a file
- Verify your webpage is accessible from the internet

This is real DevOps work - exactly what you'll do in production.

---

## Expected Output

## Prerequisites
- AWS account (Free Tier) OR Utho account
- Basic understanding of Linux commands (Days 1-7)
- SSH client (Terminal on Mac/Linux, PuTTY on Windows)

---

## Guidelines

### Part 1: Launch Cloud Instance & SSH Access

**Step 1: Create a Cloud Instance**

**Step 2: Connect via SSH**


<img width="1898" height="361" alt="image" src="https://github.com/user-attachments/assets/c55d8a33-0346-453a-8063-9fba9bd7e5d1" />

<img width="1916" height="348" alt="image" src="https://github.com/user-attachments/assets/559f9694-105d-4a12-9503-ece46d07c147" />

---

### Part 2: Install Docker & Nginx

**Step 1: Update System**

**Step 3: Install Nginx**

**Verify Nginx is running:**

<img width="1907" height="616" alt="image" src="https://github.com/user-attachments/assets/b37327fe-79d9-40f3-a578-a707d18a04c7" />

---

### Part 3: Security Group Configuration

**Test Web Access:**
Open browser and visit: `http://<your-instance-ip>`

You should see the **Nginx welcome page**!

<img width="1507" height="407" alt="image" src="https://github.com/user-attachments/assets/d77625a5-1652-48eb-9713-d478bded7f1f" />

---

### Part 4: Extract Nginx Logs

**Step 1: View Nginx Logs**

**Step 2: Save Logs to File**

**Step 3: Download Log File to Your Local Machine**

# On your local machine (new terminal window)
# For AWS:
scp -i your-key.pem ubuntu@<your-instance-ip>:~/nginx-logs.txt .

# For Utho:
scp root@<your-instance-ip>:~/nginx-logs.txt .

# To see the most recent errors:

<img width="1901" height="248" alt="image" src="https://github.com/user-attachments/assets/ba33a82e-ebe7-4b28-832d-872c1e1e7bb1" />

# To see the last 100 0r more visitors:

<img width="1900" height="296" alt="image" src="https://github.com/user-attachments/assets/c9ab10e2-b714-45a8-90be-4b4b180d192f" />

# Step 2: Save Logs to a Portable File

Because the system logs in /var/log/ are owned by root, your SSH user (like ec2-user or ubuntu) usually doesn't have permission to download them directly. You need to copy them to your home directory first.

# Create a copy in your home folder:

**sudo cp /var/log/nginx/access.log ~/my_nginx_access.log**

# Change the ownership so you can "grab" it:

**sudo chown $USER:$USER ~/my_nginx_access.log**

# Verify the file exists:

**ls -lh ~/my_nginx_access.log**

<img width="978" height="122" alt="image" src="https://github.com/user-attachments/assets/8a76cc2b-5e6e-44d7-a42d-dfa94e7d00e5" />

---

## What I Learned

**As a Learner i have launch EC2 cloud instance and connect with ssh and install NGINX server.
Deploy Nginx server with the help of AWS free tier account.
Verify with webpage and also Configure security groups for web access (port 80 by default for nginx)** 

## Why This Matters for DevOps

This exercise teaches you:
- **Cloud infrastructure provisioning** - launching and configuring servers
- **Remote server management** - SSH, security, access control
- **Service deployment** - installing and running applications
- **Log management** - accessing and analyzing logs
- **Security** - configuring firewalls and security groups

# These are core skills for any DevOps engineer working in production.
