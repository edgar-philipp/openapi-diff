#!/bin/bash

echo "::group::Lint Report"

linter_dir=${GITHUB_WORKSPACE}/workflow-repo/linter
source ${GITHUB_WORKSPACE}/workflow-repo/scripts/github_summary.sh

echo "Lint report saved:"
ls ${LINT_RESULT}
create_title "Lint report"

create_section "Spectral file" ${linter_dir}/spectral.yml yaml
create_section "Results" ${LINT_RESULT} java

echo "::endgroup::"

if grep -q "unrecognized-format" "${LINT_RESULT}"; then
  echo "::error::Unrecognized format on ${CHANGED_FILE}"
  exit 1
fi
