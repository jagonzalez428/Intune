try {
    $WingetID = "Google.Chrome"
    $WingetVersion = "122.0.6261.129"
    
    $WinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
    $WinGetPathExe = $WinGetResolve[-1].Path
    $WinGetPath = Split-Path -Path $WinGetPathExe -Parent
    Push-Location $WinGetPath
    $WingetInfo = .\winget.exe list -e --id $WingetID --source winget
    Pop-Location
    $WinVer = (-split $WingetInfo[-1])[-1]
    $WinApp = (-split $WingetInfo[-1])[-2]
    if (($WingetID -eq $WinApp) -and ($WingetVersion -eq $WinVer)) {
        Write-Host "$($WingetID) is currently installed." -ForegroundColor Green
        Exit 0
    }
    else {
        Write-Host "$($WingetID) is currently not installed" -ForegroundColor Yellow
        Exit 1
    }
}
catch {
    $errMSG = $_.Message.Exception
    Write-Host $errMSG
    exit 1
}