$BinPath = Join-Path $PSScriptRoot "bin"
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($UserPath -split ";" -contains $BinPath) {
    Write-Host "Removing $BinPath from User Path..." -ForegroundColor Cyan
    $NewPath = ($UserPath -split ";" | Where-Object { $_ -ne $BinPath }) -join ";"
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    Write-Host "Done! Please restart your terminal for changes to take effect." -ForegroundColor Green
} else {
    Write-Host "$BinPath is not in your Path." -ForegroundColor Yellow
}
