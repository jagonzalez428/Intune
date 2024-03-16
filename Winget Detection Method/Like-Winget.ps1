#You can replace it with your own variable directly
$SearchFor = $(Write-Host "Enter Search Criteria: " -ForegroundColor Cyan -NoNewline; Read-Host)
$WinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
$WinGetPathExe = $WinGetResolve[-1].Path
$WinGetPath = Split-Path -Path $WinGetPathExe -Parent
Push-Location $WinGetPath
.\winget.exe list $SearchFor --source winget
Pop-Location