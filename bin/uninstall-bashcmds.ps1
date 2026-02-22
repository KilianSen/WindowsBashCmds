# bin/uninstall-bashcmds.ps1
$BinPath = $PSScriptRoot
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($UserPath -split ";" -contains $BinPath) {
    Write-Host "Removing $BinPath from User Path..." -ForegroundColor Cyan
    $NewPath = ($UserPath -split ";" | Where-Object { $_ -ne $BinPath }) -join ";"
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
}

# Remove from Profile
if (Test-Path $PROFILE) {
    $content = Get-Content $PROFILE
    if ($content -match "WindowsBashCmds") {
        Write-Host "Removing WindowsBashCmds logic from your PowerShell `$PROFILE..." -ForegroundColor Cyan
        $newContent = $content | Where-Object { $_ -notmatch "WindowsBashCmds" -and $_ -notmatch "conflicts =" -and $_ -notmatch "Get-Alias" -and $_ -notmatch "Remove-Item "Alias:" }
        $newContent | Set-Content $PROFILE
    }
}

Write-Host "Uninstallation complete. Please restart your terminal." -ForegroundColor Green
