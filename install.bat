@echo off
setlocal
echo [WindowsBashCmds] Starting installation...
echo This will add the bin/ directory to your User PATH and configure your PowerShell Profile.
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0install.ps1"

if %errorlevel% equ 0 (
    echo.
    echo [WindowsBashCmds] Installation successful!
    echo Please restart your terminal to start using the commands.
    echo Run 'uninstall-bashcmds' to remove.
) else (
    echo [WindowsBashCmds] Installation failed with error code %errorlevel%.
)

endlocal
pause
