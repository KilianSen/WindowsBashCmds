@echo off
if "%1"=="" (
    echo Usage: head -n num file
    exit /b 1
)
if "%1"=="-n" (
    powershell -NoProfile -Command "Get-Content -Path '%~3' -TotalCount %~2"
) else (
    powershell -NoProfile -Command "Get-Content -Path '%~1' -TotalCount 10"
)
