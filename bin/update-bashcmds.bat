@echo off
setlocal
if "%~1"=="-h" (
    echo [WindowsBashCmds] update-bashcmds
    echo Usage: update-bashcmds
    echo This command pulls the latest versions of all shims from the GitHub repository.
    exit /b 0
)

powershell -ExecutionPolicy Bypass -File "%~dp0update-bashcmds.ps1"
endlocal
