#!/bin/bash

echo "::group::List Added Files"

echo "Applying path filters: ${PATH_FILTERS}"

echo "git log --oneline"
echo $(git log --oneline)

# filter A = added
command="git diff-tree --diff-filter=A --no-commit-id --name-only -r $CURRENT_HASH -- ${PATH_FILTERS}"
echo $command 
list=$( eval $command)
echo "Added files: $list"

# Remove CarriageReturn and LineFeed (CR/LF):
added_files="${list[*]//$'\n'/ }"
echo "added_files=${added_files}" >> $GITHUB_OUTPUT

echo "::endgroup::"
