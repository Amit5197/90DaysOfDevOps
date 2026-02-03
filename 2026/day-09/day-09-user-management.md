# Linux User & Group Management

## Users Created

` useradd -m username`

![snapshot](images/lsusers.png)

- Users: tokyo, berlin, professor, nairobi

## Groups Created

`groupadd groupname`

- Groups: developers, admins, project-team

## Changed default shell to /bin/bash

`sudo usermod -s /bin/bash username`

![snapshot](images/chngshell.png)

## Group Assignment

![snapshot](images/lsgroups.png)

## Directories Created

![snapshot](images/directories.png)

## Home directories of Users

![snapshot](images/homedirectories.png)

## Shared Directory

- Create directory: /opt/dev-project
- Set group owner to developers
- Set permissions to 775 (rwxrwxr-x)
- Test by creating files as tokyo and berlin

![snapshot](images/mkdir.png)

 Set password for user
 
![snapshot](images/berlin_user.png)

## Team Workspace

- Create user nairobi with home directory
- Create group project-team
- Add nairobi and tokyo to project-team
- Create /opt/team-workspace directory
- Set group to project-team, permissions to 775
- Test by creating file as nairobi

![snapshot](images/nairobi.png)

![snapshot](images/test_nairobi.png)

## Commands Used

* `useradd -m uname` - Add user with default directory
* `sudo passwd uname` - Set password for user
* `groupadd gname` - Add group
* `sudo usermod -s /bin/bash username` - Change shell
* `sudo usermod -aG group user` - Assign user to group
* `sudo chgrp new_group directory/file ` - Change group ownership of a directory or file
* `sudo chmod 775 file/directory` - Change permissions of a file or directory

## How to login using created users

### Example : Login as Berlin User

* Create .ssh directory for user "berlin" - `sudo mkdir -p /home/berlin/.ssh`
    
* Copied Authorized keys from user ubuntu to berlin - `sudo cp /home/ubuntu/.ssh/authorized_keys /home/berlin/.ssh`
    
* Change the ownership of .ssh and authorized keys - `sudo chown -R berlin:berlin /home/berlin/.ssh`

* Changed permissions for .ssh and authorized keys - 
    `sudo chmod 700 /home/berlin/.ssh`
    `sudo chmod 600 /home/berlin/.ssh/authorized_keys`

* Login - `ssh -i "batch10.pem" berlin@ec2-35-94-155-53.us-west-2.compute.amazonaws.com`

![snapshot](images/login_berlin.png)

## What I Learned

* Gained a clear understanding of how users and groups work in Linux.
* Practiced managing permissions and observed their impact on collaboration.
* Even if two users belong to the same group and share access to a directory, they cannot automatically write to or modify each other’s files. By default, when a user creates a file inside a directory:
  -The file is owned by the user and their primary group (not necessarily the directory’s group).
  -The default file permissions usually give write access only to the owner, while the group gets read access.
  -As a result, other group members can view the file but cannot edit or delete it.
  Example : Shared directory scenario.
* Set up direct login access for newly created users using SSH keys and proper permissions.
