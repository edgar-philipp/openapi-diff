#!/bin/bash
VERSION=2.1.0
BASE_DIR=$(pwd)

rm -rf .build

git clone https://github.com/OpenAPITools/openapi-diff.git .build

cd .build/cli
mvn clean install
cp target/openapi-diff-cli-"$VERSION"-SNAPSHOT-all.jar "$BASE_DIR"/openapi-diff-cli-"$VERSION".jar

cd "$BASE_DIR"
rm -rf .build