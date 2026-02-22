@echo off
setlocal enabledelayedexpansion
set "FLAGS="
set "USE_B=1"
set "REMAINING="

if "%~1"=="-h" (
    echo [WindowsBashCmds] ls (shim for dir)
    echo Usage: ls [-l] [-a] [-la] [-al] [-w] [path]
    echo This command is part of WindowsBashCmds.
    exit /b 0
)
if "%~1"=="--help" (
    echo [WindowsBashCmds] ls (shim for dir)
    echo Usage: ls [-l] [-a] [-la] [-al] [-w] [path]
    echo This command is part of WindowsBashCmds.
    exit /b 0
)

:parse_args
if "%~1"=="" goto run
set "arg=%~1"
if "!arg:~0,1!"=="-" (
    if "!arg!"=="-la" (
        set "FLAGS=/A"
        set "USE_B="
    ) else if "!arg!"=="-al" (
        set "FLAGS=/A"
        set "USE_B="
    ) else if "!arg!"=="-l" (
        set "USE_B="
    ) else if "!arg!"=="-a" (
        set "FLAGS=/A"
    ) else if "!arg!"=="-w" (
        set "FLAGS=/W"
    )
    shift
    goto parse_args
) else (
    goto collect_remaining
)

:collect_remaining
if "%~1"=="" goto run
set "REMAINING=!REMAINING! "%~1""
shift
goto collect_remaining

:run
if defined USE_B (
    dir /B %FLAGS% %REMAINING%
) else (
    dir %FLAGS% %REMAINING%
)
endlocal
