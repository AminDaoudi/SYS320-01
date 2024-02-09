﻿ param (
    [int]$NumberOfDays
)

# Function to get Login and logoff records
function Get-LoginLogoutRecords {
    param (
        [int]$NumberOfDays
    )

    $loginouts = Get-Eventlog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(- $NumberOfDays)

    $loginoutsTable = @() # Empty array to fill customly 
    foreach ($logEntry in $loginouts) {
        # Creating Event property value
        $event = ""
        if ($logEntry.EventID -eq 7001) {$event="Logon"}
        if ($logEntry.EventID -eq 7002) {$event="Logoff"}

        # Creating user property value
        $userSID = $logEntry.ReplacementStrings[1]
        $user = (New-Object Security.Principal.SecurityIdentifier($userSID)).Translate([System.Security.Principal.NTAccount]).Value

        # Adding each new line (in form of custom object) to our empty array
        $loginoutsTable += [PSCustomObject]@{
            "Time"  = $logEntry.TimeGenerated
            "Id"    = $logEntry.EventID
            "Event" = $event
            "User"  = $user
        }
    }

    return $loginoutsTable
}

# Function to get Computer start and shut-down records
function Get-ComputerStartShutdownRecords {
    param (
        [int]$NumberOfDays
    )

    $startShutdowns = Get-Eventlog System -After (Get-Date).AddDays(- $NumberOfDays) | Where-Object { $_.EventID -eq 12 -or $_.EventID -eq 6006 }

    $startShutdownsTable = @() # Empty array to fill customly 
    foreach ($logEntry in $startShutdowns) {
        # Creating Event property value
        $event = ""
        if ($logEntry.EventID -eq 12) {$event="Start"}
        if ($logEntry.EventID -eq 6006) {$event="Shutdown"}

        # Creating user property value (constant value for system events)
        $user = "System"

        # Adding each new line (in form of custom object) to our empty array
        $startShutdownsTable += [PSCustomObject]@{
            "Time"  = $logEntry.TimeGenerated
            "Id"    = $logEntry.EventID
            "Event" = $event
            "User"  = $user
        }
    }

    return $startShutdownsTable
}

# Call the functions with the specified number of days
$loginoutsTable = Get-LoginLogoutRecords -NumberOfDays $NumberOfDays
$startShutdownsTable = Get-ComputerStartShutdownRecords -NumberOfDays $NumberOfDays

# Display the results on the screen
$loginoutsTable | Format-Table
$startShutdownsTable | Format-Table