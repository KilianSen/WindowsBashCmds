$BinPath = Join-Path $PSScriptRoot "bin"
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($UserPath -split ";" -contains $BinPath) {
    Write-Host "Removing $BinPath from User Path..." -ForegroundColor Cyan
    $NewPath = ($UserPath -split ";" | Where-Object { $_ -ne $BinPath }) -join ";"
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
} else {
    Write-Host "$BinPath is not in your Path." -ForegroundColor Yellow
}

if (Test-Path $PROFILE) {
    Write-Host "Removing WindowsBashCmds configuration from profile..." -ForegroundColor Cyan
    $lines = Get-Content $PROFILE
    $newLines = @()
    $skip = $false
    foreach ($line in $lines) {
        if ($line -like "*WindowsBashCmds BEGIN*") { $skip = $true; continue }
        if ($line -like "*WindowsBashCmds END*") { $skip = $false; continue }
        if (-not $skip -and $line -notmatch "WindowsBashCmds") {
            $newLines += $line
        }
    }
    $newLines | Set-Content $PROFILE
}

Write-Host "Done! Please restart your terminal for changes to take effect." -ForegroundColor Green
