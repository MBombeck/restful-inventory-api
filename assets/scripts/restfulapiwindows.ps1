# Restful API Inventory Windows Powershell Script 
# Requirements: Powershell 7 
# Changes to Invoke-RestMethod in PowerShell 7
# New parameter for Invoke-RestMethod in PowerShell 7: StatusCodeVariable
# Tested on Windows 10 

# Config
$username = 'test'
$password = 'test'
$url = 'https://localhost:3000/v1/Inventory'

# Default parameter encoding
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# Pause 1-60 secs
start-sleep -Seconds (1..190 | get-random) 

# Check the output format
# Error Codes
# Output 002 = Wrong format from system
# Output 001 = Empty value from system

# Funtion to check if value is empty
function checkvalueisempty($checkvar){
if ([string]::IsNullOrWhiteSpace($checkvar) -eq $true ) {$checkvar = '001' }
return $checkvar }
# Function to check format 

function checkformatstring($chkformatstring){ 
if ($chkformatstring -match '^(\w){2,}')  
{ } else { $chkformatstring = '002' }
return $chkformatstring }
# Function to check format 
# Numbers format 0-9 - _ | minimum 1 character
# On wrong format = output "Wrong value from system"
function checkformatnumbers($chkformatnumbers){ 
if ($chkformatnumbers -match '^(\d){1,}')  
{ } else { $chkformatnumbers = '002' }
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
checkformatstring $os | Out-Null
$os = checkformatstring $os 
# OS Version
$version = (Get-CimInstance win32_operatingsystem).version
checkvalueisempty "$version" 
$version = checkvalueisempty $version
checkformatstring $version | Out-Null
$version = checkformatstring $version
# Uptime
$uptime = (Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime | Select-Object -Expand TotalMinutes -OutVariable TotalMinutes
$uptime = [math]::Round($uptime)
checkvalueisempty $uptime 
$uptime = checkvalueisempty $uptime
checkformatnumbers $uptime | Out-Null
$uptime = checkformatnumbers $uptime
# uuid   
$uuid= (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID
checkvalueisempty $uuid 
$uuid = checkvalueisempty $uuid
checkformatstring $uuid | Out-Null
$uuid = checkformatstring $uuid
# cpu name
$cpuname =(Get-CimInstance -Class Win32_Processor).Name
checkvalueisempty $cpuname 
$cpuname = checkvalueisempty $cpuname
checkformatstring $cpuname | Out-Null
$cpuname = checkformatstring $cpuname
# cpu load
$cpuload = (Get-CimInstance -Class Win32_Processor).LoadPercentage
checkvalueisempty $cpuload 
$cpuload = checkvalueisempty $cpuload
checkformatnumbers $cpuload | Out-Null
$cpuload = checkformatnumbers $cpuload
# ram total
$ram = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1kb)
Write-Host "$ram"
checkvalueisempty $ram 
$ram = checkvalueisempty $ram
checkformatnumbers $ram | Out-Null
$ram = checkformatnumbers $ram
# free ram
$freemem = [math]::Round((Get-ciminstance Win32_OperatingSystem).FreePhysicalMemory*1024/1kb,0)
checkvalueisempty $freemem 
$freemem = checkvalueisempty $freemem
checkformatnumbers $freemem | Out-Null
$freemem = checkformatnumbers $freemem
# logon server
$logonserver = (Get-ComputerInfo).LogonServer -replace '\\',''
checkvalueisempty $logonserver
$logonserver = checkvalueisempty $logonserver
checkformatstring $loginuser | Out-Null
$logonserver = checkformatstring $logonserver
# login user
$loginuser = (Get-ComputerInfo).CsUserName
checkvalueisempty $loginuser
$loginuser = checkvalueisempty $loginuser
checkformatstring $loginuser | Out-Null
$loginuser = checkformatstring $loginuser
# computer vendor
$vendor = (Get-CimInstance Win32_ComputerSystemProduct).Vendor
checkvalueisempty $vendor 
$vendor = checkvalueisempty $vendor
checkformatstring $vendor | Out-Null
$vendor = checkformatstring $vendor
# computer model
$hardwarename = (Get-CimInstance Win32_ComputerSystemProduct).Name
checkvalueisempty $hardwarename
$hardwarename = checkvalueisempty $hardwarename
checkformatstring $hardwarename  | Out-Null
$hardwarename = checkformatstring $hardwarename
# bios type
$biosfirmwaretype = (Get-ComputerInfo).BiosFirmwareType
checkvalueisempty $biosfirmwaretype
$biosfirmwawretype = checkvalueisempty $biosfirmwaretype
checkformatstring $biosfirmwaretype | Out-Null
$biosfirmwaretype = checkformatstring $biosfirmwaretype
# hdd name
$hdd = (Get-Disk).FriendlyName
checkvalueisempty $hdd
$hdd = checkvalueisempty $hdd
checkformatstring $hdd | Out-Null
$hdd = checkformatstring $hdd
# hdd size
$hddsize = [math]::Round((Get-Volume -DriveLetter C).Size /1kb)
checkvalueisempty $hddsize
$hddsize = checkvalueisempty $hddsize
checkformatnumbers $hddsize | Out-Null
$hddsize = checkformatnumbers $hddsize
# hdd free
$hddfree = [math]::Round((Get-Volume -DriveLetter C).SizeRemaining /1kb)
checkvalueisempty $hddfree
$hddfree = checkvalueisempty $hddfree
checkformatnumbers $hddfree | Out-Null
$hddfree = checkformatnumbers $hddfree
# IP New - IP from the outgoing card to 8.8.8.8
$ip =(Test-NetConnection 8.8.8.8 -informationLevel "Detailed").SourceAddress.IPAddress
checkvalueisempty $ip
$ip = checkvalueisempty $ip
checkipv4 $ip | Out-Null
$ip = checkipv4 $ip
# Get external IP - !Use this server on your own risk!
$externalip =(Invoke-WebRequest -UseBasicParsing -uri "http://ifconfig.me/ip").Content
checkvalueisempty $externalip
$externalip = checkvalueisempty $externalip
checkipv4 $externalip | Out-Null
$externalip = checkipv4 $externalip
# Gateway // NextHop
$gateway = (test-NetConnection 8.8.8.8 -informationLevel "Detailed").NetRoute.NextHop
checkvalueisempty $gateway 
$gateway = checkvalueisempty $gateway
checkipv4 $gateway | Out-Null
$gateway = checkipv4 $gateway
# DNS-Server 
$interfacealias =(Test-NetConnection 8.8.8.8 -informationLevel "Detailed").InterfaceAlias
$dnsserver=(Get-DnsClientServerAddress -InterfaceAlias "$interfacealias" -AddressFamily ipv4).ServerAddresses | Select -First 1
checkvalueisempty $dnsserver
$dnsserver = checkvalueisempty $dnsserver
checkipv4 $dnsserver | Out-Null
$dnsserver = checkipv4 $dnsserver

# Clear Poweshell Error
$error.clear()

# Format data for create and update in json format
$data_update = @{ uuid="$uuid";ip="$ip";os="$os";version="$version";uptime="$uptime";cpuname="$cpuname";cpuload="$cpuload";ram="$ram";freemem="$freemem";logonserver="$logonserver";loginuser="$loginuser";vendor="$vendor";hardwarename="$hardwarename";biosfirmwaretype="$biosfirmwaretype";hdd="$hdd";hddsize="$hddsize";hddfree="$hddfree";externalip="$externalip";gateway="$gateway";dnsserver="$dnsserver"}
$data_create = @{ hostname="$env:computername";uuid="$uuid";ip="$ip";os="$os";version="$version";uptime="$uptime";cpuname="$cpuname";cpuload="$cpuload";ram="$ram";freemem="$freemem";logonserver="$logonserver";loginuser="$loginuser";vendor="$vendor";hardwarename="$hardwarename";biosfirmwaretype="$biosfirmwaretype";hdd="$hdd";hddsize="$hddsize";hddfree="$hddfree";externalip="$externalip";gateway="$gateway";dnsserver="$dnsserver"}


# Update inventory
Invoke-Restmethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url/$env:computername -StatusCodeVariable ResponseFromServer -Method Put -Body $data_update -ContentType "application/x-www-form-urlencoded" | Select-Object -Expand message -OutVariable ResponseFromApi
if($ResponseFromApi -eq "Inventory item updated successfully") {
} else {
# Create inventory
Invoke-Restmethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url  -StatusCodeVariable ResponseFromServer -Method Post -Body $data_create -ContentType "application/x-www-form-urlencoded" | Select-Object -Expand message -OutVariable ResponseFromApi
}

# Write log
Write-Output "Restful API Inventory | Date: $(Get-Date)
Hostname:$env:computername | UUID:$uuid
API-Response: $ResponseFromApi 
Server-Response: $ResponseFromServer 
Error:$error


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
Biosfirmaretype         $biosfirmwaretype
HDD                     $hdd
HDDSize                 $hddsize
HDDFree                 $hddfree
Externalip              $externalip
Gateway                 $gateway
DNSServer               $dnsserver

">>logfile-$(Get-Date -Format "yyyy-MM-dd").txt
