#!/bin/bash

if [ "$OPERATION" = "Added" ]; then
  flag="A"
elif [ "$OPERATION" = "Deleted" ]; then
  flag="D"
elif [[ $OPERATION = Modified || $OPERATION = Changed ]]; then
  flag="M"
else 
  echo "Usage: OPERATION must be one of ['Added', 'Deleted', 'Modified', 'Changed']"
  exit 1
fi

source ${GITHUB_WORKSPACE}/workflow-repo/scripts/git_revisions.sh

echo "::group::List ${OPERATION} Files"

echo "Applying path filters: ${PATH_FILTERS}"

echo "git log --oneline ${before}..${now}"
echo $(git log --oneline "${before}".."${now}")

command="git diff-tree --diff-filter=${flag} --no-commit-id --name-only -r ${before}..${now} -- ${PATH_FILTERS}"
echo $command 
list=$( eval $command)
echo "${OPERATION} files: $list"

# Remove CarriageReturn and LineFeed (CR/LF):
changed_files="${list[*]//$'\n'/ }"
echo "changed_files=${changed_files}" >> $GITHUB_OUTPUT

echo "::endgroup::"
