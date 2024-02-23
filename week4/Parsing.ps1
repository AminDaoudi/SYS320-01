function ApacheLogs(){
    $logsNotformatted = Get-Content -Path 'c:\xampp\apache\logs\access.log'
    $tableRecords = @()

    for($i=0; $i -lt $logsNotformatted.Count; $i++){
        # Split a string into words
        $words = $logsNotformatted[$i] -split " "

        $tableRecords += [PSCustomObject]@{
            "IP" = $words[0]
            "Time" = $words[3].Trim('[')
            "Method" = $words[4].Trim('"')
            "Page" = $words[5]
            "Protocol" = $words[6]
            "Response" = $words[7]
            "Referrer" = $words[8]
            "Client" = $words[11..($words.Count - 1)]
        }
    } # end of for loop
    return $tableRecords | Where-Object { $_.IP -like "10.*" }
}

$tableRecords = ApacheLogs
$tableRecords | Format-Table -AutoSize -wrap
