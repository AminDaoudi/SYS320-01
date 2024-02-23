#Get-Content C:\xampp\apache\logs\access.log
#Get-Content C:\xampp\apache\logs\access.log -Tail 5
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '
#Get-Content C:\xampp\apache\logs\access.log | Select-String -NotMatch '200'
#$A = Get-ChildItem C:\xampp\apache\logs | Select-String 'error'
#$A[-1..-5]

$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

#Define a regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

#Get $notfound records that match to the regex
$ipUnorganized = $regex.Matches($notfounds)

#Get ips as pscustomobject

$ips = @()
for($i=0; $i -lt $ipUnorganized.Count; $i++){
 $ips += [PSCustomobject]@{ "IP" = $ipUnorganized[$i].Value; }
 }
# $ips | Where-Object { $_.IP -ilike "10.*" }

 #count Ips from number 8
 $ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
 $counts = $ipsoftens | Group ip
 $counts | Select-Object Count, Name