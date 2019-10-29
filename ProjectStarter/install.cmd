@echo off
chcp 65001 > nul

REM HOME - Папка, в которую будет выполнена установка
set HOME=%SYSTEMDRIVE%%HOMEPATH%\ProjectStarter

REM _THIS_HOME_ - Эта папка, откуда будет идти установка. Этот путь не должен заканчиваться слешем
set "_THIS_HOME_=%~d0%~p0"
set THIS_HOME=%_THIS_HOME_:~0,-1%

REM Копирование файлов из этой папки в папку установки
XCOPY "%THIS_HOME%\web" "%HOME%\web\" /Y /E /B /H
XCOPY "%THIS_HOME%\webpack" "%HOME%\webpack\" /Y /E /B /H
XCOPY "%THIS_HOME%\icon.ico" "%HOME%\" /Y /E /B /H
XCOPY "%THIS_HOME%\install.cmd" "%HOME%\" /Y /E /B /H
XCOPY "%THIS_HOME%\uninstall.cmd" "%HOME%\" /Y /E /B /H

REM Создание иконки на папке ProjectStarter
(
	echo [.ShellClassInfo]
    echo IconResource=%HOME%\icon.ico,0
) > "%HOME%\desktop.ini"
ATTRIB +S +H "%HOME%\desktop.ini"
REM Этот атрибут устанавливать обязательно, без него на папке не появляется иконка
ATTRIB +R "%HOME%"

REM Добавление в реестр записей с для вложенного пункта Web в контекстном меню
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web" /d "Развернуть простой Web проект"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web" /v "Icon" /d "%HOME%\web\icon.ico"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web\Command" /d "%HOME%\web\index.cmd"

REM Добавление в реестр записей с для вложенного пункта Webpack в контекстном меню
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack" /d "Развернуть Webpack проект"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack" /v "Icon" /d "%HOME%\webpack\icon.ico"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack\Command" /d "%HOME%\webpack\index.cmd"

REM Добавление в реестр записи основного меню с вложенными пунктами
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\ProjectStarter" /v "MUIVerb" /d "ProjectStarter"
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\ProjectStarter" /v "SubCommands" /d "ProjectStarter.web;ProjectStarter.webpack"
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\ProjectStarter" /v "Icon" /d "%HOME%\icon.ico"

REM Регистрация пункта деинсталяции в "Удалении или изменении программ"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "UninstallString" /d "%HOME%\uninstall.cmd"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "DisplayIcon" /d "%HOME%\icon.ico"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "DisplayName" /d "ProjectStarter"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "Publisher" /d "neyasbltb_88@mail.ru"

REM Создание планировщика, который позволит выполнить деинсталяцию от имени Администратора (чтобы почистить за собой реестр)
schtasks /create /TN "AdmCMD" /TR "%HOME%\uninstall.cmd" /SC ONCE /SD 28/10/3019 /ST 14:00 /RL HIGHEST /F