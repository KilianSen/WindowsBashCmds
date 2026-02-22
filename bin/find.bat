@echo off
if "%1"=="" (
    echo Usage: find [path] [-name pattern]
    exit /b 1
)
if "%2"=="-name" (
    powershell -NoProfile -Command "Get-ChildItem -Path '%~1' -Filter '%~3' -Recurse | Select-Object FullName"
) else (
    powershell -NoProfile -Command "Get-ChildItem -Path '%~1' -Recurse | Select-Object FullName"
)
