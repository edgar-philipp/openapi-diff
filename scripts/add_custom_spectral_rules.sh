#!/bin/bash

# expects json with custom rules
custom_rules=`echo "$JSON_INPUT" | tr -d ,{}\" | tr '\n' $'\n'`
custom_rules="rules:${custom_rules/'\n'}"
echo "${custom_rules}"

linter_dir=${GITHUB_WORKSPACE}/workflow-repo/linter
cp ${linter_dir}/spectral_template.yml ${linter_dir}/spectral.yml

echo "Before:"
less ${linter_dir}/spectral.yml

result=$(CUSTOM_RULES=${custom_rules} envsubst < ${linter_dir}/spectral.yml)
echo "$result" > ${linter_dir}/spectral.yml

echo "After:"
less ${linter_dir}/spectral.yml
