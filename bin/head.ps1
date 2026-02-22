# head.ps1
param([string]$Path, [int]$n = 10)
Get-Content -Path $Path -TotalCount $n
