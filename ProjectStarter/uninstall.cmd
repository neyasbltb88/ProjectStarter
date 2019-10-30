@echo off
chcp 65001 > nul

echo UNINSTALL

REM Проверка на наличие прав Администратора
WHOAMI /PRIV | find /i "SeRemoteShutdownPrivilege" > nul

REM Если ошибок нет - значит права есть, переходим к деинсталяции
if %ERRORLEVEL% == 0 goto ADMIN

REM Если дошли сюда, то прав нет, вызываем планировщик, который запустит этот же файл с правами
schtasks /run /TN AdmCMD
exit

REM Эта часть должна выполняться только с правами Администратора
:ADMIN
set HOME=%USERPROFILE%\ProjectStarter

REM Чистка в реестре записи о пункте в контекстном меню и о деинсталяции из списка приложений
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /f /reg:64
REG DELETE "HKEY_CLASSES_ROOT\Directory\Background\shell\ProjectStarter" /f /reg:64
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web" /f /reg:64
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack" /f /reg:64

REM Удаление папки, куда была установка
if exist "%HOME%\" RMDIR "%HOME%\" /S /Q
exit