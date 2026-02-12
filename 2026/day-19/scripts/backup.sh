#!/bin/bash
set -eu

#Check for arguments
usage(){
	echo "Usage : backup.sh source/path destination/path"
	echo "Example : backup.sh /home/afroz/batch10 /home/afroz/backup"
	echo "Please provide source and destination"
	exit 1
}

#Check source/destination folder exists
check_source(){
	find $src &>/dev/null || { echo "Source directory doesn't exists"; exit 1; }
	find $dest &>/dev/null || { echo "Destination directory doesn't exists"; exit 1; }
}

#Take backup
backup(){
	echo "======Taking BackUp======"
	tar -czf $dest/backup-$(date +%Y-%m-%d-%H-%M-%S).tar.gz $src &>/dev/null && echo "Back Up Complete"
	echo
}

#Print archive name and size
print_file(){
	echo "======Backup Taken======"
	cd $dest
	ls -lh backup-$(date +%Y-%m-%d-%H-%M-%S).tar.gz | awk '{print "Archive Name : "$9,"\nSize : "$5}'
	cd
	echo
}

#delete archives older than 14 Days
delete(){
	
	archives=$(find $dest -name "*.tar.gz" -mtime +14)
	if [ -n "$archives" ];then
		echo "======Removing archives older than 14 days======"
		for file in $archives;do
			rm $file
			echo "Removed Archive : $file"
		done
	fi
}

if [ $# -lt 2 ];then
	usage
fi
src=$1
dest=$2
check_source
backup
print_file
delete
