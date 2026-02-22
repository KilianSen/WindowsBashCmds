@echo off
if "%1"=="" or "%2"=="" (
    echo Usage: diff file1 file2
    exit /b 1
)
powershell -NoProfile -Command "Compare-Object (Get-Content -Path '%~1') (Get-Content -Path '%~2')"
