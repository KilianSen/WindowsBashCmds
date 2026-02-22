@echo off
setlocal
set "RECURSIVE="
set "FORCE="

if "%~1"=="-h" (
    echo [WindowsBashCmds] rm (shim for del/rd)
    echo Usage: rm [-rf] target
    echo This command is part of WindowsBashCmds.
    exit /b 0
)

:parse_args
if "%1"=="-rf" (
    set "RECURSIVE=1"
    set "FORCE=1"
    shift
    goto parse_args
)
if "%1"=="-f" (
    set "FORCE=1"
    shift
    goto parse_args
)
if "%1"=="-r" (
    set "RECURSIVE=1"
    shift
    goto parse_args
)

if "%1"=="" (
    echo Usage: rm [-rf] target
    exit /b 1
)

set "TARGET=%~1"

if not exist "%TARGET%" (
    if not defined FORCE (
        echo rm: %TARGET%: No such file or directory
        exit /b 1
    )
    exit /b 0
)

rem Check if directory
dir /a:d "%TARGET%" >nul 2>nul
if %errorlevel% equ 0 (
    if defined RECURSIVE (
        rd /s /q "%TARGET%"
    ) else (
        echo rm: %TARGET%: is a directory
        exit /b 1
    )
) else (
    del /f /q "%TARGET%"
)
endlocal
