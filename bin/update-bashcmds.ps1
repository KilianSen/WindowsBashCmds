# bin/update-bashcmds.ps1
param([switch]$h, [switch]$help)

if ($h -or $help) {
    Write-Host "[WindowsBashCmds] update-bashcmds" -ForegroundColor Cyan
    Write-Host "Usage: update-bashcmds"
    Write-Host "This command pulls the latest versions of all shims from the GitHub repository."
    return
}

$InstallDir = Resolve-Path (Join-Path $PSScriptRoot "..")
Write-Host "[WindowsBashCmds] Checking for updates in $InstallDir..." -ForegroundColor Cyan

if (Test-Path (Join-Path $InstallDir ".git")) {
    Write-Host "Git repository detected. Running 'git pull'..." -ForegroundColor Gray
    Set-Location $InstallDir
    git pull
} else {
    Write-Host "Remote installation detected. Fetching latest ZIP..." -ForegroundColor Gray
    $RepoUrl = "https://github.com/KilianSen/WindowsBashCmds/archive/refs/heads/main.zip"
    $ZipFile = Join-Path $InstallDir "update.zip"
    
    Invoke-WebRequest -Uri $RepoUrl -OutFile $ZipFile
    
    Write-Host "Extracting updates..." -ForegroundColor Gray
    $TempDir = Join-Path $InstallDir "temp_update"
    Expand-Archive -Path $ZipFile -DestinationPath $TempDir -Force
    
    $ExtractedFolder = Get-ChildItem -Path $TempDir -Directory | Select-Object -First 1
    if ($ExtractedFolder) {
        Copy-Item -Path (Join-Path $ExtractedFolder.FullName "*") -Destination $InstallDir -Recurse -Force
    }
    
    Remove-Item $TempDir -Recurse -Force
    Remove-Item $ZipFile -Force
}

Write-Host "Refreshing installation..." -ForegroundColor Gray
Set-Location $InstallDir
& ".\install.ps1"

Write-Host "[WindowsBashCmds] Update complete!" -ForegroundColor Green
