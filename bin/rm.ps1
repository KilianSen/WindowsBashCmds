# rm.ps1
param([string[]]$Args)

if ($Args -contains "-h" -or $Args -contains "--help") {
    Write-Host "[WindowsBashCmds] rm (shim for Remove-Item)" -ForegroundColor Cyan
    Write-Host "Usage: rm [-rf] target"
    Write-Host "This command is part of WindowsBashCmds."
    return
}

foreach ($arg in $Args) {
    if ($arg -eq "-rf") { $recursive = $true; $force = $true }
    elseif ($arg -eq "-f") { $force = $true }
    elseif ($arg -eq "-r") { $recursive = $true }
    else { $targets += $arg }
}

if (-not $targets) {
    Write-Error "Usage: rm [-rf] target"
    return
}

foreach ($target in $targets) {
    if (Test-Path $target) {
        if ((Get-Item $target) -is [System.IO.DirectoryInfo]) {
            if ($recursive) {
                Remove-Item $target -Recurse -Force
            } else {
                Write-Error "rm: $target: is a directory"
            }
        } else {
            Remove-Item $target -Force
        }
    } elseif (-not $force) {
        Write-Error "rm: $target: No such file or directory"
    }
}
