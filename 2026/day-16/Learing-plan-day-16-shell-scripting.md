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

<img width="682" height="251" alt="image" src="https://github.com/user-attachments/assets/1684eeaf-7231-4999-b9ae-a1cbef786f5b" />

---

### Task 3: User Input with read
1. Create `greet.sh` that:
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, your favourite tool is <tool>`

<img width="735" height="256" alt="image" src="https://github.com/user-attachments/assets/6820018a-19c1-4250-ad64-6a218bbf8183" />
<img width="1593" height="825" alt="image" src="https://github.com/user-attachments/assets/2a042259-8f98-4717-b8b3-3d82a29bbc85" />

---

### Task 4: If-Else Conditions
1. Create `check_number.sh` that:
   - Takes a number using `read`
   - Prints whether it is **positive**, **negative**, or **zero**

2. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file **exists** using `-f`
   - Prints appropriate message

---

### Task 5: Combine It All
Create `server_check.sh` that:
1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's **active** or **not**
4. If `n` — prints "Skipped."

---

## Hints
- Shebang: `#!/bin/bash` tells the system which interpreter to use
- Variables: `NAME="Shubham"` (no spaces around `=`)
- Read: `read -p "Enter name: " NAME`
- If syntax: `if [ condition ]; then ... elif ... else ... fi`
- File check: `if [ -f filename ]; then`

---

## Documentation

Create `day-16-shell-scripting.md` with:
- Each script's code and output
- What you learned (3 key points)

