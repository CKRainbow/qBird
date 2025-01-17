#!/bin/bash

latest_tag=$1
github_api_token= $2

echo "APP_VERSION=\"$latest_tag\"" >> src/utils/consts.py
echo "GITHUB_API_TOKEN=\"$github_api_token\"" >> src/utils/consts.py

# build
pyinstaller --name commonBird \
    --add-data "common_bird_app.tcss:." \
    --add-data "jQuertAjax.js:." \
    --add-data "node_modules:node_modules" \
    --add-binary "$(which node):." \
    cli.py

npm i markdown-to-html-cli -g

markdown-to-html -i README.md -o dist/commonBird/README.html

cp -r res dist/commonBird/res
cp -r database dist/commonBird/database

# compress the build
tar cvzf commonBird_mac_x64.tar.gz dist/commonBird/
