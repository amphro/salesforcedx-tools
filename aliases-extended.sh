#!/bin/bash

sfdx force:doc:commands:list --json | jq '.result[] | ("alias dxXX=\"sfdx "+.name+"\"")' -r