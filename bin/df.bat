@echo off
powershell -NoProfile -Command "Get-Volume | Select-Object DriveLetter, FriendlyName, @{Name='Size(GB)';Expression={'{0:N2}' -f ($_.Size/1GB)}}, @{Name='Free(GB)';Expression={'{0:N2}' -f ($_.SizeRemaining/1GB)}}, @{Name='Used(%)';Expression={'{0:P2}' -f (1 - ($_.SizeRemaining/ $_.Size))}} | Format-Table"
