#!/bin/bash

function file_to_summary {
  while read line; do
    echo "Line: ${line}"
    echo "${line}" >> $GITHUB_STEP_SUMMARY
  done < "$1"
}

function generate_report {
  echo "Report saved:"
  ls $1
  echo "### Report Summary" >> $GITHUB_STEP_SUMMARY
  file_to_summary $1
}

function generate_diff {
  echo "### Diff" >> $GITHUB_STEP_SUMMARY
  echo '```diff' >> $GITHUB_STEP_SUMMARY
  file_to_summary $1
  echo '```' >> $GITHUB_STEP_SUMMARY
}

echo "::group::OpenAPI Diff"

echo "Get current version of file ${CHANGED_FILE}, commit ${CURRENT_HASH}"
git show ${CURRENT_HASH}:${CHANGED_FILE} > ${CHANGED_FILE}_new.yml
ls ${CHANGED_FILE}_new.yml

echo "Get previous version of file ${CHANGED_FILE}, commit ${PREVIOUS_HASH}"
git show ${PREVIOUS_HASH}:${CHANGED_FILE} > ${CHANGED_FILE}_old.yml
ls ${CHANGED_FILE}_old.yml

echo "diff ${PREVIOUS_HASH} ${CURRENT_HASH} -- ${CHANGED_FILE}"
git diff ${PREVIOUS_HASH} ${CURRENT_HASH} -- ${CHANGED_FILE} > ${CHANGED_FILE}.diff

echo "Check for breaking changes"
report="Summary.md"
java -jar openapi-diff-cli-2.1.0.jar ${CHANGED_FILE}_old.yml ${CHANGED_FILE}_new.yml --fail-on-incompatible --markdown ${report}

if [ $? -ne 0 ]; then
  echo "::error::Breaking changes on ${CHANGED_FILE}"
  generate_report ${report}
  gererate_diff ${CHANGED_FILE}.diff
  exit 1
fi

generate_report ${report}

echo "::endgroup::"
