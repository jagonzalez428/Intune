#Example 1 = "Chrome"
#Example 2 = "MSTeams"
#Example 3 = "AppInstaller"

$SearchFor = $(Write-Host "Enter Search Criteria: " -ForegroundColor Cyan -NoNewline; Read-Host)
################################ Win32Reg_AddRemovePrograms64 Method

if (get-cimInstance -class Win32Reg_AddRemovePrograms64 | where-object { $_.Displayname -like "*$($SearchFor)*" })
{ Write-host "Win32Reg_AddRemovePrograms64 Class Successful" -ForegroundColor Green }
else { Write-host "Win32Reg_AddRemovePrograms64 Class Failed" -ForegroundColor Red }

################################ Win32Reg_AddRemovePrograms Method

if (get-cimInstance -class Win32Reg_AddRemovePrograms | where-object { $_.Displayname -like "*$($SearchFor)*" })
{ Write-host "Win32Reg_AddRemovePrograms Class Successful" -ForegroundColor Green }
else { Write-host "Win32Reg_AddRemovePrograms Class Failed" -ForegroundColor Red }

################################ Registry Parse Method

[array]$ProductCheck = @()
# Get 64 bits programs
$ProductCheck = Get-ItemProperty `
    HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | 
Where-Object { $_.DisplayName -like "*$($SearchFor)*" }
# Add 32 bits programs
$ProductCheck += Get-ItemProperty `
    HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | 
Where-Object { $_.DisplayName -like "*$($SearchFor)*" }
if ($ProductCheck)
{ Write-host "Registry Parse Successful" -ForegroundColor Green }
else { Write-host "Registry Parse Failed" -ForegroundColor Red }

################################ Get-Package Method

if ($PSVersionTable.PSEdition -ne "Core") {
    if (Get-package *$SearchFor* -ErrorAction SilentlyContinue)
    { Write-host "Get-Package Successful" -ForegroundColor Green }
    else { Write-host "Get-Package Failed" -ForegroundColor Red }
}

################################ Windows Apps Method

if (Get-ChildItem "C:\Program Files\WindowsApps" -Filter "*$($SearchFor)*")
{ Write-host "WindowsApps Location Successful" -ForegroundColor Green }
else { Write-host "WindowsApps Location Failed" -ForegroundColor Red }

################################ Winget Method 

$WinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
$WinGetPathExe = $WinGetResolve[-1].Path
$WinGetPath = Split-Path -Path $WinGetPathExe -Parent
Push-Location $WinGetPath
$WingetList = .\winget.exe list $SearchFor --source winget
Pop-Location
$DetectedID = ( -split ($wingetlist[-1])) | select-string "$($SearchFor)*"
if ($DetectedID) {
    Write-host "Winget Detection Successful" -ForegroundColor Green 
    $WingetVer = (-split $wingetlist[-1])[-1]
    $WingetID = (-split $wingetlist[-1])[-2]
}
else { Write-host "Winget Detection Failed" -ForegroundColor Red }

################################ Get-AppX Method
$AppX = Get-AppxPackage | Where-Object name -Like "*$($SearchFor)*"
if ($AppX) { Write-host "AppX Detection Successful" -ForegroundColor Green }
else { Write-host "AppX Detection Failed" -ForegroundColor Red }

################################ Results

if ($ProductCheck.DisplayName) {
    Write-host $ProductCheck.DisplayName -ForegroundColor Magenta
    write-host $ProductCheck.DisplayVersion -ForegroundColor Magenta
}
if ($DetectedID) {
    Write-host "Winget ID: $WingetID" -ForegroundColor Magenta
    Write-host "Winget Version: $Wingetver" -ForegroundColor Magenta
}
if ($AppX) {
    Write-host "AppX Name: $($AppX.Name)" -ForegroundColor Magenta
    Write-host "Appx Version: $($AppX.Version)" -ForegroundColor Magenta
}

