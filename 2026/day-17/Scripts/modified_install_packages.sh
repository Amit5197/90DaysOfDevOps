#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
else
    echo "Running as root"
fi

packages=("nginx" "curl" "wget")
for pkg in "${packages[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
        echo "Status - $pkg is Installed"
    else
        echo "Status - $pkg is Not Installed. Installing..."
        apt install -y "$pkg" &>/dev/null
        echo "Status - $pkg is Now Installed"
        echo "Status - $pkg Installed successfully"
    fi 
done