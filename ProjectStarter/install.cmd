@echo off
chcp 65001 > nul

REM HOME - Папка, в которую будет выполнена установка
set HOME=%USERPROFILE%\ProjectStarter

REM _THIS_HOME_ - Эта папка, откуда будет идти установка. Этот путь не должен заканчиваться слешем
set "_THIS_HOME_=%~d0%~p0"
set THIS_HOME=%_THIS_HOME_:~0,-1%

echo INSTALL
echo %THIS_HOME%

IF EXIST "%HOME%" RMDIR "%HOME%" /S /Q
MD "%HOME%"

echo ===^> Копирование файлов из папки установки в %HOME%
echo ===^> Копирование файлов из папки установки в %HOME% >> "%HOME%\log.txt"
XCOPY "%THIS_HOME%\web" "%HOME%\web\" /Y /E /B /H >> "%HOME%\log.txt"
XCOPY "%THIS_HOME%\webpack" "%HOME%\webpack\" /Y /E /B /H >> "%HOME%\log.txt"
XCOPY "%THIS_HOME%\icon.ico" "%HOME%\" /Y /H >> "%HOME%\log.txt"
XCOPY "%THIS_HOME%\uninstall.cmd" "%HOME%\" /Y /H >> "%HOME%\log.txt"

echo. >> "%HOME%\log.txt"
echo ===^> Создание иконки на папке ProjectStarter
echo ===^> Создание иконки на папке ProjectStarter >> "%HOME%\log.txt"
(
	echo [.ShellClassInfo]
    echo IconResource=%HOME%\icon.ico,0
) > "%HOME%\desktop.ini"
REM Этот атрибут устанавливать обязательно, без него на папке не появляется иконка
ATTRIB +R "%HOME%"
ATTRIB +S +H "%HOME%\desktop.ini"

(
    chcp 1251 > nul
    echo. >> "%HOME%\log.txt"
    echo ===^> Добавление в реестр записей с для вложенного пункта Web в контекстном меню
    echo ===^> Добавление в реестр записей с для вложенного пункта Web в контекстном меню >> "%HOME%\log.txt"
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web" /d "Развернуть простой Web проект" /reg:64 /f > nul
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web" /v "Icon" /d "%HOME%\web\icon.ico" /reg:64 /f > nul
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web\Command" /d "%HOME%\web\index.cmd" /reg:64 /f > nul

    echo. >> "%HOME%\log.txt"
    echo ===^> Добавление в реестр записей с для вложенного пункта Webpack в контекстном меню
    echo ===^> Добавление в реестр записей с для вложенного пункта Webpack в контекстном меню >> "%HOME%\log.txt"
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack" /d "Развернуть Webpack проект" /reg:64 /f > nul
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack" /v "Icon" /d "%HOME%\webpack\icon.ico" /reg:64 /f > nul
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack\Command" /d "%HOME%\webpack\index.cmd" /reg:64 /f > nul

    echo. >> "%HOME%\log.txt"
    echo ===^> Добавление в реестр записи основного меню с вложенными пунктами
    echo ===^> Добавление в реестр записи основного меню с вложенными пунктами >> "%HOME%\log.txt"
    REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\ProjectStarter" /v "MUIVerb" /d "ProjectStarter" /reg:64 /f > nul
    REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\ProjectStarter" /v "SubCommands" /d "ProjectStarter.web;ProjectStarter.webpack" /reg:64 /f > nul
    REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\ProjectStarter" /v "Icon" /d "%HOME%\icon.ico" /reg:64 /f > nul


    echo. >> "%HOME%\log.txt"
    echo ===^> Регистрация пункта деинсталяции в "Удалении или изменении программ"
    echo ===^> Регистрация пункта деинсталяции в "Удалении или изменении программ" >> "%HOME%\log.txt"
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "UninstallString" /d "%HOME%\uninstall.cmd" /reg:64 /f > nul
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "DisplayIcon" /d "%HOME%\icon.ico" /reg:64 /f > nul
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "DisplayName" /d "ProjectStarter" /reg:64 /f > nul
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "Publisher" /d "neyasbltb_88@mail.ru" /reg:64 /f > nul

    chcp 65001 > nul
)

echo. >> "%HOME%\log.txt"
echo ===^> Создание планировщика, который позволит выполнить деинсталяцию от имени Администратора (чтобы почистить за собой реестр)
echo ===^> Создание планировщика, который позволит выполнить деинсталяцию от имени Администратора (чтобы почистить за собой реестр) >> "%HOME%\log.txt"
schtasks /create /TN "AdmCMD" /TR "%HOME%\uninstall.cmd" /SC ONCE /SD 28/10/3019 /ST 14:00 /RL HIGHEST /F >> "%HOME%\log.txt"