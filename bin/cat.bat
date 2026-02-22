@echo off
if "%~1"=="-h" (
    echo [WindowsBashCmds] cat (shim for type)
    echo Usage: cat [file]
    echo This command is part of WindowsBashCmds.
    exit /b 0
)
type %*
