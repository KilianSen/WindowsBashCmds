@echo off
if "%1"=="" (
    echo Usage: sleep seconds
    exit /b 1
)
powershell -NoProfile -Command "Start-Sleep -Seconds %1"
