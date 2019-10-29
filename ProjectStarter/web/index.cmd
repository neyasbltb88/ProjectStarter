@echo off
chcp 65001 > nul

REM Путь к домашней папке установки, откуда брать рабочие скрипты
set HOME=%~d0%~p0\project

echo === Старт Web проекта ===
echo.

REM Запрос названия проекта, оно так же будет подставлено в файлы проекта
set /p PROJECT_NAME=Введите название проекта:

REM Создание папок под новый проект
md "%PROJECT_NAME%"
md "%PROJECT_NAME%\css"
md "%PROJECT_NAME%\js"

REM Запуск рабочих скриптов и запись того, что они возвращают в файлы
call %HOME%\index.html.cmd > "%PROJECT_NAME%\index.html"
call %HOME%\css\style.css.cmd > "%PROJECT_NAME%\css\style.css"
call %HOME%\js\index.js.cmd > "%PROJECT_NAME%\js\index.js"

REM Переход в папку нового проекта
cd "%PROJECT_NAME%"

REM Запуск VS Code и открытие в нем папки проекта
start code .