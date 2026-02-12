#!/bin/bash

set -eu

usage(){
	echo "Usage: ./log_rotate.sh /var/log/app_name"
	echo "Provide the directory of log files that you want to rotate."
	echo "Example : /var/log/apache2"
	exit 1
}

check_dir(){
	find $dir &>/dev/null || { echo "No such directory"; exit 1; }
}

gzip_count=0
delete_count=0

#Compresses .log files older than 7 days using gzip and count how many files zipped
compress(){
	file_list=$(find $dir -name "*.log*" -mtime +7)
	for file in $file_list;do
		if [[ $file != *.gz ]];then
			gzip $file
			gzip_count=$((gzip_count + 1))
		fi
	done
}

#Deletes .gz files older than 30 days and count how many deleted
delete(){
	zip_file=$(find $dir -name "*.gz" -mtime +30)
	for file in $zip_file;do
		rm $file
		delete_count=$((delete_count + 1))
	done
}

dir=$1

if [ $# -eq 0 ];then
	usage
fi

check_dir
compress
delete

echo "Total Log Files Zipped  : $gzip_count"
echo "Total Zip Files Deleted : $delete_count"
