#!/bin/bash

echo "::group::Lint Report"

echo "Lint report saved:"
ls ${LINT_RESULT}
echo "### Lint report" >> $GITHUB_STEP_SUMMARY

linter_dir=${GITHUB_WORKSPACE}/workflow-repo/linter
source ./github_summary.sh

create_section "Spectral file" ${linter_dir}/spectral.yml yaml
create_section "Results" ${LINT_RESULT}

echo "::endgroup::"
