pyinstaller --name commonBird `
    --add-data "common_bird_app.tcss:." `
    --add-data "jQuertAjax.js:." `
    --add-data "node_modules:node_modules" `
    --add-binary "$((Get-Command node.exe).Source):." `
    cli.py

npm i markdown-to-html-cli -g

markdown-to-html -i "README.md" -o "dist/commonBird/README.html"

Copy-Item -Path "res" -Destination "dist/commonBird/res" -Recurse

# compress the build
Compress-Archive -Path "dist/commonBird" -DestinationPath "commonBird_win_x64.zip"