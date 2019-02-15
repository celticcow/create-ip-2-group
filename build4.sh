#!/bin/bash

# gdunlap / celticcow
# 02.15.19
# read list of IP's from file.  see if host exist with IP
# add existing to group / or create new and add to group


printf "%s\n\n" "START"

mgmt_cli -d 146.18.96.25 -r true login > id.txt

file="/home/admin/api/ada-1.txt"

mgmt_cli -d 146.18.96.25 -r true add group name SCCM-Adaptiva-tmponly -s id.txt


while IFS= read -r var
do
	ehost=$(mgmt_cli -d 146.18.96.25 -r true show objects type host filter $var ip-only true --format json | jq '.objects [] | .name')

	#printf "found $ehost\n"	
	if [ -z $ehost ]; then
		printf  "need to add $var\n"
		mgmt_cli -d 146.18.96.25 -r true add host name sccm-tmp-$var ip-address $var groups.1 SCCM-Adaptiva-tmponly -s id.txt
	else
		printf "found $ehost\n"
		mgmt_cli -d 146.18.96.25 -r true set host name $ehost groups.1 SCCM-Adaptiva-tmponly -s id.txt
	fi
	#if[[exist = $(mgmt_cli -d 146.18.96.25 -r true show objects type host filter $var ip-only true --format json | jq '.objects [] | .name') = 1]]
	#mgmt_cli -d 146.18.96.25 -r true add host name sccm-adaptive-$var ip-address $var groups.1 SCCM-Adaptiva-local -s id.txt

done <"$file"

#mgmt_cli -d 146.18.96.25 -r true show host name "loki.infosec.fedex.com" -s id.txt

mgmt_cli -d 146.18.96.25 -r true publish -s id.txt
mgmt_cli -d 146.18.96.25 -r true logout -s id.txt


printf "%s\n\n" "END"

