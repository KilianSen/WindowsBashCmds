# touch.ps1
if ($args -contains "-h" -or $args -contains "--help") {
    Write-Host "[WindowsBashCmds] touch (create/update file)" -ForegroundColor Cyan
    Write-Host "Usage: touch filename1 [filename2 ...]"
    Write-Host "This command is part of WindowsBashCmds."
    return
}

foreach ($file in $args) {
    if (Test-Path $file) {
        (Get-Item $file).LastWriteTime = Get-Date
    } else {
        New-Item -Path $file -ItemType File | Out-Null
    }
}
