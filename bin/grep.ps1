# grep.ps1
param([string]$Pattern, [string]$Path, [switch]$i, [switch]$r)
$params = @{ Pattern = $Pattern }
if ($i) { $params.CaseSensitive = $false }
if ($r) {
    if ($Path) { Get-ChildItem -Path $Path -Recurse | Select-String @params }
    else { Get-ChildItem -Recurse | Select-String @params }
} else {
    if ($Path) { Select-String -Path $Path @params }
    else { $Input | Select-String @params }
}
