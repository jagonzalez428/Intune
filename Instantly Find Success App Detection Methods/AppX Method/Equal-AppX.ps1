try {
    $Name = "MSTeams"
    $Version = "24033.811.2738.2546"
    
    $DetectedApp = Get-AppxPackage | Where-Object {$_.Name -eq $Name -and $_.Version -ge $Version}
    if ($DetectedApp) {
        Write-Host "$($Name) is currently installed." -ForegroundColor Green
        Exit 0
    }
    else {
        Write-Host "$($Name) is currently not installed" -ForegroundColor Yellow
        Exit 1
    }
}
catch {
    $errMSG = $_.Message.Exception
    Write-Host $errMSG
    exit 1
}