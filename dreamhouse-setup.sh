#!/bin/bash

dx_alias_name=$@

if [[ $dx_alias_name == '' ]]
then
    echo "Usage: bash ./dreamhouse-setup.sh myalias"
    exit 0
fi
echo $dx_alias_name
exit

sfdx force:org:create -f config/project-scratch-def.json -s -a $dx_alias_name
sfdx force:source:push
sfdx force:user:permset:assign -n Dreamhouse
sfdx force:data:tree:import -p data/sample-data-plan.json
sfdx force:apex:test:run -r tap -c