try {
    #You can replace these variables directly once you have the criteria from Like-RegistryParse.ps1
    $DisplayName = "Java 8 Update 401 (64-bit)"
    $DisplayVersion = "8.0.4010.10"

    [array]$ProductCheck = @()
    # Get 64 bits programs
    $ProductCheck = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -eq $DisplayName -and $_.DisplayVersion -ge $DisplayVersion }
    # Add 32 bits programs
    $ProductCheck += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -eq $DisplayName -and $_.DisplayVersion -ge $DisplayVersion }
    
    if ($ProductCheck) {
        Write-Host "$($DisplayName) is currently installed." -ForegroundColor Green
        Exit 0
    }
    else {
        Write-Host "$($DisplayName) is currently not installed" -ForegroundColor Yellow
        Exit 1
    }
}
catch {
    $errMSG = $_.Message.Exception
    Write-Host $errMSG
    exit 1
}