# uptime.ps1
(Get-Date) - (Get-Process -Name idle -ErrorAction SilentlyContinue).StartTime | Select-Object -Property Days, Hours, Minutes, Seconds
