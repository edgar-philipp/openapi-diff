#!/bin/bash

echo "::group::Lint Report"

function file_to_summary {
  while read line; do
    echo "${line}" >> $GITHUB_STEP_SUMMARY
  done < "$1"
}

echo "Lint report saved:"
ls ${LINT_RESULT}
echo "### Lint report" >> $GITHUB_STEP_SUMMARY

echo "#### Spectral file" >> $GITHUB_STEP_SUMMARY
echo '```' >> $GITHUB_STEP_SUMMARY
linter_dir=${GITHUB_WORKSPACE}/workflow-repo/linter
file_to_summary ${linter_dir}/spectral.yml
echo '```' >> $GITHUB_STEP_SUMMARY

echo "#### Results"
echo '```' >> $GITHUB_STEP_SUMMARY
file_to_summary ${LINT_RESULT}
echo '```' >> $GITHUB_STEP_SUMMARY

echo "::endgroup::"
