@echo off
chcp 65001 > nul

REM Проверка на наличие прав Администратора
WHOAMI /PRIV | find /i "SeRemoteShutdownPrivilege" > nul

REM Если ошибок нет - значит права есть, переходим к деинсталяции
if %ERRORLEVEL% == 0 goto ADMIN

REM Если дошли сюда, то прав нет, вызываем планировщик, который запустит этот же файл с правами
schtasks /run /TN AdmCMD
exit

REM Эта часть должна выполняться только с правами Администратора
:ADMIN
set HOME=%SYSTEMDRIVE%%HOMEPATH%\ProjectStarter

REM Чистка в реестре записи о пункте в контекстном меню и о деинсталяции из списка приложений
REG DELETE "HKEY_CLASSES_ROOT\Directory\Background\shell\Развернуть Web проект" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter" /f

REM Удаление папки, куда была установка
if exist "%HOME%\" RMDIR "%HOME%\" /S /Q
exit