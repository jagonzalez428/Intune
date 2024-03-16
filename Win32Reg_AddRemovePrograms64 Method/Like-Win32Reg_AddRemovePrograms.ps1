#You can replace it with your own variable directly
$SearchFor = $(Write-Host "Enter Search Criteria: " -ForegroundColor Cyan -NoNewline; Read-Host)
get-cimInstance -class Win32Reg_AddRemovePrograms64 | where-object { $_.Displayname -like "*$($SearchFor)*"}