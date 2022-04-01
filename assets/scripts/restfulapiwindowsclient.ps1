# Restful API Inventory Windows Powershell Script 
# Requirements: Powershell 7 
# Changes to Invoke-RestMethod in PowerShell 7
# New parameter for Invoke-RestMethod in PowerShell 7: StatusCodeVariable

# Config
$username = 'test'
$password = 'test'
$url = 'http://localhost:3000/v1/inventory'
# Host to test the internet connection to API 
$hosttest = 'localhost'
# Scriptdirectory
$scriptdirectory = 'C:\Restful API Inventory'
# Day(s) to delete logfiles
[int] $days = "-7" 
# Default parameter encoding
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# Pause 1-60 secs
start-sleep -Seconds (1..60 | get-random) 

# Test connection to domain
$connection = Test-Connection -ComputerName $hosttest -Count 1 -Quiet
Test-Connection -ComputerName $hosttest -Count 1 -Quiet
If ($connection -eq $true) {
 $con= 'is available'
}
ElseIf ($connection -eq $false) {
 $con = 'is unavailable'
}

# Create folder if not exists
if (!(Test-Path -path $scriptdirectory)) {
    New-Item -ItemType directory -Path  "$scriptdirectory"
} 
# Funtion to check if value is empty
function checkvalueisempty($checkvar){
if ([string]::IsNullOrWhiteSpace($checkvar) -eq $true ) {$checkvar = 'Empty value from system' }
return $checkvar }
# Function to check format 
# String format a-zA-z0-9 - _ | minimum 3 characters
# On wrong format = output "Wrong value from system"
function checkformatstring($chkformatstring){ 
if ($chkformatstring -match '^(\w){2,}')  
{ } else { $chkformatstring = 'Wrong value from system' }
return $chkformatstring }
# Function to check format 
# Numbers format 0-9 - _ | minimum 1 character
# On wrong format = output "Wrong value from system"
function checkformatnumbers($chkformatnumbers){ 
if ($chkformatnumbers -match '^(\d){1,}')  
{ } else { $chkformatnumbers = 'Wrong value from system' }
return $chkformatnumbers }

# Funtion to check format 
# IPV4 format check
function checkipv4($checkipv4){ 
    if ($checkipv4 -match '^((?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$')  
    { } else { $checkipv4 = 'Wrong value from system' }
    return $checkipv4 }
    
# Basic Auth
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))

# Get system data
# OS 
$os = (Get-CimInstance win32_operatingsystem).caption 
checkvalueisempty $os
$os = checkvalueisempty $os
checkformatstring $os
$os = checkformatstring $os
# OS Version
$version = (Get-CimInstance win32_operatingsystem).version
checkvalueisempty "$version" 
$version = checkvalueisempty $version
checkformatstring $version
$version = checkformatstring $version
# Uptime
$uptime = (Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime | Select-Object -Expand TotalMinutes -OutVariable TotalMinutes
$uptime = [math]::Round($uptime)
checkvalueisempty $uptime 
$uptime = checkvalueisempty $uptime
checkformatnumbers $uptime
$uptime = checkformatnumbers $uptime
# uuid   
$uuid= (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID
checkvalueisempty $uuid 
$uuid = checkvalueisempty $uuid
checkformatstring $uuid
$uuid = checkformatstring $uuid
# cpu name
$cpuname =(Get-CimInstance -Class Win32_Processor).Name
checkvalueisempty $cpuname 
$cpuname = checkvalueisempty $cpuname
checkformatstring $cpuname
$cpuname = checkformatstring $cpuname
# cpu load
$cpuload = (Get-CimInstance -Class Win32_Processor).LoadPercentage
checkvalueisempty $cpuload 
$cpuload = checkvalueisempty $cpuload
checkformatnumbers $cpuload
$cpuload = checkformatnumbers $cpuload
# ram total
$ram = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb)
Write-Host "$ram"
checkvalueisempty $ram 
$ram = checkvalueisempty $ram
checkformatnumbers $ram
$ram = checkformatnumbers $ram
# free ram
$freemem = [math]::Round((Get-ciminstance Win32_OperatingSystem).FreePhysicalMemory*1024/1gb,0)
checkvalueisempty $freemem 
$freemem = checkvalueisempty $freemem
checkformatnumbers $freemem
$freemem = checkformatnumbers $freemem
# logon server
$logonserver = (Get-ComputerInfo).LogonServer -replace '\\',''
checkvalueisempty $logonserver 
$logonserver = checkvalueisempty $logonserver
checkformatstring $logonserver
$logonserver = checkformatstring $logonserver
# logon user
$loginuser = (Get-ComputerInfo).CsUserName
checkvalueisempty $loginuser
$loginuser = checkvalueisempty $loginuser
checkformatstring $loginuser
$loginuser = checkformatstring $loginuser
# computer vendor
$vendor = (Get-CimInstance Win32_ComputerSystemProduct).Vendor
checkvalueisempty $vendor 
$vendor = checkvalueisempty $vendor
checkformatstring $vendor
$vendor = checkformatstring $vendor
# computer model
$hardwarename = (Get-CimInstance Win32_ComputerSystemProduct).Name
checkvalueisempty $hardwarename
$hardwarename = checkvalueisempty $hardwarename
checkformatstring $hardwarename
$hardwarename = checkformatstring $hardwarename
# bios type
$biosfirmaretype = (Get-ComputerInfo).BiosFirmwareType
checkvalueisempty $biosfirmaretype
$biosfirmaretype = checkvalueisempty $biosfirmaretype
checkformatstring $biosfirmaretype
$biosfirmaretype = checkformatstring $biosfirmaretype
# hdd name
$hdd = (Get-Disk).FriendlyName
checkvalueisempty $hdd
$hdd = checkvalueisempty $hdd
checkformatstring $hdd
$hdd = checkformatstring $hdd
# hdd size
$hddsize = [math]::Round((Get-Volume -DriveLetter C).Size /1gb)
checkvalueisempty $hddsize
$hddsize = checkvalueisempty $hddsize
checkformatnumbers $hddsize
$hddsize = checkformatnumbers $hddsize
# hdd free
$hddfree = [math]::Round((Get-Volume -DriveLetter C).SizeRemaining /1gb)
checkvalueisempty $hddfree
$hddfree = checkvalueisempty $hddfree
checkformatnumbers $hddfree
$hddfree = checkformatnumbers $hddfree
# IP New - IP from the outgoing card to 8.8.8.8
$ip =(Test-NetConnection 8.8.8.8 -informationLevel "Detailed").SourceAddress.IPAddress
checkvalueisempty $ip
$ip = checkvalueisempty $ip
checkipv4 $ip
$ip = checkipv4 $ip
# Get external IP - !Use this server on your own risk!
$externalip =(Invoke-WebRequest -UseBasicParsing -uri "http://ifconfig.me/ip").Content
checkvalueisempty $externalip
$externalip = checkvalueisempty $externalip
checkipv4 $externalip
$externalip = checkipv4 $externalip
# Gateway // NextHop
$gateway = (test-NetConnection 8.8.8.8 -informationLevel "Detailed").NetRoute.NextHop
checkvalueisempty $gateway
$gateway = checkvalueisempty $gateway
checkipv4 $gateway
$gateway = checkipv4 $gateway
# DNS-Server 
$interfacealias =(Test-NetConnection 8.8.8.8 -informationLevel "Detailed").InterfaceAlias
$dnsserver=(Get-DnsClientServerAddress -InterfaceAlias "$interfacealias" -AddressFamily ipv4).ServerAddresses | Select -First 1
checkvalueisempty $dnsserver
$dnsserver = checkvalueisempty $dnsserver
checkipv4 $dnsserver
$dnsserver = checkipv4 $dnsserver
# Format data for create and update in json format
$data_update = @{ uuid="$uuid";ip="$ip";os="$os";version="$version";uptime="$uptime";cpuname="$cpuname";cpuload="$cpuload";ram="$ram";freemem="$freemem";logonserver="$logonserver";loginuser="$loginuser";vendor="$vendor";hardwarename="$hardwarename";biosfirmaretype="$biosfirmaretype";hdd="$hdd";hddsize="$hddsize";hddfree="$hddfree";externalip="$externalip";gateway="$gateway";dnsserver="$dnsserver"}
$data_create = @{ hostname="$env:computername";uuid="$uuid";ip="$ip";os="$os";version="$version";uptime="$uptime";cpuname="$cpuname";cpuload="$cpuload";ram="$ram";freemem="$freemem";logonserver="$logonserver";loginuser="$loginuser";vendor="$vendor";hardwarename="$hardwarename";biosfirmaretype="$biosfirmaretype";hdd="$hdd";hddsize="$hddsize";hddfree="$hddfree";externalip="$externalip";gateway="$gateway";dnsserver="$dnsserver"}
# Update inventory
Invoke-Restmethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url/$env:computername -StatusCodeVariable ResponseFromServer -Method Put -Body $data_update -ContentType "application/x-www-form-urlencoded" | Select-Object -Expand message -OutVariable ResponseFromApi
if($ResponseFromApi -eq "Inventory item updated successfully") {
} else {
# Create inventory
Invoke-Restmethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url -StatusCodeVariable ResponseFromServer -Method Post -Body $data_create -ContentType "application/x-www-form-urlencoded" | Select-Object -Expand message -OutVariable ResponseFromApi
}

# Check log path
$logpath = "$scriptdirectory\Logs"
If(!(test-path $logpath))
{
      New-Item -ItemType Directory -Force -Path $logpath
}

# Write log
Write-Output "Restful API Inventory | Date: $(Get-Date)
Host $hosttest $con
Hostname:$env:computername | UUID:$uuid
API-Response: $ResponseFromApi 
Server-Response: $ResponseFromServer 

Collected Data:
Hostname                $env:computername
UUID                    $uuid
IP                      $ip
OS                      $os
Version                 $version
Uptime                  $uptime
CPUName                 $cpuname
CPULoad                 $cpuload
RAM                     $ram
Freemem                 $freemem
Logonserver             $logonserver
Loginuser               $loginuser
Vendor                  $vendor
Hardwarename            $hardwarename
Biosfirmaretype         $biosfirmaretype
HDD                     $hdd
HDDSize                 $hddsize
HDDFree                 $hddfree
Externalip              $externalip
Gateway                 $gateway
DNSServer               $dnsserver

">> $scriptdirectory\logs\logfile-$(Get-Date -Format "yyyy-MM-dd").txt

# Delete logs older than $days
$logFiles = "*.txt"
Get-ChildItem $scriptdirectory -Include $logFiles -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays($days)} | Remove-Item

# Create windows task with "system" user | at 8am, repeat every 12 hours for unlimited time | Mode: silent
$Action = New-ScheduledTaskAction -Execute 'C:\Program Files\PowerShell\7\pwsh.exe' -Argument "-NonInteractive -NoLogo -NoProfile -File $scriptdirectory\restfulapiwindowsclient.ps1"
$Trigger = New-ScheduledTaskTrigger -once -At 8:00am -RepetitionInterval (New-TimeSpan -Hours 12)
$Settings = New-ScheduledTaskSettingsSet
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
Register-ScheduledTask -TaskName 'Restful API' -InputObject $Task -user "System"
