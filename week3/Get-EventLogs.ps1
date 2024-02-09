#Get login and logoff records from windows event
Get-EventLog system -source Microsoft-Windows-WinLogon

$loginouts = Get-EventLog -LogName system -Source Microsoft-Windows-* -EntryType Information -After (Get-Date).AddDays(-14)
$loginoutsTable = @()

for ($i=0; $i -lt $loginouts.Count; $i++) {

}

# Creating event property Value
$event = ""
if ($loginouts[$i].EventId -eq 4624) {$event = "Logon"}
if ($loginouts[$i].EventId -eq 4634) {$event = "Logoff"}

# Creating user property value
$user = $loginouts[$i].ReplacementStrings[1]

# Adding each new line (in the form of a custom object) to our empty array
$loginoutsTable += [PSCustomObject]@{
    "Time" = $loginouts[$i].TimeGenerated
    "Id" = $loginouts[$i].EventId
    "Event" = $event
    "User" = $user
}

$loginoutsTable
