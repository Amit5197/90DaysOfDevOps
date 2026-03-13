# Day 10 – File Permissions & File Operations Challenge

## Task
Master file permissions and basic file operations in Linux.

- Create and read files using `touch`, `cat`, `vim`
- Understand and modify permissions using `chmod`

----

## Challenge Tasks

### Task 1: Create Files

1. Create empty file `devops.txt` using `touch`
2. Create `notes.txt` with some content using `cat` or `echo`
3. Create `script.sh` using `vim` with content: `echo "Hello DevOps"`

**Verify:** `ls -l` to see permissions

![day-10-task-01](https://github.com/user-attachments/assets/d39847fb-3b98-4163-b379-6b00b6409f44)

---

### Task 2: Read Files

1. Read `notes.txt` using `cat`
2. View `script.sh` in vim read-only mode
3. Display first 5 lines of `/etc/passwd` using `head`
4. Display last 5 lines of `/etc/passwd` using `tail`

![day-10-task-02](https://github.com/user-attachments/assets/c4d34555-d1bb-485c-bacc-e388e2efc0e0)

---

### Task 3: Understand Permissions 

Format: `rwxrwxrwx` (owner-group-others)
- `r` = read (4), `w` = write (2), `x` = execute (1)

Check your files: `ls -l devops.txt notes.txt script.sh`

Answer: What are current permissions? Who can read/write/execute?

```bash
-rw-r--r--
```

```bash
- → regular file (not a directory)
Owner (ubuntu): rw- → read ✅ write ✅ execute ❌
Group (ubuntu): r-- → read ✅ write ❌ execute ❌
Others        : r-- → read ✅ write ❌ execute ❌
```
---

### Task 4: Modify Permissions

1. Make `script.sh` executable → run it with `./script.sh`
2. Set `devops.txt` to read-only (remove write for all)
3. Set `notes.txt` to `640` (owner: rw, group: r, others: none)
4. Create directory `project/` with permissions `755`

**Verify:** `ls -l` after each change

![day-10-task-04](https://github.com/user-attachments/assets/13110ed2-951b-4dc6-a79e-e3db414193bc)

---

### Task 5: Test Permissions

1. Try writing to a read-only file - what happens?
2. Try executing a file without execute permission
3. Document the error messages

![day-10-task-05](https://github.com/user-attachments/assets/e5def9dc-503e-4192-99c2-447060ea90b4)

---
## Permission Changes

### Before
All three files have the same permissions:
```bash
-rw-r--r--
```
<img width="777" height="127" alt="image" src="https://github.com/user-attachments/assets/d762631e-02b3-4053-b167-0f8a5cd03ce2" />

### After 

<img width="753" height="547" alt="image" src="https://github.com/user-attachments/assets/4d704ca1-539e-4a3a-9676-96dd63e1381b" />

## Command used

- Create: `touch`, `cat > file`, `vim file`
- Read: `cat`, `head -n`, `tail -n`
- Permissions: `chmod +x`, `chmod -w`, `chmod 755`

---

## What I have learned:

1. **File Creation and Inspection:** I learned how to create and edit files using `touch`, `echo`, and `vim`.I also discovered how to open files safely in read-only mode using `vim -R` .Additionally, I used the `head` and `tail` commands to filter specific lines from system files (`like /etc/passwd`) to verify user accounts on the system.

2. **Managing Permissions with chmod:** I learned how to modify file and directory permissions using the chmod command. I practiced using both symbolic mode (e.g., chmod +x to make a script executable) and numeric mode (e.g., `chmod 755` for directories, chmod `444` for read-only files).

3. **Troubleshooting Access Control:** I observed how Linux permissions directly affect file operations. I saw "Permission denied" errors when trying to execute a script without the executable permission or write to a read-only file, and fixed them by adjusting permissions.
