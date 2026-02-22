# diff.ps1
param([string]$File1, [string]$File2)
Compare-Object (Get-Content -Path $File1) (Get-Content -Path $File2)
