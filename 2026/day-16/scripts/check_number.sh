#!/bin/bash

read -p "Please enter a number of you choice : " num

if [ $num -eq $num ] &>/dev/null; then
	:	
else
	echo " Entered value is invalid"
	exit 1
fi

if [ $num -gt 0 ]; then
	echo "Number is Positive."
elif [ $num -lt 0 ]; then
	echo "Number is Negative."
else
	echo "Number is Zero."
fi

