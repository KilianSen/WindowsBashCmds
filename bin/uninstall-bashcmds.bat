@echo off
setlocal
echo.
echo [WindowsBashCmds] WARNING: This will remove WindowsBashCmds from your User PATH and PowerShell Profile.
set /p "CONFIRM=Are you sure you want to proceed? (y/n): "
if /i not "%CONFIRM%"=="y" (
    echo Uninstall cancelled.
    exit /b 0
)

powershell -ExecutionPolicy Bypass -File "%~dp0uninstall-bashcmds.ps1"
endlocal
