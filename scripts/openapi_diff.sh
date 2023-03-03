#!/bin/bash

function to_step_summary {
  while read line; do
    echo "${line}" >> $GITHUB_STEP_SUMMARY
  done < "$1"
}

echo "::group::OpenAPI Diff"

echo "Get current version of file ${CHANGED_FILE}, commit ${CURRENT_HASH}"
git show ${CURRENT_HASH}:${CHANGED_FILE} > ${CHANGED_FILE}_new.yml
ls ${CHANGED_FILE}_new.yml

echo "Get previous version of file ${CHANGED_FILE}, commit ${PREVIOUS_HASH}"
git show ${PREVIOUS_HASH}:${CHANGED_FILE} > ${CHANGED_FILE}_old.yml
ls ${CHANGED_FILE}_old.yml

echo "diff ${PREVIOUS_HASH} ${CURRENT_HASH} -- ${CHANGED_FILE}"
git diff ${PREVIOUS_HASH} ${CURRENT_HASH} -- ${CHANGED_FILE}

echo "Check for breaking changes"
report="Summary.md"
java -jar openapi-diff-cli-2.1.0.jar ${CHANGED_FILE}_old.yml ${CHANGED_FILE}_new.yml --fail-on-incompatible --markdown ${report}

echo "Report saved:"
ls ${report}

if [ $? -ne 0 ]; then
  echo "::error::Breaking changes on ${CHANGED_FILE}" 
  to_step_summary ${report} 
  exit 1
fi

to_step_summary ${report}

echo "::endgroup::"
