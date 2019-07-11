#!/bin/bash

# gdunlap / celticcow
# 0
# version 0.1
# read list of IP's from file.  see if host exist with IP


printf "%s\n" "enter P1 username:"
read USER

printf "%s\n" "enter P1 password:"
read -s PASS

printf "%s\n" "enter IP of CMA:"
read DOMAIN

printf "%s\n" "enter prefix for host:"
read PREFIX

printf "%s\n\n" "START"

mgmt_cli -d $DOMAIN -u $USER -p $PASS login > id.txt

file="/home/admin/api/iplist-2.txt"

while IFS= read -r var
do
	ehost=$(mgmt_cli -d $DOMAIN -s id.txt show objects type host filter $var ip-only true --format json | jq '.objects [] | .name')

	#printf "found $ehost\n"	
	if [ -z $ehost ]; then
		printf  "need to add $var\n"
		mgmt_cli -d $DOMAIN add host name $PREFIX-$var ip-address $var -s id.txt
	else
		printf "found $ehost\n"
		# set host name causes problems and will remove it from other groups
		printf "already exist $ehost\n"
	fi

done <"$file"


mgmt_cli -d $DOMAIN publish -s id.txt
mgmt_cli -d $DOMAIN logout -s id.txt


printf "%s\n\n" "END"
