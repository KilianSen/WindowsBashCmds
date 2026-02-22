@echo off
setlocal
set "CASE_INSENSITIVE="
set "RECURSIVE="

:parse_args
if "%1"=="-i" (
    set "CASE_INSENSITIVE=-CaseSensitive:$false"
    shift
    goto parse_args
)
if "%1"=="-r" (
    set "RECURSIVE=1"
    shift
    goto parse_args
)

if "%1"=="" (
    echo Usage: grep [-i] [-r] pattern [file]
    exit /b 1
)

set "PATTERN=%~1"
shift

if "%RECURSIVE%"=="1" (
    if "%1"=="" (
        powershell -NoProfile -Command "Get-ChildItem -Recurse | Select-String -Pattern '%PATTERN%' %CASE_INSENSITIVE%"
    ) else (
        powershell -NoProfile -Command "Get-ChildItem -Path '%~1' -Recurse | Select-String -Pattern '%PATTERN%' %CASE_INSENSITIVE%"
    )
) else (
    if "%1"=="" (
        powershell -NoProfile -Command "$Input | Select-String -Pattern '%PATTERN%' %CASE_INSENSITIVE%"
    ) else (
        powershell -NoProfile -Command "Select-String -Path '%~1' -Pattern '%PATTERN%' %CASE_INSENSITIVE%"
    )
)
endlocal
