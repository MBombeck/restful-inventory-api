$API  = "http://localhost:3000/v1/inventory"
$AUTH = "test:test"

# Creds
$username,$password = $AUTH.Split(":")
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)

# Minimaler, aber vollständiger Body (alles als String senden, das mag die meisten APIs)
$body = @{
  hostname          = "PC-BO-001"
  uuid              = "a3f3c6f0-5b1e-4b2e-9d3d-1a2b3c4d5e6f"
  ip                = "10.10.10.101"
  os                = "Windows 11"
  version           = "23H2"
  uptime            = "3600"
  cpuname           = "Intel Core i7-10700"

  # geforderte Pflichtfelder
  cpuload           = "5"                       # in %
  ram               = "16384"                   # MB Gesamt
  freemem           = "10240"                   # MB frei
  logonserver       = "\\\\MUSTER-DC01"            # oder "LOCAL"
  loginuser         = "muster\\muster"
  vendor            = "Dell Inc."
  hardwarename      = "OptiPlex 7080"
  biosfirmwaretype  = "UEFI"

  hdd               = "NVMe Samsung 970 EVO"
  hddsize           = "1024000"                 # MB (1 TB)
  hddfree           = "512000"                  # MB frei

  externalip        = "93.184.216.34"
  gateway           = "10.10.10.1"
  dnsserver         = "10.10.10.10,10.10.10.11" # kommasepariert als String
} | ConvertTo-Json

Invoke-RestMethod -Uri $API -Method POST -Credential $cred -ContentType "application/json" -Body $body
