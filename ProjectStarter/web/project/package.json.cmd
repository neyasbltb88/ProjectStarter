@echo off
chcp 65001 > nul

echo {
echo     "name": "%PROJECT_NAME%",
echo     "version": "1.0.0",
echo     "description": "",
echo     "main": "js/index.js",
echo     "scripts": {
echo         "test": "echo \"Error: no test specified\" && exit 1"
echo     },
echo     "author": "",
echo     "license": "ISC"
echo }