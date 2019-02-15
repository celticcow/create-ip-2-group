#!/bin/bash

printf "%s\n" "enter username:"
read USER

printf "%s\n" "enter password:"

read -s PASS

printf "%s\n\n" "START"

mgmt_cli -d 146.18.96.25 -u $USER -p $PASS login > id.txt

file="/home/admin/api/ada-1.txt"

mgmt_cli -d 146.18.96.25 show host name "loki.infosec.fedex.com" -s id.txt

mgmt_cli -d 146.18.96.25 publish -s id.txt
mgmt_cli -d 146.18.96.25 logout -s id.txt


printf "%s\n\n" "END"
