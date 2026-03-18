# Day 13 – Linux Volume Management (LVM)

## Task
Learn LVM to manage storage flexibly – create, extend, and mount volumes.

**Watch First:** [Linux LVM Tutorial](https://youtu.be/Evnf2AAt7FQ?si=ncnfQYySYtK_2K3c)

---

## Expected Output
- A markdown file: `day-13-lvm.md`
- Screenshots of command outputs

---

## Before You Start

Switch to root user:
```bash
sudo -i
```
or
```bash
sudo su
```
No spare disk? Create a virtual one (watch the tutorial):
```bash
dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024
losetup -fP /tmp/disk1.img
losetup -a   # Note the device name (e.g., /dev/loop0)
```

---

## Challenge Tasks

### 1. Check Current Storage
```bash
lsblk      # List all block devices and partitions
pvs        # Show existing physical volumes
vgs        # Show existing volume groups
lvs        # Show existing logical volumes
df -h      # Show mounted filesystems and their usage
```
<img width="962" height="616" alt="image" src="https://github.com/user-attachments/assets/602110fd-7ce7-41b0-9831-86ef4e6a3d1a" />

---

### 2. Create Physical Volume
```bash
pvcreate /dev/nvme1n1   # Initialize /dev/nvme1n1 as a physical volume for LVM
pvs                      # Verify physical volume creation
```






