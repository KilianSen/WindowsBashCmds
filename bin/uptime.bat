@echo off
powershell -NoProfile -Command "(Get-Date) - (Get-Process -Name idle).StartTime | Select-Object -Property Days, Hours, Minutes, Seconds"
