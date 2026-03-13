# Day 09 – Linux User & Group Management Challenge
Task
Today's goal is to practice user and group management by completing hands-on challenges.

Figure out how to:

Create users and set passwords
Create groups and assign users
Set up shared directories with group permissions
Use what you learned from Days 1-7 to find the right commands!

### Task 1: Create Users

Create three users with home directories and passwords:
- `tokyo`
- `berlin`
- `professor`

**Verify:** Check `/etc/passwd` and `/home/` directory

![day-09-task-01](https://github.com/user-attachments/assets/00a7f0c8-f717-479a-8df9-0fa9f22c1d6d)

---

### Task 2: Create Groups

Create two groups:
- `developers`
- `admins`

**Verify:** Check `/etc/group`

![day-09-task-02](https://github.com/user-attachments/assets/ec96fdee-f2cb-41ec-8dca-6535fecf6c94)

---

### Task 3: Assign to Groups

Assign users:
- `tokyo` → `developers`
- `berlin` → `developers` + `admins` (both groups)
- `professor` → `admins`

**Verify:** Use appropriate command to check group membership

![day-09-task-03](https://github.com/user-attachments/assets/8adaec22-f17b-46d0-9503-8d11d947cac6)

---

### Task 4: Shared Directory 

1. Create directory: `/opt/dev-project`
2. Set group owner to `developers`
3. Set permissions to `775` (rwxrwxr-x)
4. Test by creating files as `tokyo` and `berlin`

**Verify:** Check permissions and test file creation

![day-09-task-04](https://github.com/user-attachments/assets/ad72cdf8-cd72-4205-9bcb-09b114c72fdf)

---

### Task 5: Team Workspace

1. Create user `nairobi` with home directory
2. Create group `project-team`
3. Add `nairobi` and `tokyo` to `project-team`
4. Create `/opt/team-workspace` directory
5. Set group to `project-team`, permissions to `775`
6. Test by creating file as `nairobi`

![day-09-task-05](https://github.com/user-attachments/assets/67990621-2941-498a-9b02-c1ea77635bf0)

---

### Users & Groups Created
- Users: tokyo, berlin, professor, nairobi
- Groups: developers, admins, project-team

### Group Assignments
```
tokyo: developers,project-team
berlin: developers,admins
professor: admins
nairobi: project-team
```
### Directories Created
```
/opt/dev-project
Permissions: 775 (drwxrwxr-x)


/opt/team-workspace
Permissions: 775 (drwxrwxr-x)

```

### Commands Used

###  Create three users with password
```
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor
sudo passwd nairobi
```

### Group Creation
```
sudo groupadd developers
sudo groupadd admins
sudo groupadd project-team
```

### Assign Users to Groups
```
sudo usermod -aG developers tokyo
sudo usermod -aG developers,admins berlin
sudo usermod -aG admins professor
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
```

### Directory Configuration & Permissions
```
sudo mkdir /opt/dev-project
sudo chgrp developers /opt/dev-project
sudo chmod 775 /opt/dev-project
sudo mkdir /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace
```
### Verification

# Verifying User Creation
grep -e tokyo -e berlin -e professor /etc/passwd

# Verifying Group Assignments
```
groups tokyo
groups berlin
groups professor
groups nairobi
```

# Testing Write Access (Development Project)
su tokyo
touch /opt/dev-project/tokyo.txt

su berlin
touch /opt/dev-project/berlin.txt

# Testing Write Access (Team Workspace)
su nairobi
touch /opt/team-workspace/nairobi.txt

##  What I Learned

1.  **Managing User Privileges via Groups:** Learned how to efficiently manage access control by assigning users to secondary groups (like `developers` or `admins`) using `usermod -aG`, rather than managing permissions for every single user individually.

2.  **Shared Workspace Permissions (775):** Understood the significance of the `775` permission code. It allows the **Owner** and **Group** full control (Read, Write, Execute) to collaborate, while restricting **Others** to Read/Execute only,ensuring security.

3.  **Changing Group Ownership:** Learned to use `chgrp` to change a directory's group ownership. This is essential for collaborative folders so that all members of a specific team (e.g., `project-team`) share ownership of the space.

4.  **Verification Workflow:** Established a habit of verifying every administrative change. Using commands like `ls -ld` to check permissions and `groups` to confirm user membership ensures that access rights are set up correctly before users start working.
