$processes = Get-Process
$filteredProcesses = $processes | Where-Object { $_.Path -notlike "*system32*" }
$filteredProcesses | Format-Table -AutoSize Name, Id, Path