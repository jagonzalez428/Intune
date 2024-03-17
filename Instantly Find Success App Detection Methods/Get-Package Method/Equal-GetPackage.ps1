<#
IMPORTANT DETAIL
Get-Package behaves differently based on the PowerShell Version. It's typically successful in the standard PowerShell installed on workstations,
but has altered behavior to search for installed modules in PowerShell Core, version 7.0 +
#>
try {
    IF ($PSVersionTable.PSEdition -ne "Core") {
        #You can replace these variables directly once you have the criteria from like-GetPackage.ps1
        $Name = "Google Chrome"
        $Version = "122.0.6261.129"
        
        $DetectedApp = Get-package | Where-Object { $_.Name -eq $Name -and $_.Version -ge $Version }
        if ($DetectedApp) {
            Write-Host "$($Name) is currently installed." -ForegroundColor Green
            Exit 0
        }
        else {
            Write-Host "$($Name) is currently not installed" -ForegroundColor Yellow
            Exit 1
        }

    }
    else {
        Write-host "Your PowerShell Edition is not currently supported" -ForegroundColor Red
        exit 1
    }
}
catch {
    $errMSG = $_.Message.Exception
    Write-Host $errMSG
    exit 1
}