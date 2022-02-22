# Config
$username = 'test'
$password = 'test'
$url = 'http://localhost:3000/v1/inventory'

# Basic Auth
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
# SourceAdress replaced with $IP on line 71
#$SourceAddress = (Test-Connection -ComputerName $env:computername -count 1).IPV4Address.ipaddressTOstring
# OS 
$os = (Get-WmiObject win32_operatingsystem).caption
# OS Version
$version = (Get-WmiObject win32_operatingsystem).version
# Uptime
$uptime = (Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime | Select-Object -Expand TotalMinutes -OutVariable TotalMinutes
$uptime = [math]::Round($uptime)
# uuid   
$uuid= (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID
# cpu name
$cpuname =(Get-CimInstance -Class Win32_Processor).Name
# cpu load
$cpuload = (Get-CimInstance -Class Win32_Processor).LoadPercentage
# ram total
$ram = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb
# free ram
$freemem = [math]::Round((Get-ciminstance Win32_OperatingSystem).FreePhysicalMemory*1024/1gb,2)
# logon server
$logonserver = (Get-ComputerInfo).LogonServer -replace '\\',''
# logon user
$loginuser = (Get-ComputerInfo).CsUserName
# computer vendor
$vendor = (Get-CimInstance Win32_ComputerSystemProduct).Vendor
# computer model
$hardwarename = (Get-CimInstance Win32_ComputerSystemProduct).Name
# bios type
$biosfirmaretype = (Get-ComputerInfo).BiosFirmwareType
# hdd name
$hdd = (Get-Disk).FriendlyName
# hdd size
$hddsize = [math]::Round((Get-Volume -DriveLetter C).Size /1gb)
# hdd free
$hddfree = [math]::Round((Get-Volume -DriveLetter C).SizeRemaining /1gb)
# IP New - IP from the outgoing card to 8.8.8.8
$ip =(Test-NetConnection 8.8.8.8 -informationLevel "Detailed").SourceAddress.IPAddress

# Get external IP - !!!! Use your own script and your own server here!!! -
$externalip =(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

# Gateway // NextHop
$gateway = (test-NetConnection 8.8.8.8 -informationLevel "Detailed").NetRoute.NextHop

# DNS-Server 
$interfacealias =(Test-NetConnection 8.8.8.8 -informationLevel "Detailed").InterfaceAlias
$dnsserver=(Get-DnsClientServerAddress -InterfaceAlias "$interfacealias" -AddressFamily ipv4).ServerAddresses

# Data for Create and Update
$daten_update = @{ uuid="$uuid";ip="$ip";os="$os";version="$version";uptime="$uptime";cpuname="$cpuname";cpuload="$cpuload";ram="$ram";freemem="$freemem";logonserver="$logonserver";loginuser="$loginuser";vendor="$vendor";hardwarename="$hardwarename";biosfirmaretype="$biosfirmaretype";hdd="$hdd";hddsize="$hddsize";hddfree="$hddfree";externalip="$externalip";gateway="$gateway";dns-server="$dnsserver"}
$daten_create = @{ hostname="$env:computername";uuid="$uuid";ip="$ip";os="$os";version="$version";uptime="$uptime";cpuname="$cpuname";cpuload="$cpuload";ram="$ram";freemem="$freemem";logonserver="$logonserver";loginuser="$loginuser";vendor="$vendor";hardwarename="$hardwarename";biosfirmaretype="$biosfirmaretype";hdd="$hdd";hddsize="$hddsize";hddfree="$hddfree";externalip="$externalip";gateway="$gateway";dns-server="$dnsserver"}
# Update inventory
Invoke-Restmethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url/$env:computername -Method Put -Body $daten_update -ContentType "application/x-www-form-urlencoded" | Select-Object -Expand message -OutVariable message
if($message -eq "Inventory item updated successfully") {
} else {
# Create inventory
Invoke-Restmethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url -Method Post -Body $daten_create
}
