#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"
cd /tmp/devops-test || echo "Cannot change to directory"
touch testfile.txt || echo "Cannot create file"