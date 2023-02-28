#!/bin/bash

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
java -jar openapi-diff-cli-2.1.0.jar ${CHANGED_FILE}_old.yml ${CHANGED_FILE}_new.yml --fail-on-incompatible
if [ $? -ne 0 ]; then
  exit 1
fi

echo "::endgroup::"
