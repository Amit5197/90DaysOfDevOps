#!/bin/bash

read -p "Please enter any file name : " fname

if [ -f $fname ];then
	echo "The file exists."
else
	echo "The file doesn't exist".
fi
