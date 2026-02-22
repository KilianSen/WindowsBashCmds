@echo off
setlocal enabledelayedexpansion

if "%~1"=="-h" (
    echo [WindowsBashCmds] touch (create/update file)
    echo Usage: touch filename1 [filename2 ...]
    echo This command is part of WindowsBashCmds.
    exit /b 0
)

if "%~1"=="" (
    echo Usage: touch filename1 [filename2 ...]
    exit /b 1
)

:loop
if "%~1"=="" goto end
if exist "%~1" (
    copy /b "%~1" +,, >nul 2>nul
) else (
    type nul > "%~1"
)
shift
goto loop

:end
endlocal
