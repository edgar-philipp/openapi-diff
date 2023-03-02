#!/bin/bash

if [ $OPERATION -eq "Added" ]; then
  $flag="A"
elif [ $OPERATION -eq "Deleted" ]; then
  $flag="D"
elif [ $OPERATION -eq "Modified" ]; then
	$flag="M"
elif [ $OPERATION -eq "Changed" ]; then
	$flag="M"
else 
  echo "Usage: OPERATION must be one of ['Added', 'Deleted', 'Modified', 'Changed']"
  exit(1)
fi

echo "::group::List ${OPERATION} Files"

echo "Applying path filters: ${PATH_FILTERS}"

echo "git log --oneline"
echo $(git log --oneline)

command="git diff-tree --diff-filter=${flag} --no-commit-id --name-only -r $CURRENT_HASH -- ${PATH_FILTERS}"
echo $command 
list=$( eval $command)
echo "${OPERATION} files: $list"

# Remove CarriageReturn and LineFeed (CR/LF):
changed_files="${list[*]//$'\n'/ }"
echo "changed_files=${changed_files}" >> $GITHUB_OUTPUT

echo "::endgroup::"
