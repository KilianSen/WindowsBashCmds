# cat.ps1
param([string[]]$Args)
if ($Args -contains "-h" -or $Args -contains "--help") {
    Write-Host "[WindowsBashCmds] cat (shim for Get-Content)" -ForegroundColor Cyan
    Write-Host "Usage: cat [file]"
    Write-Host "This command is part of WindowsBashCmds."
    return
}
Get-Content @Args
