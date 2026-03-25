#!/bin/bash

# local vs global variables in Bash

echo "Using local variable"

# Function with a local variable
func_local() {
    local x=10        # 'x' is declared local to this function
    echo "Inside func_local: x = $x"  # Accessible inside the function
}

func_local           # Call the function
echo "Outside func_local: x = $x"  # 'x' is NOT accessible here (will be empty)

echo
echo "Using regular (global) variable"

# Function with a regular (global) variable
func_global() {
    y=20              # 'y' is a global variable by default
    echo "Inside func_global: y = $y"  # Accessible inside the function
}

func_global           # Call the function
echo "Outside func_global: y = $y"  # 'y' is accessible here as well