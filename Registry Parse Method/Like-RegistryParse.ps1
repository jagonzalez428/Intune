$SearchFor = $(Write-Host "Enter Search Criteria: " -ForegroundColor Cyan -NoNewline; Read-Host)
# Get 64 bits programs
$64bit = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*$($SearchFor)*" }
# Add 32 bits programs
$32bit = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*$($SearchFor)*" }

if($64bit){
    Write-host "64Bit Results" -ForegroundColor Magenta
    $64bit
}
if($32bit){
    Write-host "32Bit Results" -ForegroundColor Magenta
    $32bit
}
