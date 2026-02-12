#!/bin/bash

log_rotation(){
	
	~/batch10/90DaysOfDevOps/2026/day-19/scripts/log_rotate.sh /var/log/demo >> /var/log/maintenance.log
}

backup(){
	 ~/batch10/90DaysOfDevOps/2026/day-19/scripts/backup.sh ~/Downloads ~/demo >> /var/log/maintenance.log
}

main(){
	echo -e "\n$(date) : Starting Maintenance... " >> /var/log/maintenance.log
	log_rotation
	backup
	echo "Maintenance completed for today" >> /var/log/maintenance.log
}

main
echo "Successfully written logs to /var/log/maintenance.log"
