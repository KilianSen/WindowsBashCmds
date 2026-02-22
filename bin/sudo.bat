@echo off
setlocal enabledelayedexpansion

if "%~1"=="-h" (
    echo [WindowsBashCmds] sudo (elevate shell)
    echo Usage: sudo [command]
    echo This command is part of WindowsBashCmds.
    exit /b 0
)

set "ARGS=%*"

rem Get the parent process name to detect the shell
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "(Get-Process -Id (Get-Process -Id $pid).ParentProcessId).Name"') do set "PARENT_SHELL=%%i"

set "SHELL_EXE=cmd.exe"
set "IS_PS=0"

if "!PARENT_SHELL!"=="pwsh" (
    set "SHELL_EXE=pwsh.exe"
    set "IS_PS=1"
)
if "!PARENT_SHELL!"=="powershell" (
    set "SHELL_EXE=powershell.exe"
    set "IS_PS=1"
)

if "%ARGS%"=="" (
    powershell -NoProfile -Command "Start-Process !SHELL_EXE! -Verb RunAs"
) else (
    if !IS_PS! equ 1 (
        powershell -NoProfile -Command "Start-Process !SHELL_EXE! -Verb RunAs -ArgumentList '-NoExit', '-Command', '!ARGS!'"
    ) else (
        powershell -NoProfile -Command "Start-Process cmd -Verb RunAs -ArgumentList '/k !ARGS!'"
    )
)
endlocal
