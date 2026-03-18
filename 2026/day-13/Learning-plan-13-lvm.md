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

### Task-01. Check Current Storage
```bash
lsblk      # List all block devices and partitions
pvs        # Show existing physical volumes
vgs        # Show existing volume groups
lvs        # Show existing logical volumes
df -h      # Show mounted/storage filesystems and their usage
```
**Commands run:**
```bash
lsblk
pvs
vgs
lvs
df -h
```
**Observation:**
| Device       | Size | Mountpoint | Notes |
|-------------|------|------------|-------|
| /dev/nvme0n1 | 8G   | /          | Root filesystem |
| /dev/nvme1n1 | 10G  | -          | Free disk available |

- No existing physical volumes, volume groups, or logical volumes
- `/dev/root` usage: 6.8G, 27% used

✅ **Conclusion:** A free disk (`/dev/nvme1n1`) is available for LVM.

<img width="962" height="692" alt="image" src="https://github.com/user-attachments/assets/10ff407a-c7f4-4140-aaef-f08341ded07e" />

---

### Task-02. Create Physical Volume
```bash
pvcreate /dev/nvme1n1   # Initialize /dev/nvme1n1 as a physical volume for LVM
pvs                      # Verify physical volume creation
```
**Command:**
```bash
pvcreate /dev/nvme1n1
pvs
```

**Observation:**
- `/dev/nvme1n1` initialized as a physical volume
- `pvs` shows it ready for LVM

<img width="761" height="517" alt="image" src="https://github.com/user-attachments/assets/211e03a3-5846-47f7-ab5f-7b7e3d65ec4e" />

---

### Task-03. Create Volume Group
```bash
vgcreate devops-vg /dev/nvme1n1   # Create a volume group named devops-vg
vgs                                # Verify volume group creation
```
**Command:**
```bash
vgcreate devops-vg /dev/nvme1n1
vgs
```

**Observation:**
- Volume group `devops-vg` created with 10G free space
  
<img width="582" height="163" alt="image" src="https://github.com/user-attachments/assets/eb1877e0-bd3b-44dc-b352-5b283b3c8522" />

---

### Task-04. Create Logical Volume
```bash
lvcreate -L 500M -n app-data devops-vg   # Create a logical volume named app-data with 500MB
lvs                                       # Verify logical volume creation
```
**Command:**
```bash
lvcreate -L 500M -n app-data devops-vg
lvs
```

**Observation:**
- Logical volume `app-data` of 500MB created under `devops-vg`

<img width="951" height="153" alt="image" src="https://github.com/user-attachments/assets/14e97a91-c1d9-4543-88bd-f2aa2ba1b937" />

---

### Task-05. Format and Mount Logical Volume
```bash
mkfs.ext4 /dev/devops-vg/app-data               # Format LV with ext4 filesystem
mkdir -p /mnt/app-data                          # Create mount point
mount /dev/devops-vg/app-data /mnt/app-data    # Mount LV
df -h /mnt/app-data                             # Verify mounted filesystem size and usage
```
**Commands:**
```bash
mkfs.ext4 /dev/devops-vg/app-data
mkdir -p /mnt/app-data
mount /dev/devops-vg/app-data /mnt/app-data
df -h /mnt/app-data
```

**Observation:**
- LV formatted as `ext4`
- Mounted at `/mnt/app-data`
- Filesystem shows: Size 452M, Used 24K, Available 417M (filesystem overhead reduces usable size)
<img width="862" height="407" alt="image" src="https://github.com/user-attachments/assets/d54d1b72-6c8c-48b2-a4a6-1c4a533ac478" />

---

### 6. Extend Logical Volume
```bash
lvextend -L +200M /dev/devops-vg/app-data   # Extend LV by 200MB
resize2fs /dev/devops-vg/app-data           # Resize filesystem to use new space
df -h /mnt/app-data                           # Verify updated size and usage
```
**Commands:**
```bash
lvextend -L +200M /dev/devops-vg/app-data
resize2fs /dev/devops-vg/app-data
df -h /mnt/app-data
```

**Observation:**
- LV size increased by 200MB (total 700MB)
- Filesystem resized to use new space
- Filesystem shows: Size 637M, Used 24K, Available 594M (filesystem overhead applies)
  
<img width="1180" height="292" alt="image" src="https://github.com/user-attachments/assets/566dff1b-75a8-4e4b-a7d7-31b06af8ec64" />

## Key Learnings

1. How to initialize a physical disk for LVM (`pvcreate`)  
2. How to create a volume group (`vgcreate`) and logical volume (`lvcreate`)  
3. How to extend a logical volume and resize the filesystem (`lvextend` + `resize2fs`)


