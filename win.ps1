# Config
$username = 'test'
$password = 'test'
$url = 'http://localhost:3000/v1/inventory'

# Basic Auth
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
# IP
$SourceAddress = (Test-Connection -ComputerName $env:computername -count 1).IPV4Address.ipaddressTOstring
# OS 
$os = (Get-WmiObject win32_operatingsystem).caption
# OS Version
$version = (Get-WmiObject win32_operatingsystem).version
# Uptime
$uptime = (Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime | Select-Object -Expand TotalMinutes -OutVariable TotalMinutes
$uptime = [math]::Round($uptime)
# uuid   
$uuid= (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID

# Daten für Create und Update
$daten_update = @{ uuid="$uuid";ip="$SourceAddress";os="$os";version="$version";uptime="$uptime"}
$daten_create = @{ hostname="$env:computername";uuid="$uuid";ip="$SourceAddress";os="$os";version="$version";uptime="$uptime"}

# Update inventory
Invoke-Restmethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url/$env:computername -Method Put -Body $daten_update -ContentType "application/x-www-form-urlencoded" | Select-Object -Expand message -OutVariable message
if($message -eq "Pc updated successfully") {
} else {
# Create inventory
Invoke-Restmethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url -Method Post -Body $daten_create
}
