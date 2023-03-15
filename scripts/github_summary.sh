#!/bin/bash

function line_to_summary {
  line=$1
  set -x
  echo "${line}" >> $GITHUB_STEP_SUMMARY
  { set +x; } 2>/dev/null
}

function file_to_summary {
  file=$1
  OLD_IFS="$IFS"
  IFS=
  while read line; do
    line_to_summary "${line}"
  done < "$file"
  IFS="$OLD_IFS"
}

function create_title {
  title=$1
  line_to_summary "### $title"
}

function create_section {
  section_title=$1
  file=$2
  format=$3
  echo "::group::GitHub Summary $1 $2 $3"
  line_to_summary "#### $section_title"
  line_to_summary '```'"$format"
  file_to_summary $file
  line_to_summary '```'
  echo "::endgroup::"
}
