#!/bin/bash

echo "::group::List Changed Files"

echo "Applying path filters: ${PATH_FILTERS}"

echo "git log --oneline"
echo $(git log --oneline)

# filter M = modified
command="git diff-tree --diff-filter=M --no-commit-id --name-only -r $CURRENT_HASH -- ${PATH_FILTERS}"
echo $command 
list=$( eval $command)
echo "Changed files: $list"

# Remove CarriageReturn and LineFeed (CR/LF):
changed_files="${list[*]//$'\n'/ }"
echo "changed_files=${changed_files}" >> $GITHUB_OUTPUT

echo "::endgroup::"
