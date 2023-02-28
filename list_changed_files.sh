#!/bin/bash

echo "::group::List Changed Files"

path_filters="$PATH_FILTERS"
path_filters=${path_filters/*[/}                 # Remove everything up to and including [ sign
path_filters=${path_filters/\]*/}                # Remove ] and everything after it
path_filters=${path_filters//,/}                 # Remove all occurrences of , sign
path_filters=$(echo "$path_filters" | tr \" \')  # Replace all double quotes by single quotes
echo "Applying path filters: ${path_filters}"

echo "git log --oneline"
echo $(git log --oneline)

# filter M = modified
command="git diff-tree --diff-filter=M --no-commit-id --name-only -r $CURRENT_HASH -- ${path_filters}"
echo $command 
list=$( eval $command)
echo "Changed files: $list"

# Remove CarriageReturn and LineFeed (CR/LF):
changed_files="${list[*]//$'\n'/ }"
echo "changed_files=${changed_files}" >> $GITHUB_OUTPUT

echo "::endgroup::"
