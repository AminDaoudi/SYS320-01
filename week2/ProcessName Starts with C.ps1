$processes = Get-Process | Where-Object { $_.ProcessName -like 'C*' }
$processes | Format-Table -AutoSize Name, Id, ProcessName