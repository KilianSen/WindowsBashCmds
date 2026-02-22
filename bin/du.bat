@echo off
if "%1"=="" (
    powershell -NoProfile -Command "Get-ChildItem -Recurse | Measure-Object -Property Length -Sum | Select-Object @{Name='Size(MB)';Expression={'{0:N2}' -f ($_.Sum / 1MB)}}"
) else (
    powershell -NoProfile -Command "Get-ChildItem -Path '%~1' -Recurse | Measure-Object -Property Length -Sum | Select-Object @{Name='Size(MB)';Expression={'{0:N2}' -f ($_.Sum / 1MB)}}"
)
