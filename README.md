# OpenAPI Diff Tool

This is a sample project to demonstrate the capabilities of the 
open-source OpenAPI diff tool paired with GitHub actions.

## Usage

You can integrate this workflow into your project, by adding following snippet into your GitHub action workflow under `.github/workflows`:

```yml
name: Reuse Workflow Diff-Detection

on:
  label:
    types: [edited]
  push:
    branches: [main]
    paths: ['openapi/**/*.yml', 'openapi/**/*.yaml']
  pull_request:
    branches: [main]  

jobs:
  openapi-diff:
    uses: edgar-philipp/openapi-diff/.github/workflows/openapi-diff.yml@main
    with:
      path-filters: 'openapi/**/*.yml openapi/**/*.yaml'
      rule-overwrites: '{ "info-license": "off", "license-url": "off" }'
```


## Changing OpenAPI Files ..

📝 You can change the files in your project under `openapi/example`, commit and push the changes.

## .. Triggers GitHub Action

🚀 Upon each push, we have a GitHub action which will be triggered every time there is a change
in the `openapi/example` folder. 

You can watch it in action in the Actions tab under GitHub:
![GitHub-Action](./images/GitHub-Action-Triggered-on-Changed-OpenAPI-Files.png "GitHub Action Triggered on Changed OpenAPI Files")

The action will detect all changed files, show the diff for each file and check the backwards compatibility 
of the changes to the OpenAPI specification. 

In the example shown, the diff detection ran on two different specifications:
 - ✅ the spec `cats.yaml` was changed in a compatible way, 
 - ❌ as opposed to `dogs.yml`, containing a breaking change.

## Updating the OpenAPI Diff Tool

The OpenAPI Diff CLI tool is already available under `openapi-diff-cli-2.1.0.jar`.

> ℹ️ **NOTE:** You can skip this step, unless you want to update the dependency.

🔨 In order to update the dependency, you can trigger the following Bash script to create the executable jar:
`create_openapi_diff_cli.sh`

Upon successful execution, it will generate the file `openapi-diff-cli-2.1.0.jar` (which is already present).
This is a convenient way to update to the latest dependency and use this version.

