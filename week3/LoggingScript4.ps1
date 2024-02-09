function Get-LoginLogoutRecords {
    param (
        [int]$NumberOfDays
    )

    $loginouts = Get-Eventlog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

    $loginoutsTable = @()
    foreach ($logEntry in $loginouts) {
       
        $event = ""
        if ($logEntry.EventID -eq 7001) {$event="Logon"}
        if ($logEntry.EventID -eq 7002) {$event="Logoff"}

        $userSID = $logEntry.ReplacementStrings[1]
        $user = (New-Object Security.Principal.SecurityIdentifier($userSID)).Translate([System.Security.Principal.NTAccount]).Value

        $loginoutsTable += [PSCustomObject]@{
            "Time"  = $logEntry.TimeGenerated
            "Id"    = $logEntry.EventID
            "Event" = $event
            "User"  = $user
        }
    }

    return $loginoutsTable
}

function Get-ComputerStartShutdownRecords {
    param (
        [int]$NumberOfDays
    )

    $startShutdowns = Get-Eventlog System -After (Get-Date).AddDays(- $NumberOfDays) | Where-Object { $_.EventID -eq 12 -or $_.EventID -eq 6006 }

    $startShutdownsTable = @()
    foreach ($logEntry in $startShutdowns) {

        $event = ""
        if ($logEntry.EventID -eq 12) {$event="Start"}
        if ($logEntry.EventID -eq 6006) {$event="Shutdown"}

        $user = "System"

        $startShutdownsTable += [PSCustomObject]@{
            "Time"  = $logEntry.TimeGenerated
            "Id"    = $logEntry.EventID
            "Event" = $event
            "User"  = $user
        }
    }

    return $startShutdownsTable
}

# Read input directly
$NumberOfDays = Read-Host "Enter the number of days"

$loginoutsTable = Get-LoginLogoutRecords -NumberOfDays $NumberOfDays
$startShutdownsTable = Get-ComputerStartShutdownRecords -NumberOfDays $NumberOfDays

$loginoutsTable | Format-Table
$startShutdownsTable | Format-Table