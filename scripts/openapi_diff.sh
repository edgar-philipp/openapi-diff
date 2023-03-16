#!/bin/bash
CLI_VERSION=2.1.0

echo "::group::OpenAPI Diff"

source ${GITHUB_WORKSPACE}/workflow-repo/scripts/git_revisions.sh

echo "Get current version of file ${CHANGED_FILE}, commit ${now}"
git show ${now}:${CHANGED_FILE} > ${CHANGED_FILE}_new.yml
ls ${CHANGED_FILE}_new.yml

echo "Get previous version of file ${CHANGED_FILE}, commit ${before}"
git show ${before}:${CHANGED_FILE} > ${CHANGED_FILE}_old.yml
ls ${CHANGED_FILE}_old.yml

echo "git diff ${before} ${now} -- ${CHANGED_FILE}"
git diff ${before} ${now} -- ${CHANGED_FILE} > ${CHANGED_FILE}.diff

### Reporting ###

source ${GITHUB_WORKSPACE}/workflow-repo/scripts/github_summary.sh

function generate_report {
  echo "Report saved:"
  ls $1
  create_title "OpenAPI Diff Report"
  file_to_summary $1  
}

function generate_diff {
  echo "Diff saved:"
  ls $1
  create_section "Diff" $1 diff
}

function generate_errors {
  echo "Errors saved:"
  ls $1
  create_section "Errors" $1
}

### OpenAPI Diff ###

echo "Check for breaking changes"
report="Summary.md"
java -jar openapi-diff-cli-${CLI_VERSION}.jar ${CHANGED_FILE}_old.yml ${CHANGED_FILE}_new.yml --fail-on-incompatible --markdown ${report} 2>diff.err

if [ $? -ne 0 ]; then
  if [[ -f "$report" ]]; then
    echo "::error::Breaking changes on ${CHANGED_FILE}"
  else
    echo "::error::Could not process ${CHANGED_FILE}"
  fi
  if [[ -f "diff.err" ]]; then
     generate_errors diff.err
  fi
  generate_report ${report}
  generate_diff ${CHANGED_FILE}.diff
  exit 1
fi

generate_report ${report}

echo "::endgroup::"
