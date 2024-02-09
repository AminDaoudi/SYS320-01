#Get login and logoff records from windows event
Get-EventLog system -source Microsoft-Windows-WinLogon

$loginouts = Get-EventLog system -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14) 

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++){


#  Creating event property Value
$event = ""
if($loginouts[$i].InstanceID -eq 7001 -or $loginouts[$i].InstanceId -eq 7002) {

# Creating user property value
    $user =  $loginouts[$i].ReplacementStrings[-1]
}

# Adding each new line (in the form of a custom object) to our empty array
$loginoutsTable += [PSCustomObject]@{ 

                                    "Time"  = $loginouts[$i].DatetanceID

                                    "Event" = $event 

                                    "User"  = $user
                                    }
                                   
}

$loginoutsTable
