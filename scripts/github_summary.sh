#!/bin/bash

function file_to_summary {
  file=$1
  OLD_IFS="$IFS"
  IFS=
  while read line; do
    echo "${line}" >> $GITHUB_STEP_SUMMARY
  done < "$file"
  IFS="$OLD_IFS"
}

function create_section {
  section_title=$1
  file=$2
  format=$3
  echo "#### $section_title" >> $GITHUB_STEP_SUMMARY
  echo '```$format' >> $GITHUB_STEP_SUMMARY
  file_to_summary $file
  echo '```' >> $GITHUB_STEP_SUMMARY
}
