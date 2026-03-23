# Day 18 – Shell Scripting: Functions & intermediate Concepts

## Task
Write cleaner, reusable scripts — learn functions, strict mode, and real-world patterns.

You will:
- Write and call **functions**
- Use **`set -euo pipefail`** for safer scripts
- Work with **return values** and **local variables**
- Build an intermediate script

---

## Expected Output
- A markdown file: `day-18-scripting.md`
- All scripts you write during the tasks

---

## Output-

### Task 1: Basic Functions
1. Create `functions.sh` with:
   - A function `greet` that takes a name as argument and prints `Hello, <name>!`
   - A function `add` that takes two numbers and prints their sum
   - Call both functions from the script

<img width="640" height="253" alt="image" src="https://github.com/user-attachments/assets/0979aa6a-9e8d-4b98-b4c1-4ee62033c167" />

---

### Task 2: Functions with Return Values
1. Create `disk_check.sh` with:
   - A function `check_disk` that checks disk usage of `/` using `df -h`
   - A function `check_memory` that checks free memory using `free -h`
   - A main section that calls both and prints the results

<img width="670" height="207" alt="image" src="https://github.com/user-attachments/assets/56ff7651-97b7-4e29-9265-d3736488f87d" />

---

### Task 3: Strict Mode — `set -euo pipefail`
1. Create `strict_demo.sh` with `set -euo pipefail` at the top
2. Try using an **undefined variable** — what happens with `set -u`?
3. Try a command that **fails** — what happens with `set -e`?
4. Try a **piped command** where one part fails — what happens with `set -o pipefail`?

```
#!/bin/bash
set -euo pipefail

echo "Testing strict mode..."

# Uncomment one at a time to test behavior

# Undefined variable (set -u)
# echo "$UNDEFINED_VAR"

# Failing command (set -e)
# false

# Pipeline failure (set -o pipefail)
# grep "text" nonexistentfile | wc -l

echo "Script completed."
```
<img width="647" height="322" alt="image" src="https://github.com/user-attachments/assets/1c0bc497-8123-49ae-af32-0a7a071ee841" />

**Document:** What does each flag do?

- `set -e` → Exit the script immediately if any command fails.
- `set -u` → Exit the script if an undefined (unset) variable is used.
- `set -o pipefail` → Pipeline fails if any command fails.

---

### Task 4: Local Variables
1. Create `local_demo.sh` with:
   - A function that uses `local` keyword for variables
   - Show that `local` variables don't leak outside the function
   - Compare with a function that uses regular variables

<img width="645" height="422" alt="image" src="https://github.com/user-attachments/assets/78b4ea16-1bd7-4609-b23a-5c8904b34654" />

---

### Task 5: Build a Script — System Info Reporter
Create `system_info.sh` that uses functions for everything:
1. A function to print **hostname and OS info**
2. A function to print **uptime**
3. A function to print **disk usage** (top 5 by size)
4. A function to print **memory usage**
5. A function to print **top 5 CPU-consuming processes**
6. A `main` function that calls all of the above with section headers
7. Use `set -euo pipefail` at the top

Output should look clean and readable.

<img width="681" height="606" alt="image" src="https://github.com/user-attachments/assets/5b53c12a-85bb-4b14-8cf3-984ceacac068" />

---

## Hints
- Function syntax: `function_name() { ... }`
- Local vars: `local MY_VAR="value"`
- Strict mode: `set -euo pipefail` as first line after shebang
- Pass args to functions: `greet "Amit"` → access as `$1` inside
- `$?` gives the exit code of last command

---

## What I Learned

**Functions & Modularity** – Learned to create reusable, organized code blocks.This makes scripts cleaner, easier to read, and simpler to maintain.

**System Monitoring Scripts** – Explored fetching system info like memory,disk usage,and CPU processes.Useful for building quick automation for system health checks.

**Error Handling & Safety** – Using `set -euo pipefail` to catch undefined variables,failing commands,and pipeline errors early,making scripts more reliable.

**Variable Scope** – Understood the difference between local and global variables. Local variables stay inside functions, while global variables affect the wider script.

**Practical Automation** – Using a main function to orchestrate tasks helps make scripts modular,maintainable,and automation-friendly.

**Function Naming Pitfall** – Faced an issue where naming a function the same as a system command (uptime) caused an infinite loop.
Learned to avoid using system command names for functions.

