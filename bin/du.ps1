# du.ps1
param([string]$Path = ".")
Get-ChildItem -Path $Path -Recurse | Measure-Object -Property Length -Sum | Select-Object @{Name='Size(MB)';Expression={'{0:N2}' -f ($_.Sum / 1MB)}}
