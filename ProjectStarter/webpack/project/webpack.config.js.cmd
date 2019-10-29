@echo off
chcp 65001 > nul

echo const webpack = require('webpack');
echo const path = require('path');
echo const CopyPlugin = require('copy-webpack-plugin');
echo const { CleanWebpackPlugin } = require('clean-webpack-plugin');
echo const HtmlWebpackPlugin = require('html-webpack-plugin');
echo.
echo const NODE_ENV = process.env.NODE_ENV ^|^| 'development';
echo.
echo let config = {
echo     mode: NODE_ENV,
echo     context: path.resolve(__dirname, 'src'),
echo.
echo     entry: {
echo         './js/index': './js/index.js'
echo     },
echo.
echo     output: {
echo         path: path.resolve(__dirname, 'dist'),
echo         filename: '[name].js'
echo     },
echo.
echo     watch: NODE_ENV === 'development',
echo     watchOptions: {
echo         aggregateTimeout: 100
echo     },
echo.
echo     devServer: {
echo         contentBase: path.join(__dirname, 'dist'),
echo         watchContentBase: NODE_ENV === 'development' ? true : false,
echo         port: 3000,
echo         open: true,
echo         // Для полной перезагрузки при изменении в html, нужен режим liveReload
echo         liveReload: NODE_ENV === 'development' ? true : false,
echo         // Для горячей замены модулей, при разработке SPA на фреймворках, нужен режим hot
echo         // При включении режима hot, перестает работать режим liveReload
echo         // hot: NODE_ENV === 'development' ? true : false,
echo         writeToDisk: false,
echo         disableHostCheck: true,
echo         headers: {
echo             'Access-Control-Allow-Origin': '*',
echo             'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
echo             'Access-Control-Allow-Headers': 'X-Requested-With, content-type, Authorization'
echo         },
echo         overlay: {
echo             warnings: true,
echo             errors: true
echo         },
echo     },
echo.
echo     devtool: NODE_ENV === 'development' ? 'inline-source-map' : false,
echo     plugins: [
echo         new CleanWebpackPlugin(),
echo         new webpack.DefinePlugin({
echo             NODE_ENV: JSON.stringify(NODE_ENV)
echo         }),
echo         new HtmlWebpackPlugin({
echo             template: './index.html'
echo         })
echo     ],
echo.
echo     module: {
echo         rules: [
echo             {
echo                 test: /\.js$/,
echo                 exclude: /node_modules/,
echo                 use: {
echo                     loader: 'babel-loader',
echo                     options: {
echo                         presets: ['@babel/preset-env'],
echo                         plugins: ['@babel/plugin-proposal-class-properties']
echo                     }
echo                 }
echo             },
echo             {
echo                 test: /\.txt$^|\.png$^|\.jpg$^|\.jpeg$^|\.svg$/i,
echo                 use: [
echo                     {
echo                         loader: 'url-loader',
echo                         options: {
echo                             fallback: 'file-loader'
echo                         }
echo                     }
echo                 ]
echo             },
echo             {
echo                 test: /\.css$/,
echo                 use: ['style-loader', 'css-loader']
echo             },
echo             {
echo                 test: /\.scss$/,
echo                 use: ['style-loader', 'css-loader', 'sass-loader']
echo             },
echo             {
echo                 test: /\.sass$/,
echo                 use: [
echo                     'style-loader',
echo                     'css-loader',
echo                     {
echo                         loader: 'sass-loader',
echo                         options: {
echo                             sassOptions: {
echo                                 indentedSyntax: true
echo                             }
echo                         }
echo                     }
echo                 ]
echo             }
echo         ]
echo     },
echo.
echo     resolve: {
echo         extensions: ['index.js', '.js', '.css', '*']
echo     }
echo };
echo.
echo module.exports = config;
