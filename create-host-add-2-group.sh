#!/bin/bash

# gdunlap / celticcow
# 02.17.19
# read list of IP's from file.  see if host exist with IP
# add existing to group / or create new and add to group

printf "%s\n" "enter P1 username:"
read USER

printf "%s\n" "enter P1 password:"
read -s PASS

printf "%s\n" "enter IP of CMA:"
read DOMAIN

printf "%s\n" "enter group to add to / this group must NOT already exist:"
read GROUP

printf "%s\n\n" "START"

mgmt_cli -d $DOMAIN -u $USER -p $PASS login > id.txt

file="/home/admin/api/iplist-1.txt"

mgmt_cli -d $DOMAIN add group name $GROUP -s id.txt


while IFS= read -r var
do
	ehost=$(mgmt_cli -d $DOMAIN -s id.txt show objects type host filter $var ip-only true --format json | jq '.objects [] | .name')

	#printf "found $ehost\n"	
	if [ -z $ehost ]; then
		printf  "need to add $var\n"
		mgmt_cli -d $DOMAIN add host name c-$var ip-address $var groups.1 $GROUP -s id.txt
	else
		printf "found $ehost\n"
		mgmt_cli -d $DOMAIN set host name $ehost groups.1 $GROUP -s id.txt
	fi

done <"$file"


mgmt_cli -d $DOMAIN publish -s id.txt
mgmt_cli -d $DOMAIN logout -s id.txt


printf "%s\n\n" "END"

