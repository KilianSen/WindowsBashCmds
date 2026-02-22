# tail.ps1
param([string]$Path, [int]$n = 10, [switch]$f)
if ($f) { Get-Content -Path $Path -Wait -Tail $n }
else { Get-Content -Path $Path -Tail $n }
