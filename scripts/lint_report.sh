#!/bin/bash

echo "::group::Lint Report"

echo "Lint report saved:"
ls ${LINT_RESULT}
echo "### Lint report" >> $GITHUB_STEP_SUMMARY

function file_to_summary {
  while read line; do
    echo "${line}" >> $GITHUB_STEP_SUMMARY
  done < "$1"
}

# section title, file, format 
function create_section {
  echo "#### $1" >> $GITHUB_STEP_SUMMARY
  echo '```$3' >> $GITHUB_STEP_SUMMARY
  file_to_summary $2
  echo '```' >> $GITHUB_STEP_SUMMARY
}

linter_dir=${GITHUB_WORKSPACE}/workflow-repo/linter
create_section "Spectral file" ${linter_dir}/spectral.yml yml
create_section "Results" ${LINT_RESULT}

echo "::endgroup::"
