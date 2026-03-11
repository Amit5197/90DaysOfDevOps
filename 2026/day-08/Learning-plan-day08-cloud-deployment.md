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

---

### Part 2: Install Docker & Nginx

**Step 1: Update System**

**Step 3: Install Nginx**

**Verify Nginx is running:**

---

### Part 3: Security Group Configuration

**Test Web Access:**
Open browser and visit: `http://<your-instance-ip>`

You should see the **Nginx welcome page**!

📸 **Screenshot this page** - you'll need it for submission

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

---

## What I Learned

**As a Learner i have launch EC2 cloud instance and connect with ssh and install NGINX server.
Deploy Nginx server with the help of AWS free tied account.
Verify with webpage and also Configure security groups for web access (port 80 by default for nginx)** 

## Why This Matters for DevOps

This exercise teaches you:
- **Cloud infrastructure provisioning** - launching and configuring servers
- **Remote server management** - SSH, security, access control
- **Service deployment** - installing and running applications
- **Log management** - accessing and analyzing logs
- **Security** - configuring firewalls and security groups

# These are core skills for any DevOps engineer working in production.
