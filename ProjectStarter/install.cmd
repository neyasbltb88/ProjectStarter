@echo off
chcp 65001 > nul

REM HOME - Папка, в которую будет выполнена установка
set HOME=%SYSTEMDRIVE%%HOMEPATH%\ProjectStarter

REM _THIS_HOME_ - Эта папка, откуда будет идти установка. Этот путь не должен заканчиваться слешем
set "_THIS_HOME_=%~d0%~p0"
set THIS_HOME=%_THIS_HOME_:~0,-1%

REM Копирование файлов из этой папки в папку установки
XCOPY "%THIS_HOME%" "%HOME%\" /Y /E /B

REM Добавление в реестр записей с для нового пункта в контекстном меню
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\Развернуть Web проект" /v "Icon" /d "%HOME%\web\icon.ico" /f
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\Развернуть Web проект\Command" /d "%HOME%\web\index.cmd" /f

REM Добавление записи в реестр, нужной для отображения деинсталяции
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "UninstallString" /d "%HOME%\uninstall.cmd" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "DisplayIcon" /d "%HOME%\web\icon.ico" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "DisplayName" /d "ProjectStarter" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /v "Publisher" /d "neyasbltb_88@mail.ru" /f

REM Создание планировщика, который позволит выполнить деинсталяцию от имени Администратора (чтобы почистить за собой реестр)
schtasks /create /TN "AdmCMD" /TR "%HOME%\uninstall.cmd" /SC ONCE /SD 28/10/3019 /ST 14:00 /RL HIGHEST /F