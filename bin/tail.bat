@echo off
if "%1"=="" (
    echo Usage: tail [-f] [-n num] file
    exit /b 1
)
if "%1"=="-f" (
    powershell -NoProfile -Command "Get-Content -Path '%~2' -Wait -Tail 10"
) else if "%1"=="-n" (
    powershell -NoProfile -Command "Get-Content -Path '%~3' -Tail %~2"
) else (
    powershell -NoProfile -Command "Get-Content -Path '%~1' -Tail 10"
)
