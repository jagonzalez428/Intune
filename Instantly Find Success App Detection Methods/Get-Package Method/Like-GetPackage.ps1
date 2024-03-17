<#
IMPORTANT DETAIL
Get-Package behaves differently based on the PowerShell Version. It's typically successful in the standard PowerShell installed on workstations,
but has altered behavior to search for installed modules in PowerShell Core, version 7.0 +
#>
IF ($PSVersionTable.PSEdition -ne "Core") {
    $SearchFor = $(Write-Host "Enter Search Criteria: " -ForegroundColor Cyan -NoNewline; Read-Host)
    Get-package *$SearchFor*
}
else {
    Write-host "Your PowerShell Edition is not currently supported" -ForegroundColor Red
}