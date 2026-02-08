#!/bin/bash

read -p "Enter any service name : " service

read -p "Do you want to check the status? (y/n)" answer

if [[ $answer == 'y' || $answer == 'Y' || $answer == 'Yes' || $answer == 'yes' ]];then
	:
elif [[ $answer == 'n' || $answer == 'N' || $answer == 'No' || $answer == 'no' ]];then
	echo "Skipped"
	exit 1
else
	echo "Enter valid answer. Quitting."
	exit 1
fi

systemctl status $service  | awk 'NR==3 {print $2}'

