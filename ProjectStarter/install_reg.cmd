@echo off
chcp 1251 > nul
echo Windows Registry Editor Version 5.00
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web]
echo @="Развернуть простой Web проект"
echo "Icon"="%HOME%\web\icon.ico"
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.web\Command]
echo @="%HOME%\web\index.cmd"
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack]
echo @="Развернуть Webpack проект"
echo "Icon"="%HOME%\webpack\icon.ico"
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ProjectStarter.webpack\Command]
echo @="%HOME%\webpack\index.cmd"
echo.
echo [HKEY_CLASSES_ROOT\Directory\Background\shell\ProjectStarter]
echo "MUIVerb"="ProjectStarter"
echo "SubCommands"="ProjectStarter.web;ProjectStarter.webpack"
echo "Icon"="%HOME%\icon.ico"
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProjectStarter]
echo "UninstallString"="%HOME%\uninstall.cmd"
echo "DisplayIcon"="%HOME%\icon.ico"
echo "DisplayName"="ProjectStarter"
echo "Publisher"="neyasbltb_88@mail.ru"
chcp 65001 > nul