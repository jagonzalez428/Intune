try {
    #You can replace these variables directly once you have the criteria from Like-WinReg_AddRemovePrograms.ps1
    $DisplayName = "Google Chrome"
    $Version = "122.0.6261.129"
    
    $Detection = get-cimInstance -class Win32Reg_AddRemovePrograms | where-object { $_.Displayname -eq $DisplayName -and $_.Version -ge $Version }
    if ($Detection) {
        Write-Host "Application $DisplayName is currently installed." -ForegroundColor Green
        exit 0
    }
    else {
        Write-Host "Application $DisplayName is currently not installed." -ForegroundColor Green
        exit 1
    }
}
catch {
    $errMSG = $_.Message.Exception
    Write-Host $errMSG
    exit 1
}