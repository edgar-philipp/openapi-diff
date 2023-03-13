#!/bin/bash
CLI_VERSION=2.1.0
BASE_DIR=$(pwd)

rm -rf .build

git clone https://github.com/OpenAPITools/openapi-diff.git .build

cd .build/cli
mvn clean install
cp target/openapi-diff-cli-"$CLI_VERSION"-SNAPSHOT-all.jar "$BASE_DIR"/scripts/openapi-diff-cli-"$CLI_VERSION".jar

cd "$BASE_DIR"
rm -rf .build
