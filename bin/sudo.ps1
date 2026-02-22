# sudo.ps1
param([string[]]$Command)

if ($Command -contains "-h" -or $Command -contains "--help") {
    Write-Host "[WindowsBashCmds] sudo (elevate shell)" -ForegroundColor Cyan
    Write-Host "Usage: sudo [command]"
    Write-Host "This command is part of WindowsBashCmds."
    return
}

$shell = (Get-Process -Id $PID).Name
if ($Command) {
    $cmdString = $Command -join " "
    Start-Process $shell -Verb RunAs -ArgumentList "-NoExit", "-Command", "$cmdString"
} else {
    Start-Process $shell -Verb RunAs
}
