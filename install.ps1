param([switch]$h, [switch]$help)

if ($h -or $help) {
    Write-Host "[WindowsBashCmds] Installer" -ForegroundColor Cyan
    Write-Host "Usage: .\install.ps1"
    Write-Host "This script adds the 'bin' directory to your User PATH and configures your PowerShell Profile to avoid alias conflicts."
    return
}

$BinPath = Join-Path $PSScriptRoot "bin"
if (-not (Test-Path $BinPath)) {
    Write-Error "Could not find 'bin' directory. Please run this script from the repository root."
    return
}

Write-Host "[WindowsBashCmds] Starting installation..." -ForegroundColor Cyan

$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -split ";" -notcontains $BinPath) {
    Write-Host "Adding $BinPath to User Path..." -ForegroundColor Gray
    [Environment]::SetEnvironmentVariable("Path", "$UserPath;$BinPath", "User")
} else {
    Write-Host "$BinPath is already in your Path." -ForegroundColor Yellow
}

# Conflicts with PS built-in aliases
$conflicts = @("ls", "cp", "mv", "rm", "cat", "pwd", "clear", "kill", "ps", "diff", "man")

Write-Host "Configuring PowerShell profile..." -ForegroundColor Gray
foreach ($cmd in $conflicts) {
    if (Get-Alias $cmd -ErrorAction SilentlyContinue) {
        Remove-Item "Alias:$cmd" -ErrorAction SilentlyContinue
    }
}

$ProfileUpdate = @"

# WindowsBashCmds - Remove conflicting aliases to use shims
`$conflicts = @("ls", "cp", "mv", "rm", "cat", "pwd", "clear", "kill", "ps", "diff", "man")
foreach (`$cmd in `$conflicts) {
    if (Get-Alias `$cmd -ErrorAction SilentlyContinue) {
        Remove-Item "Alias:`$cmd" -ErrorAction SilentlyContinue
    }
}
"@

if ($PSVersionTable.PSVersion.Major -ge 5) {
    $ProfileDir = Split-Path $PROFILE -Parent
    if (-not (Test-Path $ProfileDir)) {
        New-Item -Path $ProfileDir -Type Directory -Force | Out-Null
    }
    
    if (-not (Test-Path $PROFILE)) {
        New-Item -Path $PROFILE -Type File -Force | Out-Null
    }
    
    if ((Get-Content $PROFILE) -notmatch "WindowsBashCmds") {
        Add-Content -Path $PROFILE -Value $ProfileUpdate
    }
}

Write-Host "Done! Please restart your terminal." -ForegroundColor Green
Write-Host "You can now use 'uninstall-bashcmds' to remove these changes at any time." -ForegroundColor Gray
