#!/bin/bash

echo "::group::Lint Report"

linter_dir=${GITHUB_WORKSPACE}/workflow-repo/linter
source ${GITHUB_WORKSPACE}/workflow-repo/scripts/github_summary.sh

echo "Lint report saved:"
ls ${LINT_RESULT}
echo "### Lint report" >> $GITHUB_STEP_SUMMARY

create_section "Spectral file" ${linter_dir}/spectral.yml yaml
create_section "Results" ${LINT_RESULT}

echo "::endgroup::"
