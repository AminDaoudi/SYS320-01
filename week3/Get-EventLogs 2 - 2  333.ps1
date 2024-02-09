$loginouts = Get-EventLog system -Source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @()

for ($i = 0; $i -lt $loginouts.Count; $i++){
    $event = ""
    if ($loginouts[$i].InstancdId -eq "7001") { $event = "Logon"}
    if ($loginouts[$i].InstanceId -eq "7002") { $event = "Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]

$loginoutsTable += [PSCustomObject]@{"Time"  = $loginouts[$i].TimeGenerated                   
                                       "Id"  = $loginouts[$i].InstanceId
                                    "Event"  = $event;
                                     "User"  = $user;
                                         }
}

$loginoutsTable