## What is GIT?

**Git is a Version Control System (VCS) that tracks every single change you make to your files.
Think of it like a "Time Machine" for your code. If you make a mistake in your Terraform script or break your Nginx configuration, Git allows you to "undo" that mistake and travel back to a version that was working perfectly.**

## 1. Why do we need Git in DevOps?

**In your IT role and during your 90DaysOfDevOps challenge, Git is the foundation of everything. Here is why:
Version Tracking: You can see who changed what and when.
Safety: You can experiment with new code on a "Branch" without breaking the main project.
Collaboration: Multiple engineers can work on the same Azure infrastructure project simultaneously without overwriting each other's work.
Automation: Tools like Jenkins or GitHub Actions use Git to automatically deploy your code to AWS or Azure.**

## 2. The Three Stages of Git

**To understand how Git works locally on your computer (like in the Git Bash terminal we discussed), you must know these three areas:
Working Directory: This is your actual folder where you are typing code.
Staging Area: This is a "waiting room." You "Add" files here when they are ready to be saved.
Local Repository: This is the permanent database where Git saves your "Commits" (snapshots).**

## 3. Top 5 Commands You Will Use Daily

Command,What it does

``` git init ``` #Turns a normal folder into a Git repository.

``` git status ``` #Shows you which files are modified or ready to be saved.

``` git add <file> ``` #"Moves your changes into the ""Staging Area."""

``` "git commit -m ""msg""" ``` Saves your changes permanently with a descriptive note.

``` git log ``` #Shows you the history of every save you've ever made.

## Git Branch add and feature add

git checkout main
git stash
git checkout feature-login
git checkout main
git stash pop
git stash list
task 5
git checkout -b feature-hotfix
echo "Fix 1" >> fix.txt
git commit -am "Fix 1"

echo "Fix 2" >> fix.txt
git commit -am "Fix 2"

echo "Fix 3" >> fix.txt
git commit -am "Fix 3"

git checkout main
git log --oneline
git cherry-pick <commit-id>
