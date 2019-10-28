@echo off
chcp 65001 > nul

REM Путь к домашней папке установки, откуда брать рабочие скрипты
set HOME=%~d0%~p0\project

REM Запрос названия проекта, оно так же будет подставлено в файлы проекта
set /p PROJECT_NAME=Введите название проекта:

REM Создание папок под новый проект
md "%PROJECT_NAME%"
md "%PROJECT_NAME%\src"
md "%PROJECT_NAME%\dist"
md "%PROJECT_NAME%\src\css"
md "%PROJECT_NAME%\src\js"

REM Запуск рабочих скриптов и запись того, что они возвращают в файлы
call %HOME%\README.md.cmd > "%PROJECT_NAME%\README.md"
call %HOME%\project-web.code-workspace.cmd > "%PROJECT_NAME%\%PROJECT_NAME%.code-workspace"
call %HOME%\package.json.cmd > "%PROJECT_NAME%\package.json"
call %HOME%\webpack.config.js.cmd > "%PROJECT_NAME%\webpack.config.js"
call %HOME%\.gitignore.cmd > "%PROJECT_NAME%\.gitignore"

call %HOME%\index.html.cmd > "%PROJECT_NAME%\src\index.html"
call %HOME%\css\style.css.cmd > "%PROJECT_NAME%\src\css\style.css"
call %HOME%\js\index.js.cmd > "%PROJECT_NAME%\src\js\index.js"

REM Переход в папку нового проекта
cd "%PROJECT_NAME%"

REM Инициализация репозитория
git init > nul
REM Копирование глобальных настроек в папку проекта. Без этого при коммите гит ругался на отсутствие авторизации
if exist %USERPROFILE%\.gitconfig type %USERPROFILE%\.gitconfig >> ".git\config"
git add . > nul
git commit -am "Initial commit" > nul

REM Запуск VS Code и открытие в нем папки проекта
start code .