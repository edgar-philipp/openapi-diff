
#!/bin/bash

echo "::group::Init Linter"

cd ..
echo "Building Spectral"
npm install .

echo "Checking Spectral installation"
./node_modules/".bin"/spectral --version

echo "::endgroup::"
