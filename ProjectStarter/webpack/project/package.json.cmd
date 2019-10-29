@echo off
chcp 65001 > nul

echo {
echo     "name": "%PROJECT_NAME%",
echo     "version": "1.0.0",
echo     "description": "",
echo     "main": "js/index.js",
echo     "scripts": {
echo         "dev": "cross-env NODE_ENV=development webpack-dev-server",
echo         "build": "cross-env NODE_ENV=production webpack",
echo         "predeploy": "npm run build",
echo         "deploy": "gh-pages -d dist",
echo         "clear": "rm -r dist/ && rm stats.json"
echo     },
echo     "author": "",
echo     "license": "ISC",
echo     "devDependencies": {
echo         "@babel/core": "^7.6.3",
echo         "@babel/plugin-proposal-class-properties": "^7.5.5",
echo         "@babel/preset-env": "^7.6.3",
echo         "babel-loader": "^8.0.6",
echo         "copy-webpack-plugin": "^5.0.4",
echo         "clean-webpack-plugin": "^3.0.0",
echo         "cross-env": "^6.0.3",
echo         "css-loader": "^3.2.0",
echo         "file-loader": "^4.2.0",
echo         "gh-pages": "^2.1.1",
echo         "html-webpack-plugin": "^3.2.0",
echo         "node-sass": "^4.12.0",
echo         "raw-loader": "^3.1.0",
echo         "sass-loader": "^8.0.0",
echo         "style-loader": "^1.0.0",
echo         "url-loader": "^2.2.0",
echo         "webpack": "^4.41.0",
echo         "webpack-cli": "^3.3.9",
echo         "webpack-dev-server": "^3.8.2"
echo     }
echo }