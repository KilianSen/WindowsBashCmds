# bootstrap.ps1 - Remote installer for WindowsBashCmds
$RepoUrl = "https://github.com/KilianSen/WindowsBashCmds/archive/refs/heads/master.zip"
$InstallDir = Join-Path $HOME ".windows-bash-cmds"

Write-Host "[WindowsBashCmds] Preparing remote installation..." -ForegroundColor Cyan

if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir | Out-Null
}

$ZipFile = Join-Path $InstallDir "repo.zip"

Write-Host "Downloading repository..." -ForegroundColor Gray
Invoke-WebRequest -Uri $RepoUrl -OutFile $ZipFile

Write-Host "Extracting files..." -ForegroundColor Gray
Expand-Archive -Path $ZipFile -DestinationPath $InstallDir -Force

# Move files out of the nested folder created by GitHub ZIP
$ExtractedFolder = Get-ChildItem -Path $InstallDir -Directory | Where-Object { $_.Name -like "WindowsBashCmds*" } | Select-Object -First 1
if ($ExtractedFolder) {
    Get-ChildItem -Path $ExtractedFolder.FullName | Move-Item -Destination $InstallDir -Force
    Remove-Item $ExtractedFolder.FullName -Recurse -Force
}

Remove-Item $ZipFile -Force

Write-Host "Running local installer..." -ForegroundColor Gray
Set-Location -Path $InstallDir
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\install.ps1"

Write-Host "[WindowsBashCmds] Remote installation complete!" -ForegroundColor Green
