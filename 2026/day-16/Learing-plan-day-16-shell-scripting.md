# Day 16 – Shell Scripting Basics

## Task
Start your shell scripting journey — learn the fundamentals every script needs.

You will:
- Understand **shebang** (`#!/bin/bash`) and why it matters
- Work with **variables**, **echo**, and **read**
- Write basic **if-else** conditions

---

## Expected Output
- A markdown file: `day-16-shell-scripting.md`
- All scripts you write during the tasks

---

## Challenge Tasks

### Task 1: Your First Script
1. Create a file `hello.sh`
2. Add the shebang line `#!/bin/bash` at the top
3. Print `Hello, DevOps!` using `echo`
4. Make it executable and run it

```bash
chmod +x hello.sh
./hello.sh
```

<img width="805" height="563" alt="image" src="https://github.com/user-attachments/assets/f3161079-73da-44ad-aa04-f382f2e84671" />

**Document:** What happens if you remove the shebang line?

[Script](scripts/hello.sh)

* What happens if you remove the shebang line?
 - The script runs after removing shebang line :
    - `./hello.sh` - The kernel checks for a shebang to identify the interpreter ("Shebang" tells the comuter to use Bash to read the script and "Echo" command tells it to print the text. If no shebang is found, the script is executed using the current shell.
    - `bash hello.sh` - The script is explicitly executed by the Bash shell,independent of the presence of a shebang.
    - `sh hello.sh` - The script is executed using the `sh shell`,which may differ in behavior from bash
---

### Task 2: Variables
1. Create `variables.sh` with:
   - A variable for your `NAME`
   - A variable for your `ROLE` (e.g., "DevOps Engineer")
   - Print: `Hello, I am <NAME> and I am a <ROLE>`
2. Try using single quotes vs double quotes — what's the difference?
* Using double quote `" "` - Allow **variable expansion**
* Using single quote `' '` - Treat every character exactly as written
  
<img width="726" height="132" alt="image" src="https://github.com/user-attachments/assets/0af46d30-5dba-4872-b0b6-be2ffb1707c4" />

<img width="712" height="652" alt="image" src="https://github.com/user-attachments/assets/47e75a38-928f-4d80-b90f-bb14a0c419fa" />

---

### Task 3: User Input with read
1. Create `greet.sh` that:
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, your favourite tool is <tool>`

<img width="747" height="331" alt="image" src="https://github.com/user-attachments/assets/bf4f193b-c907-4829-aea4-a30a115fe0ea" />

<img width="1336" height="621" alt="image" src="https://github.com/user-attachments/assets/0fddc108-d908-4761-8e97-5907783275f0" />

---

### Task 4: If-Else Conditions
1. Create `check_number.sh` that:
   - Takes a number using `read`
   - Prints whether it is **positive**, **negative**, or **zero**

2. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file **exists** using `-f`
   - Prints appropriate message

<img width="760" height="270" alt="image" src="https://github.com/user-attachments/assets/8711920a-dba5-4085-9510-13d178a2fadc" />

<img width="1918" height="678" alt="image" src="https://github.com/user-attachments/assets/a4bb734a-289f-4d19-86e9-f8e6cb979031" />

<img width="1057" height="698" alt="image" src="https://github.com/user-attachments/assets/43cf6d55-4805-4d25-ac39-50e7b0e4cf48" />

<img width="756" height="222" alt="image" src="https://github.com/user-attachments/assets/2f46f766-7776-4c35-b973-3cb021641640" />

---

### Task 5: Combine It All
Create `server_check.sh` that:
1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's **active** or **not**
4. If `n` — prints "Skipped."

<img width="1110" height="300" alt="image" src="https://github.com/user-attachments/assets/03302ae3-1410-4f65-8cf0-b15c5c78766f" />

<img width="861" height="682" alt="image" src="https://github.com/user-attachments/assets/7ee779d7-7d99-45be-b0ce-3d07bfead0f7" />

---

## Hints
- Shebang: `#!/bin/bash` tells the system which interpreter to use
- Variables: `NAME="Shubham"` (no spaces around `=`)
- Read: `read -p "Enter name: " NAME`
- If syntax: `if [ condition ]; then ... elif ... else ... fi`
- File check: `if [ -f filename ]; then`

---

## What I Have learned:
* How to write and execute Bash shell scripts using the shebang (#!/bin/bash),variables,and user input with read.
* How variable assignment works in Bash,including accessing variables with $ and understanding single vs double quotes.
* How to control script flow using conditional statements (if, elif, else) and test operators (-f, -gt, -lt).
* How to check file existence and numeric conditions inside shell scripts.
* How to suppress command output using redirection (> /dev/null ).
* How to use systemctl is-active to programmatically check whether a service is running instead of relying on verbose status output.

