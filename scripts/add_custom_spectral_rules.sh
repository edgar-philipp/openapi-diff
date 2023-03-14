#!/bin/bash

# expects input arg: json with custom rules
custom_rules=`echo "$1" | tr -d ,{} | tr '\n' $'\n'`
custom_rules="rules:${custom_rules/'\n'}"
echo "${custom_rules}"

pwd
cp linter/spectral_template.yml linter/spectral.yml

result=$(CUSTOM_RULES=${custom_rules} envsubst < linter/spectral.yml)
echo "$result" > spectral.yml
echo $'Result:\n'"$result"
