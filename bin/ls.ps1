# ls.ps1
param([string[]]$Remaining)

if ($Remaining -contains "-h" -or $Remaining -contains "--help") {
    Write-Host "[WindowsBashCmds] ls (shim for dir)" -ForegroundColor Cyan
    Write-Host "Usage: ls [-l] [-a] [-la] [-al] [-w] [path]"
    Write-Host "This command is part of WindowsBashCmds."
    return
}

$flags = @()
$use_b = $true

# Very simple flag parsing to match ls.bat
$finalArgs = @()
foreach ($arg in $Remaining) {
    if ($arg -eq "-la" -or $arg -eq "-al") { $flags += "/A"; $use_b = $false }
    elseif ($arg -eq "-l") { $use_b = $false }
    elseif ($arg -eq "-a") { $flags += "/A" }
    elseif ($arg -eq "-w") { $flags += "/W" }
    elseif ($arg.StartsWith("-")) { # Ignore other flags }
    else { $finalArgs += $arg }
}

if ($use_b) {
    cmd /c dir /B $flags $finalArgs
} else {
    cmd /c dir $flags $finalArgs
}
