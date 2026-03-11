# Task- 06 
# Day 06 – Linux Fundamentals: Read and Write Text Files
Task - This is a continuation of Day 05, but much simpler.

# Today’s goal is to practice basic file read/write using only fundamental commands.
01- You will create a small text file and practice:
02- Creating a file
03- Writing text to a file
04- Appending new lines
05- Reading the file back

Keep it basic and repeatable........!!!!!

# Expected Output
# 01- Create a new folder (using cmd- sudo mkdir devops)
after created new folder create a new text editing find (.txt)

<img width="1456" height="387" alt="image" src="https://github.com/user-attachments/assets/3fbb2e85-1e83-472d-ada4-24747bc59732" />

# 02- Using cmd for create a (.txt) file - touch dev.txt 

<img width="448" height="111" alt="image" src="https://github.com/user-attachments/assets/1a3fa265-a6fc-4217-b1f4-99e39e73157a" />

# 03- Writing text to a file

After creating a new txt file- writing some text in a txt file.
using cmd - #Vi or Vim dev.txt (.txt file_name) and use press (i) for writing and for exit press (esc) firt and use (:wq) for exit.
and using cmd- (#Cat dev.txt) for display- writing text in a file 

<img width="711" height="268" alt="image" src="https://github.com/user-attachments/assets/23d5f757-d83f-4030-9a10-ed09acd709ed" />

Append using cmd (tee) (write and display at the same time)
: echo "Practicing tee command" | tee -a notes.txt 

note : -a : append mode , without -a it overwrites.

<img width="500" height="321" alt="image" src="https://github.com/user-attachments/assets/2479b0d7-fdfc-4d86-ae48-d0fe0f6a663e" />

# 04- Appending new lines

Add more Lines use cmd : echo "Reading file using cat" >> dev.txt

cmd - (#echo "Reading first lines using head" >> dev.txt)
cmd - (#echo "Reading last lines using tail" >> dev.txt

Using echo: The echo command prints a string and, by default, adds a newline character at the end. The >> operator appends the output to the specified file.
cmd (#echo "This is a new line of text" >> dev.txt)

Using printf: This command offers more control over formatting and is more portable across different shells than echo -e. You must explicitly include the newline escape sequence \n.
cmd (#printf "Another line of text\n" >> dev.txt)

<img width="838" height="533" alt="image" src="https://github.com/user-attachments/assets/36e3a627-99cf-4aa2-b061-fb57bcc3d7b2" />


# 05- Reading the file back

To read first 1 lines use cmd : (head -n 1 dev.txt)
To read last 1 lines use cmd :  (tail -n 1 ndev.txt)

<img width="576" height="247" alt="image" src="https://github.com/user-attachments/assets/0ae1bd7e-960c-4e5f-a0ca-a9657ccb2bfa" />

# Today0 I have install my First Nginx server 

Here is the process which is i ahve used with my AWS EC2 console.

Setting up Nginx on an AWS EC2 instance is a standard way to host web applications. This guide assumes you are using an Amazon Linux 2023 or Ubuntu instance.
Step 1: Connect to your EC2 Instance
Step 2: Update Packages and Install Nginx
sudo apt install nginx -y
Step 3: Start and Enable Nginx
# Start Nginx (#sudo systemctl start nginx)
# Enable Nginx to start on boot (#sudo systemctl enable nginx)
# Verify the status (#sudo systemctl status nginx)

#Step 4: Configure AWS Security Group
** Your Nginx server is now running, but AWS blocks external traffic by default. You must open Port 80.
Go to the EC2 Dashboard in the AWS Console.
Select your Instance and click the Security tab.
Click on the Security Groups ID.
Click Edit inbound rules.
Add a new rule:
Type: HTTP
Protocol: TCP
Port Range: 80
Source: 0.0.0.0/0 (This allows everyone to see your site).
Click Save rules. ** 
Step 5: Verify the Installation
Open your web browser and enter your EC2 instance's Public IPv4 address. You should see the "Welcome to nginx!" default page.

<img width="1628" height="472" alt="image" src="https://github.com/user-attachments/assets/5c1494f8-7751-43ac-a115-7bd6c28767b9" />

# Useful Management Commands

# Stop Nginx: sudo systemctl stop nginx
# Restart Nginx: sudo systemctl restart nginx (Use this after changing config files)
# Check Config for Errors: sudo nginx -t



