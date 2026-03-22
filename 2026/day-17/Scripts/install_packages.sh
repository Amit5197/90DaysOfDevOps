#!/bin/bash

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