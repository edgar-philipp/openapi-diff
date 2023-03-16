#!/bin/bash

if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
  before="${GITHUB_BASE_REF}"
  now="${GITHUB_HEAD_REF}"
  git checkout "${before}"
  git checkout "${now}"
elif [ "$GITHUB_EVENT_NAME" = "push" ]; then 
  before="${PREVIOUS_HASH}"
  now="${CURRENT_HASH}"
else 
  echo "Usage: currently, only push and pull_request are supported GitHub events."
  exit 1
fi
