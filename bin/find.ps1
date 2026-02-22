# find.ps1
param([string]$Path = ".", [string]$Name)
if ($Name) { Get-ChildItem -Path $Path -Filter $Name -Recurse | Select-Object FullName }
else { Get-ChildItem -Path $Path -Recurse | Select-Object FullName }
