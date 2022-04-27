#!/bin/bash

# Restful API Inventory Linux Bash Script
# Requirements: CURL
# Tested on Ubuntu 20.04.4 LTS (Focal Fossa)

# Config
username='test'
password='test'
url='https://localhost:3000/v1/inventory'

# Sleep
sleep $[ ( $RANDOM % 190 )  + 1 ]s

# Get data
hostname=$(hostname | tr [:lower:] [:upper:])
ip=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
uuid=$(cat /etc/machine-id | tr [:lower:] [:upper:] | sed 's/\(........\)\(....\)\(....\)\(....\)/\1-\2-\3-\4-/')
os=$(cat /etc/*-release | grep -w "NAME" | sed 's/NAME=//g' | sed 's/"//g')
version=$(cat /etc/*-release | grep -w "VERSION" | sed 's/VERSION=//g' | sed 's/"//g')
uptime=$(echo $(awk '{print $1}' /proc/uptime) / 60 | bc)
cpuname=$(cat /proc/cpuinfo | grep 'model name' | sed -e 's/.*://' | awk 'NR==1')
cpuname="${cpuname/ /}"
cpuload=$(cat /proc/loadavg | awk '{print $1}' | awk '{print int($1)}')
ram=$(free | grep -E '(Mem|Speicher)' | awk '{print $2}')
freemem=$(free | grep -E '(Mem|Speicher)' | awk '{print $3}')
logonserver="Not used"
loginuser=$(whoami)
vendor=$(cat /sys/devices/virtual/dmi/id/sys_vendor)
hardwarename=$(cat /sys/devices/virtual/dmi/id/product_name)
hdd=$(lsblk -o Model,Name -d | grep sda | awk '{print $1}')
hddsize=$(df -hk / | awk '{print $2}' | sed s'/G//' | awk NR==2)
#hddsize=`lsblk -o Model,Name,Size -d | grep sda | awk '{print $3}'| sed 's/.$//'`
hddfree=$(df -hk / | awk '{print $4}' | sed s'/G//' | awk NR==2)
gateway=$(ip route show default | awk '/default/ {print $3}')
dnsserver=$(resolvectl status | grep "Current DNS Server" | awk '{print $4}')
externalip=$(curl -s https://ifconfig.me)
# Check Firmwaretype Uefi or "Bios"
DIR="/sys/firmware/efi/"
if [ -d "$DIR" ]; then
    biosfirmwaretype="Uefi"
else
    biosfirmwaretype="Bios"
fi

# Check the output format
# Error Codes
# Output 002 = Wrong format from system
# Output 001 = Empty value from system

check_nl="[[:alnum:]]"
check_g="[[:graph:]]"
wvf="002"
wvf_n="002"
emt="001"
checkformat_ip() {
    if [[ "$1" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then return 0; else return 1; fi
}

checkformat_ip $dnsserver
chk_status=$?
if [[ -z "$dnsserver" ]]; then dnsserver="$emt"; elif [ "$chk_status" -eq 1 ]; then dnsserver="$wvf"; fi


checkformat_ip $gateway
if [[ -z "$gateway" ]]; then gaterway="$emt"; elif [ "$chk_status" -eq 1 ]; then gateway="$wvf"; fi
checkformat_ip $ip
if [[ -z "$ip" ]]; then ip="$emt"; elif [ "$chk_status" -eq 1 ]; then ip="$wvf"; fi
checkformat_ip $externalip
if [[ -z "$externalip" ]]; then externalip="$emt"; elif [ "$chk_status" -eq 1 ]; then externalip="$wvf"; fi

checkformat_l_n() {
    if [[ "$1" =~ ^[0-9A-Za-z,\@,\_,\(,\),\.]{2,50}$ ]]; then return 0; else return 1; fi
}

checkformat_ip $hostname
if [[ -z "$hostname" ]]; then hostname="$emt"; elif [ "$chk_status" -eq 1 ]; then hostname="$wvf"; fi
checkformat_ip $os
if [[ -z "$os" ]]; then os="$emt"; elif [ "$chk_status" -eq 1 ]; then os="$wvf"; fi
checkformat_ip $version
if [[ -z "$version" ]]; then version="$emt"; elif [ "$chk_status" -eq 1 ]; then version="$wvf"; fi
checkformat_ip $cpuname
if [[ -z "$cpuname" ]]; then cpuname="$emt"; elif [ "$chk_status" -eq 1 ]; then cpuname="$wvf"; fi
checkformat_ip $logonserver
if [[ -z "$logonserver" ]]; then logonserver="$emt"; elif [ "$chk_status" -eq 1 ]; then logonserver="$wvf"; fi
checkformat_ip $loginuser
if [[ -z "$loginuser" ]]; then loginuser="$emt"; elif [ "$chk_status" -eq 1 ]; then loginuser="$wvf"; fi
checkformat_ip $vendor
if [[ -z "$vendor" ]]; then vendor="$emt"; elif [ "$chk_status" -eq 1 ]; then vendor="$wvf"; fi
checkformat_ip $hardwarename
if [[ -z "$hardwarename" ]]; then hardwarename="$emt"; elif [ "$chk_status" -eq 1 ]; then hardwarename="$wvf"; fi
checkformat_ip $biosfirmwaretype
if [[ -z "$biosfirmwaretype" ]]; then biosfirmwaretype="$emt"; elif [ "$chk_status" -eq 1 ]; then biosfirmwaretype="$wvf"; fi
checkformat_ip $hdd
if [[ -z "$hdd" ]]; then hdd="$emt"; elif [ "$chk_status" -eq 1 ]; then hdd="$wvf"; fi

checkformat_n() {
    if [[ "$1" =~ ^[0-9]{1,8}$ ]]; then return 0; else return 1; fi
}


checkformat_ip $uptime
if [[ -z "$uptime" ]]; then uptime="$emt"; elif [ "$chk_status" -eq 1 ]; then uptime="$wvf"; fi
checkformat_ip $cpuload
if [[ -z "$cpuload" ]]; then cpuload="$emt"; elif [ "$chk_status" -eq 1 ]; then cpuload="$wvf"; fi
checkformat_ip $ram
if [[ -z "$ram" ]]; then ram="$emt"; elif [ "$chk_status" -eq 1 ]; then ram="$wvf"; fi
checkformat_ip $freemem
if [[ -z "$freemem" ]]; then freemem="$emt"; elif [ "$chk_status" -eq 1 ]; then freemem="$wvf"; fi
checkformat_ip $hddsize
if [[ -z "$hddsize" ]]; then hddsize="$emt"; elif [ "$chk_status" -eq 1 ]; then hddsize="$wvf"; fi
checkformat_ip $hddfree
if [[ -z "$hddfree" ]]; then hddfree="$emt"; elif [ "$chk_status" -eq 1 ]; then hddfree="$wvf"; fi

create_inventory='{"hostname":"'$hostname'","uuid":"'$uuid'","ip":"'$ip'","os":"'$os'","version":"'$version'","uptime":"'$uptime'","cpuname":"'$cpuname'","cpuload":"'$cpuload'","ram":"'$ram'","freemem":"'$freemem'","logonserver":"'$logonserver'","loginuser":"'$loginuser'","vendor":"'$vendor'","hardwarename":"'$hardwarename'","biosfirmwaretype":"'$biosfirmwaretype'","hdd":"'$hdd'","hddsize":"'$hddsize'","hddfree":"'$hddfree'","externalip":"'$externalip'","gateway":"'$gateway'","dnsserver":"'$dnsserver'"}'
update_inventory='{"uuid":"'$uuid'","ip":"'$ip'","os":"'$os'","version":"'$version'","uptime":"'$uptime'","cpuname":"'$cpuname'","cpuload":"'$cpuload'","ram":"'$ram'","freemem":"'$freemem'","logonserver":"'$logonserver'","loginuser":"'$loginuser'","vendor":"'$vendor'","hardwarename":"'$hardwarename'","biosfirmwaretype":"'$biosfirmwaretype'","hdd":"'$hdd'","hddsize":"'$hddsize'","hddfree":"'$hddfree'","externalip":"'$externalip'","gateway":"'$gateway'","dnsserver":"'$dnsserver'"}'

# Send UPDATE to API
update_response=$(curl --write-out "HTTPSTATUS:%{http_code}" -X PUT -u "$username:$password" "$url/$hostname" -H "Content-Type: application/json" -d "$update_inventory")
duplicate_on_update=$(echo $update_response | grep -Po 'message":"\K[^"]*')


# IF ERROR in UPDATING then CREATE
if [[ $duplicate_on_update == "Error in updating pc" ]]; then
create_response=$(curl --write-out "HTTPSTATUS:%{http_code}" -X POST -u "$username:$password" "$url" -H "Content-Type: application/json" -d "$create_inventory");
fi

# Test Output
echo "Server-Response:$(echo $update_response | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')"
echo "Update-API-Response:$(echo $update_response | grep -Po 'message":"\K[^"]*')"
echo "Create-API-Response:$(echo $create_response | grep -Po 'message":"\K[^"]*')"
echo "Server-Response:$(echo $create_response | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')"
echo "Restful API Inventory | Date: $(date)  

Hostname:$hostname | UUID:$uuid
Update-API-Response:$(echo $update_response | grep -Po 'message":"\K[^"]*')
Server-Response:$(echo $update_response | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')
Create-API-Response:$(echo $create_response | grep -Po 'message":"\K[^"]*')
Server-Response:$(echo $create_response | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

Collected Data:
Hostname                $hostname
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
" >>log_$(date +"%Y_%m_%d").txt
