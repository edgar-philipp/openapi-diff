#!/bin/bash

# expects input arg: json with custom rules
custom_rules=`echo "$1" | tr -d ,{} | tr '\n' $'\n'`
custom_rules="rules:${custom_rules/'\n'}"
echo "${custom_rules}"

pwd
linter_dir=${GITHUB_WORKSPACE}/workflow-repo/linter
cp ${linter_dir}/spectral_template.yml ${linter_dir}/spectral.yml

result=$(CUSTOM_RULES=${custom_rules} envsubst < ${linter_dir}/spectral.yml)
echo "$result" > spectral.yml
echo $'Result:\n'"$result"
