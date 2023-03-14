#!/bin/bash

# expects json with custom rules
custom_rules=`echo "{
  info-license: off,
  license-url: off
}" | tr -d ,{} | tr '\n' $'\n'`
custom_rules="rules:${custom_rules/'\n'}"
echo "${custom_rules}"

cp ./spectral_template.yml ./spectral_generated.yml

result=$(CUSTOM_RULES=${custom_rules} envsubst < spectral_generated.yml)
echo "$result" > spectral_generated.yml
echo $'Result:\n'"$result"