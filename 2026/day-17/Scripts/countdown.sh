# while [ condition ]; do ... done
#!/bin/bash

read -p "Enter the number you want: " num

while [ $num -gt 0 ]; do
    echo $num
num=$((num - 1))
done
    echo "Done!"