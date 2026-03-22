# Day 17 – Shell Scripting: Loops, Arguments & Error Handling

## Task
Level up your scripting — use loops, handle arguments, and deal with errors.

You will:
- Write **for** and **while** loops
- Use **command-line arguments** (`$1`, `$2`, `$#`, `$@`)
- Install packages via script
- Add basic **error handling**

---

## Expected Output
- A markdown file: `day-17-scripting.md`
- All scripts you write during the tasks

---
### Output:->

### Task 1: For Loop
1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one
2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop

## Loops through a list of 5 fruits and prints each one

<img width="613" height="643" alt="image" src="https://github.com/user-attachments/assets/76c54dc2-8346-44fb-802b-2edc335b5993" />

<img width="782" height="303" alt="image" src="https://github.com/user-attachments/assets/70a28df6-186d-41d5-92f1-18a9cf73f747" />

## Prints numbers 1 to 10 using a for loop

<img width="695" height="217" alt="image" src="https://github.com/user-attachments/assets/32f2cce6-1682-4c7a-873f-a22e6fc68988" />

<img width="656" height="358" alt="image" src="https://github.com/user-attachments/assets/6ba1940e-dab1-4f62-bc92-878ccf41e0f1" />

---

### Task 2: While Loop
1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end

<img width="592" height="361" alt="image" src="https://github.com/user-attachments/assets/44725be7-d2e6-4930-8850-367ff9cf026a" />
<img width="600" height="552" alt="image" src="https://github.com/user-attachments/assets/f7d8c6f6-60a1-4396-8010-47eb46419628" />

---

### Task 3: Command-Line Arguments
1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"

2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)

<img width="812" height="380" alt="image" src="https://github.com/user-attachments/assets/d634ed38-8f62-4df0-a260-1c0650a87d05" />
<img width="791" height="227" alt="image" src="https://github.com/user-attachments/assets/4fe7a294-8dfd-431f-a43e-446af828d21c" />
<img width="716" height="207" alt="image" src="https://github.com/user-attachments/assets/0a286dd6-2f9d-4e0e-9f4f-849e90c1ac2b" />
<img width="510" height="200" alt="image" src="https://github.com/user-attachments/assets/fd85c575-efca-4163-b0a0-cbd81471e958" />

---

### Task 4: Install Packages via Script
1. Create `install_packages.sh` that:
   - Defines a list of packages: `nginx`, `curl`, `wget`
   - Loops through the list
   - Checks if each package is installed (use `dpkg -s` or `rpm -q`)
   - Installs it if missing, skips if already present
   - Prints status for each package

> Run as root: `sudo -i` or `sudo su`

<img width="1238" height="321" alt="image" src="https://github.com/user-attachments/assets/76a1a483-aa42-4ea6-af21-e4144d41f4d2" />
<img width="1217" height="447" alt="image" src="https://github.com/user-attachments/assets/bc28e00f-5b3d-4e29-a412-a57aae89695a" />

---
### Task 5: Error Handling
1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails

Example:
```bash
mkdir /tmp/devops-test || echo "Directory already exists"
```

2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not.

<img width="747" height="402" alt="image" src="https://github.com/user-attachments/assets/ea654c86-17f9-416c-940d-177b9f09978c" />
<img width="1808" height="412" alt="image" src="https://github.com/user-attachments/assets/79eec8b7-6c7a-4c4f-902e-87f0c97dc927" />
<img width="846" height="286" alt="image" src="https://github.com/user-attachments/assets/48469bcd-b5b0-4e39-95b4-959783450482" />

---
## What I Learned

* Used for loops to iterate over lists and number ranges
* Used while loops for countdown logic with user input
* Handled command-line arguments using $1, $#, $@, $0
* Added usage messages for missing arguments
* Took user input using read
* Automated package installation (nginx, curl, wget)
* Checked package status using dpkg -s
* Added root user validation using $EUID
* Implemented error handling with set -e and || (Or)
* Created safe scripts to avoid failures and overwrites
* Issue Faced & Lesson Learned: Used commas in a Bash array, causing the loop to fail, Learned that Bash arrays must be space-separated, not comma-separated

---


