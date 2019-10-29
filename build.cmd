@echo off
chcp 65001 > nul

set "_THIS_HOME_=%~d0%~p0"
set THIS_HOME=%_THIS_HOME_:~0,-1%

set BUILDER_PATH=%THIS_HOME%\builder
set Z=%THIS_HOME%\builder\7z
set SFX=%THIS_HOME%\builder\7zS2.sfx

REM Если есть прошлая сборка, удалим ее
IF EXIST "%THIS_HOME%\ProjectStarterInstall.exe" DEL /Q /F "%THIS_HOME%\ProjectStarterInstall.exe"

REM Создание основного установочного архива
"%Z%\7za.exe" a -mx1 "%BUILDER_PATH%\Install.7z" "%THIS_HOME%\ProjectStarter\*" > nul

REM Создание конфига самораспаковывающегося архива
(
    echo ;!@Install@!UTF-8!
    echo Title="ProjectStarter Install"
    echo RunProgram="install.cmd"
    echo ExecuteParameters="/S"
    echo ;!@InstallEnd@!
) > "%BUILDER_PATH%\sfx.config"

REM Создание самораспаковывающегося архива
copy /b "%SFX%" + "%BUILDER_PATH%\sfx.config" + "%BUILDER_PATH%\Install.7z" "%THIS_HOME%\ProjectStarterInstall.exe" > nul

REM Удаление временных файлов, нужных для создания самораспаковывающегося архива
IF EXIST "%BUILDER_PATH%\sfx.config" DEL /Q /F "%BUILDER_PATH%\sfx.config"
IF EXIST "%BUILDER_PATH%\Install.7z" DEL /Q /F "%BUILDER_PATH%\Install.7z"