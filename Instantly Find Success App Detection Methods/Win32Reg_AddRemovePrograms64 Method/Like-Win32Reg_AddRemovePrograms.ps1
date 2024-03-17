#You can replace it with your own variable directly
$SearchFor = $(Write-Host "Enter Search Criteria: " -ForegroundColor Cyan -NoNewline; Read-Host)
Get-ChildItem "C:\Program Files\WindowsApps" -Filter "*$($SearchFor)*"