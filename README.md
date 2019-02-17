# create-ip-2-group
Checkpoint API code


create-host-add-2-group.sh

input file sample for test
//from file
1.1.1.1
2.2.2.2
146.18.2.137
199.82.243.100


code run
[Expert@labmds:0]# ./create-host-add-2-group.sh
enter P1 username:
gdunlap
enter P1 password:
enter IP of CMA:
146.18.96.25
enter group to add to / this group must NOT already exist:
TMP-00
START

found "fxcc-1.1.1.1"
need to add 2.2.2.2
found "loki.infosec.fedex.com"
found "mwg-e00"
need to add 4.4.4.4


---------------------------------------------
Time: [15:02:57] 17/2/2019
---------------------------------------------
"Publish operation"  succeeded  (100%)
tasks:
- task-id: "01234567-89ab-cdef-a355-179d341fccd1"
  task-name: "Publish operation"
  status: "succeeded"
  progress-percentage: 100
  suppressed: false
  task-details:
  - publishResponse:
      numberOfPublishedChanges: 0
      mode: "async"
    revision: "02001bd9-f113-44d3-bfac-70e9952bad32"

message: "OK"

END
