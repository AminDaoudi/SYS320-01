#Get login and logoff records from windows event
Get-EventLog system -source Microsoft-Windows-WinLogon

$loginouts = Get-EventLog -LogName system -source Microsoft-Windows-WinLogon -EntryType Information -After (Get-Date).AddDays(-14) 
help "service" | select Name, Category, Synopsis | Format-Table -AutoSize -wrap
$loginoutsTable = @()

for ($i=0; $i -lt $loginouts.Count; $i++){


#  Creating event property Value
$event = ""
if($loginouts[$i].InstanceID -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceID -eq "7002") {$event="Logoff"}

# Creating user property value
$user =  $loginouts[$i].ReplacementStrings[1]

# Adding each new line (in the form of a custom object) to our empty array
$loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceID; `
                                    "Event" = $event; `
                                     "User" = $user;
                                   }
}

$loginoutsTable
