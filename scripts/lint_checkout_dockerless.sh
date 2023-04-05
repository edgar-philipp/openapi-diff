#!/bin/bash

echo "::group::Init Linter"

workflow_dir=${GITHUB_WORKSPACE}/workflow-repo

cd "$workflow_dir"
echo "Building Spectral"
npm install .

echo "Checking Spectral installation"
"$workflow_dir"/node_modules/".bin"/spectral --version

echo "::endgroup::"
